import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  late Map<String, dynamic> logoutResponse;

  Future<void> logout({required BuildContext context, required int id}) async {
    // remove token from shared preferences
    final token = await SharedPreferences.getInstance();

    final response =
        await _authService.logout(token: token.getString('token')!, id: id);

    token.remove('token');

    logoutResponse = response;

    notifyListeners();
  }
}
