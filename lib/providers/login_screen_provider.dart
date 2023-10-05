import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/auth_service.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenProvider extends ChangeNotifier {
  final _authService = AuthService();
  late SharedPreferences _loginData;
  late String message;
  late String status;
  String token = '';

  Future<void> login(LoginModel inputCredential) async {
    try {
      final response = await _authService.login(loginData: inputCredential);
      // print(response);
      if (response['status'] == 'success') {
        status = response['status'];
        message = response['message'];
        token = response['token'];
        _loginData = await SharedPreferences.getInstance();
        _loginData.setString('token', token);
        notifyListeners();
      } else {
        status = response['status'];
        message = response['message'];
        notifyListeners();
      }
      // _loginData = await SharedPreferences.getInstance();
      // _loginData.setString('token', token);
    } catch (e) {
      message = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
