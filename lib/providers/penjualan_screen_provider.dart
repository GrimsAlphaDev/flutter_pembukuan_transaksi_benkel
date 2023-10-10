import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/penjualan.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/sales_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenjualanScreenProvider extends ChangeNotifier {
  int _selectedIndex = 2;
  int get selectedIndex => _selectedIndex;

  final SalesService _salesService = SalesService();
  DateTime? startDate;
  DateTime? endDate;

  List<Penjualan?> penjualanList = [];

  Future<void> getPenjualan() async {
    // token
    final token = await SharedPreferences.getInstance();

    final response =
        await _salesService.getPenjualan(token: token.getString('token')!);

    penjualanList = response;

    notifyListeners();
  }

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void filterDate(DateTime? start, DateTime? end) {
    startDate = start;
    endDate = end;
    notifyListeners();
  }
}
