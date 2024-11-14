import 'package:marketplace/core/utils/app_env.dart';

/// All the endpoint used in this project are to be declared
/// in this class.
///
/// Example
///
/// static Uri authUrl =
///  Uri(scheme: 'https', host: 'test.com', path: '/api/v1/auth')
class AppApiEndpoint {
  const AppApiEndpoint._();

  static const scheme = 'https';
  static String host = AppEnv.apiBaseURL;
  static const int receiveTimeout = 50000;
  static const int sendTimeout = 50000;

  static String baseUri = '$scheme://$host//';

  static const getAccessToken = 'auth/refresh-token';
  static const login = 'auth/login';
  static const getProfile = 'auth/profile';
  static const createUser = 'users/';
  static const updateUser = 'users/';
  static const categories = 'categories';
  static const products = 'products';
}
