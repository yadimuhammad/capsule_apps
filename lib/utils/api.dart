import 'package:capsule_apps/base/base_api.dart';
import 'package:capsule_apps/utils/env_loader.dart';

String baseUrl = EnvLoader.get("BASE_URL");

class Api extends BaseApi {}
