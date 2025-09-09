# capsule_apps

*how to start*
1. clone this repo
2. replace `google-services.json` and `GoogleService-Info.plist` in `.firebase` folder with your own firebase project
3. replace com.capsuleapps.id in `flavorizr.yaml` with your own bundle id
4. run `flutter pub run flutter_flavorizr` to generate and update the new flavor
5. run `flutter run --flavor dev` to run the app

*Theme* ->
To change the theme as for now we using flex_color_scheme, go to playground [here](https://flexcolorscheme.com/) and choose the theme you like -> copy the code -> paste it to `lib/utils/themes/app_theme.dart`, for futher reference you can look at their [documentation](https://pub.dev/packages/flex_color_scheme).

*Language* -> 
we use firestore to store the language, so we can easily add new language.
To add new language, add the language code to Firebase firestore database collection `language` 
To use the language, you can use `'key_str'.tr` to get the translated string.

*Flavor* ->
as for now we have 3 flavors, which are production, staging, and dev. To add new flavor, edit `flavorizr.yaml` and run `flutter pub run flutter_flavorizr` to generate the new flavor. For futher reference you can look at their [documentation](https://pub.dev/packages/flutter_flavorizr).

*env* ->
we use flutter_dotenv to manage our environment variables, to add new env, add the env to `.dev.env` or `.prod.env` and load it in `main.dart`	

*MVC* ->
we use MVC pattern for this project, so to add new page, you can create new file in `lib/pages`, to add new controller, you can create new file in `lib/controllers`, and to add new model, you can create new file in `lib/models`.

*Component* ->
we use getx for state management, so to add new page, you can create new file in `lib/pages`, for navigating we use `Get.to(() => NewPage())`
