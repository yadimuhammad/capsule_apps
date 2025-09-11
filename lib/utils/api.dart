import '../base/base_api.dart';
import '../utils/env_loader.dart';

String baseUrl = EnvLoader.get("BASE_URL");

class Api extends BaseApi {}
