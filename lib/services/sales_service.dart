import 'package:dio/dio.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/penjualan.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/api/endpoint.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/api/interceptor.dart';

class SalesService extends InterceptorApi {
  Future<List<Penjualan>> getPenjualan({required String token}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getSales;
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final List<Penjualan> penjualanList = [];

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        final Penjualan penjualan = Penjualan.fromJson(responseData);

        penjualanList.add(penjualan);
      }

      return penjualanList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
