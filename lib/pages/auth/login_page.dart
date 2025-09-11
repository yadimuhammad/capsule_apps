import '../../controllers/auth/auth_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryFixedDim,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (authController.isLoggedIn.value) {
              return _buildWelcomeBackScreen(context);
            } else {
              return _buildLoginScreen(context);
            }
          }),
        ),
      ),
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: authController.skipLogin,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white.withValues(alpha: 0.8),
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              // Header Section
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.rocket_launch,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Sign in to continue your journey and unlock personalized features',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Choose your preferred sign-in method',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Login Form Section
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: authController.isLoading.value
                            ? null
                            : () async {
                                final success = await authController
                                    .signInWithGoogle();
                                if (success) {
                                  // Auto navigate after success
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      Get.offAllNamed('/home');
                                    },
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.95),
                          foregroundColor: const Color(0xFF1a73e8),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        icon: Image.network(
                          'https://developers.google.com/identity/images/g-logo.png',
                          height: 20,
                          width: 20,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.login, size: 20);
                          },
                        ),
                        label: const Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Apple Sign In Button (only show on iOS)
                    if (Platform.isIOS)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: authController.isLoading.value
                              ? null
                              : () async {
                                  final success = await authController
                                      .signInWithApple();
                                  if (success) {
                                    // Auto navigate after success
                                    Future.delayed(
                                      const Duration(seconds: 2),
                                      () {
                                        Get.offAllNamed('/home');
                                      },
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.95,
                            ),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.apple, size: 20),
                          label: const Text(
                            'Continue with Apple',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Secure Sign In',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Terms and Privacy
                    Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.7),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Loading Overlay
        Obx(
          () => authController.isLoading.value
              ? Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildWelcomeBackScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(Icons.waving_hand, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 40),
          const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Text(
              'Great to see you again, ${authController.currentUser.value?.name ?? 'User'}!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed('/home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                ),
              ),
              child: const Text(
                'Continue to App',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
