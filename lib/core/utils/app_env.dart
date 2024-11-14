import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static String get apiBaseURL => dotenv.env['BASE_URL'] ?? '';
}
