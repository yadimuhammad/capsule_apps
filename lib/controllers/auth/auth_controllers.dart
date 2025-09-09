import 'package:capsule_apps/models/auth/user_models.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoggedIn = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Check if user is already logged in
  Future<void> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');

      if (userData != null) {
        final userMap = jsonDecode(userData);
        currentUser.value = UserModel.fromJson(userMap);
        isLoggedIn.value = true;
      }
    } catch (e) {
      print('Error checking login status: $e');
    }
  }

  // Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled sign in
        return false;
      }

      // final GoogleSignInAuthentication googleAuth =
      //     await googleUser.authentication;

      // Create user model
      final user = UserModel(
        id: googleUser.id,
        name: googleUser.displayName ?? '',
        email: googleUser.email,
        photoUrl: googleUser.photoUrl,
        provider: 'google',
      );

      await _saveUserData(user);
      currentUser.value = user;
      isLoggedIn.value = true;

      Get.snackbar(
        'Success',
        'Welcome ${user.name}!',
        snackPosition: SnackPosition.TOP,
      );

      return true;
    } catch (error) {
      Get.snackbar(
        'Error',
        'Google sign in failed: $error',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Apple Sign In
  Future<bool> signInWithApple() async {
    try {
      // Check if Apple Sign In is available
      if (!Platform.isIOS) {
        Get.snackbar(
          'Error',
          'Apple Sign In is only available on iOS',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }

      isLoading.value = true;

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your.app.bundle.id',
          redirectUri: Uri.parse('https://your-app.com/auth/callback'),
        ),
      );

      // Create user model
      final name = credential.givenName != null && credential.familyName != null
          ? '${credential.givenName} ${credential.familyName}'
          : credential.email?.split('@').first ?? 'Apple User';

      final user = UserModel(
        id: credential.userIdentifier ?? '',
        name: name,
        email: credential.email ?? '',
        photoUrl: null,
        provider: 'apple',
      );

      await _saveUserData(user);
      currentUser.value = user;
      isLoggedIn.value = true;

      Get.snackbar(
        'Success',
        'Welcome ${user.name}!',
        snackPosition: SnackPosition.TOP,
      );

      return true;
    } catch (error) {
      Get.snackbar(
        'Error',
        'Apple sign in failed: $error',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Save user data to local storage
  Future<void> _saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
    await prefs.setBool('is_logged_in', true);
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      isLoading.value = true;

      // Sign out from Google
      if (currentUser.value?.provider == 'google') {
        await _googleSignIn.signOut();
      }

      // Clear local data
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_data');
      await prefs.setBool('is_logged_in', false);

      currentUser.value = null;
      isLoggedIn.value = false;

      Get.snackbar(
        'Success',
        'Signed out successfully',
        snackPosition: SnackPosition.TOP,
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        'Sign out failed: $error',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Skip login (continue as guest)
  Future<void> skipLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('login_skipped', true);
    Get.offAllNamed('/home');
  }
}
