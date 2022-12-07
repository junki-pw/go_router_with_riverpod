import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginInfo extends ChangeNotifier {
  bool isLogin = false;

  void updateLoginStatus() {
    isLogin = !isLogin;
    notifyListeners();
  }
}

final goNotifyProvider = Provider((ref) {
  return LoginInfo();
});
