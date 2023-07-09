import 'package:flutter/foundation.dart';

class Constant {
  static const String baseUrl = 'http://demo-api.mr-dev.tech/api';
}

class Endpoints {
  static const String baseUrl =
      'https://mohammedashrafdagga.pythonanywhere.com';

  // auth endpoint
  static const String login = '/api/auth/login/';

  static const String register = '/api/auth/register/';
  static const String verifyCode = '/api/auth/verify-code/';
  static const String sendCodeToResetPassword =
      '/api/auth/reset-password-code/';

  static const String verifyResetPasswordCode =
      '/api/auth/verify-reset-password-code/';
  static const String resetNewPassword = '/api/auth/reset-new-password/';
  static const String resendCode = '/api/auth/resend-code/';
  static const String logout = '/api/auth/logout/';

  //home service screen
  static const String categories = '/api/services/categories/';
  static const String recentSearches = '/api/services/';
}

void printTest(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}
