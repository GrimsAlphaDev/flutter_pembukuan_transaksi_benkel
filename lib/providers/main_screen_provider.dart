import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/user.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenProvider extends ChangeNotifier {
  final _authService = AuthService();
  User? user;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    // get user info from shared preferences
    final token = await SharedPreferences.getInstance();
    // print(token.getString('token'));

    final response =
        await _authService.getUserInfo(token: token.getString('token')!);

    user = response;
    
    notifyListeners();
  }
}
