import '../utils/utils.dart';
import 'package:get/get.dart';

abstract class BaseControllers extends GetxController {
  RxBool loading = false.obs;
  Rx<ControllerState> state = ControllerState.firstLoad.obs;
  // final Api api = Get.put(Api(), tag: Utils.getRandomString());

  void setLoading(bool isLoading) {
    loading.value = isLoading;
    if (isLoading) {
      state.value = ControllerState.loading;
    } else {
      state.value = ControllerState.loadingSuccess;
    }
  }

  RxBool get isLoading {
    return loading;
  }

  void load() {
    // setLoading(true);
  }

  void loadSuccess({
    required int requestCode,
    required response,
    required int statusCode,
  }) {
    setLoading(false);
    state.value = ControllerState.loadingSuccess;
  }

  void loadFailed({
    required int requestCode,
    required Response<dynamic> response,
  }) {
    if (response.statusCode == 503) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        // Utils.popup(body: 'Hmm, something went wrong, try again in a few seconds.', type: kPopupFailed);
      });
    }
    setLoading(false);
    state.value = ControllerState.loadingFailed;
  }

  void loadError(e, {Response<dynamic>? response}) async {
    setLoading(false);

    state.value = ControllerState.loadingFailed;
  }
}
