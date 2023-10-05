import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/product.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/sales_service.dart';

class PenjualanScreenProvider extends ChangeNotifier {
  int _selectedIndex = 2;
  int get selectedIndex => _selectedIndex;

  DateTime? startDate;
  DateTime? endDate;

  late List<Product> products;

  PenjualanScreenProvider() {
    // _init();
  }

  void test() async {
    products = await SalesService().getAllProduct(
        token:
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNGZiNDBiODBjZmZjYWJlMzdmNTEzMWJiYTBjY2NhMThkOGE1YmRhZmRlNjQ5Nzc3NjdjN2Q0MDUxNDU5Njk3NWNiMGZiMTdkNTE3NjgxNWYiLCJpYXQiOjE2OTY0MDA5MTEuNzE2MTkyLCJuYmYiOjE2OTY0MDA5MTEuNzE2MTk5LCJleHAiOjE3MjgwMjMzMTEuNzA5MTQ2LCJzdWIiOiIxNSIsInNjb3BlcyI6W119.T9cx-rmXfMBHa52oIiPL8kmNJjYsXqcJKsmjpWZZFSthZJa8OUdAl47vuBu9o-T3n9UMu0T71-tUkjH4q4U-gRDtW4AIi1pb1xIWX93Ulf5MndVEhZHZXzOhzFFDbl-FCYmtPNczbeoD9pYE9cYHvJac35Tt3gCv2914WYyeuu0Ag1VEAdilLRIpD2BG6g9dFRCV5_ck3Vsgf4IwI7a-Hd_ohDHmJelapN8Mpud91A5xgDbaBOpUDuMbQJ3iPmMV8riJ3YfRSDuuxsEQQ2zCvRrROBsyJ3Outi_jcmEM7mssdNfpipFupDgocCWbjokA4bkF30ysazdPzd6VBuWaBZn-AmtPVT0dVxAgSpjPRbr64wzICFVyD9WpZ6p9dab-X0Y47d7iHcV2MakU9fsIjCAi10V32BYkxAdV_4hiUkE3_CYEmre2YbzjR32nmXPq1QGMtgOe7V_pAOCeKUHKLp5E1t7uouj7YeYUbZNK7ggkFm6LPE9LBW3Ldwdkj-1NYtTMVZAM5JBANmjWuLN1c0_Me7Szf67WEEMnWc3GN2SOQyQf0j8GyCkZmVV46OR_bCDeNFNoHc0sAPQsm6Rpsu6jXzdJ6kaf_iGuraARKLj8OBeN6HqrbbvL-jF_FEbsatZAQehffEBY8GFws9Z4_esdj7Wfbo8tRB_LHPRY8c4');
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
