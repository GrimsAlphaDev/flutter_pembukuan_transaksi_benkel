import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/product.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/barang_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarangProvider extends ChangeNotifier {
  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;
  List<Product> barangResponse = [];
  // ignore: non_constant_identifier_names
  final BarangService _BarangService = BarangService();

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> getBarang() async {
    final token = await SharedPreferences.getInstance();

    final response =
        await _BarangService.getAllBarang(token: token.getString('token')!);

    barangResponse = response;

    notifyListeners();
  }
}