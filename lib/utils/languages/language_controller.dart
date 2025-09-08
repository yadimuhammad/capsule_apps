import 'package:capsule_apps/base/base_controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LanguageController extends BaseControllers {
  RxString language = 'English'.obs;

  RxMap<String, String> langEN = <String, String>{}.obs;
  RxMap<String, String> langID = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFallbackStrings();
    getLanguages();
  }

  void _initializeFallbackStrings() {
    // Fallback strings untuk lazy loading
    langEN['dark_mode_str'] = 'Dark Mode';
    langID['dark_mode_str'] = 'Mode Gelap';

    langEN['language_str'] = 'Language';
    langID['language_str'] = 'Bahasa';
  }

  Future getLanguages() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot data;

    //Get all languages in languages collection
    try {
      // Try fetching from server first
      data = await firestore
          .collection('language')
          .get(const GetOptions(source: Source.server));
    } catch (e) {
      // If server fetch fails (e.g., no connection), fallback to cache
      data = await firestore
          .collection('language')
          .get(const GetOptions(source: Source.cache));
    }

    for (var doc in data.docs) {
      if (doc.id == "en") {
        final data = doc.data() as Map<String, dynamic>;
        for (String key in data.keys) {
          langEN[key.toString()] = data[key].toString();
        }
      } else if (doc.id == "id") {
        final data = doc.data() as Map<String, dynamic>;
        for (String key in data.keys) {
          langID[key.toString()] = data[key].toString();
        }
      }
    }
  }
}
