import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../base/base_controllers.dart';
import '../utils/keys.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseApi extends GetConnect {
  late SharedPreferences prefs;
  @override
  void onInit() async {
    httpClient.baseUrl = baseUrl;
    httpClient.timeout = const Duration(seconds: 15);
    prefs = await SharedPreferences.getInstance();

    setupRequestModifier();
  }

  setupRequestModifier() {
    // Additional headers
    httpClient.addRequestModifier((Request request) {
      String token = prefs.getString(kStorageToken) ?? '';
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Cookie'] = "jwt=$token";
      request.headers['Accept'] = 'application/json';
      // request.headers['fcm_token'] = '${Configs.instance().fcmToken}';
      // _print(doPrint: true, data: token);
      _print(doPrint: false, data: request.headers);
      _print(doPrint: false, data: request.files);
      return request;
    });
  }

  /// BASE FUNCTIONS
  Future<void> apiFetch({
    required String url,
    required BaseControllers controller,
    int code = 1,
    bool debug = false,
  }) async {
    try {
      _print(doPrint: debug, data: url);
      final response = await get(url);
      _print(doPrint: debug, data: response.body);
      if (response.status.hasError) {
        return controller.loadFailed(requestCode: code, response: response);
      }

      return controller.loadSuccess(
        requestCode: code,
        response: response.body,
        statusCode: response.status.code ?? 0,
      );
    } catch (e) {
      // return controller.loadError(e);
    }
  }

  Future<void> apiPatch({
    required String url,
    required BaseControllers controller,
    required Map data,
    int code = 1,
    bool debug = false,
  }) async {
    try {
      // print(url);
      _print(doPrint: debug, data: url);
      _print(doPrint: debug, data: data);
      final response = await patch(url, data);
      _print(doPrint: debug, data: response.body);

      if (response.status.hasError) {
        _print(doPrint: debug, data: 'Error : $url');
        return controller.loadFailed(requestCode: code, response: response);
      }

      return controller.loadSuccess(
        requestCode: code,
        response: response.body,
        statusCode: response.status.code ?? 0,
      );
    } catch (e) {
      // return controller.loadError(
      //   e,
      // );
    }
  }

  Future<void> apiPost({
    required String url,
    required BaseControllers controller,
    required var data,
    int code = 1,
    bool debug = false,
  }) async {
    try {
      _print(doPrint: debug, data: url);
      final response = await post(
        url,
        data,
      ).timeout(const Duration(seconds: 30));
      _print(doPrint: debug, data: data);
      _print(doPrint: debug, data: response.body);

      if (response.status.hasError) {
        _print(doPrint: debug, data: 'Error : $url');
        return controller.loadFailed(requestCode: code, response: response);
      }

      return controller.loadSuccess(
        requestCode: code,
        response: response.body,
        statusCode: response.status.code ?? 0,
      );
    } catch (e) {
      // return controller.loadError(e);
    }
  }

  Future<void> apiDelete({
    required String url,
    required BaseControllers controller,
    required Map<String, dynamic> data,
    int code = 1,
    bool debug = false,
  }) async {
    try {
      _print(doPrint: debug, data: url);
      final response = await delete(url, query: data);

      _print(doPrint: debug, data: response.body);

      if (response.status.hasError) {
        _print(doPrint: debug, data: 'Error : $url');
        return controller.loadFailed(requestCode: code, response: response);
      }

      return controller.loadSuccess(
        requestCode: code,
        response: response.body,
        statusCode: response.status.code ?? 0,
      );
    } catch (e) {
      // controller.loadError(e);
    }
  }

  Future<void> apiPostFile({
    required String url,
    required BaseControllers controller,
    required File file,
    int code = 1,
    bool debug = false,
  }) async {
    try {
      String token = prefs.getString(kStorageToken) ?? '';

      httpClient.addRequestModifier((Request request) {
        if (token != '') {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return request;
      });
      final form = FormData({
        'images': MultipartFile(file, filename: 'avatar.png'),
      });
      _print(doPrint: debug, data: url);
      final response = await post(
        url,
        form,
      ).timeout(const Duration(seconds: 10));
      _print(doPrint: debug, data: response.body);

      if (response.status.hasError) {
        _print(doPrint: debug, data: 'Error : $url');
        return controller.loadFailed(requestCode: code, response: response);
      }

      return controller.loadSuccess(
        requestCode: code,
        response: response.body,
        statusCode: response.status.code ?? 0,
      );
    } catch (e) {
      // controller.loadError(e);
    }
  }

  void _print({bool doPrint = false, dynamic data}) {
    if (doPrint) {
      try {
        log(json.encode(data));
      } catch (e) {
        log(data.toString());
      }
    }
  }
}
