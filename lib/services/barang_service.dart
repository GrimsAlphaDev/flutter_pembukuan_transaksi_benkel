import 'package:dio/dio.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/product.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/api/endpoint.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/api/interceptor.dart';

class BarangService extends InterceptorApi {
  Future<List<Product>> getAllBarang({required String token}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.products;
      final Response response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      final List<Product> products;

      products = (response.data['data'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();

      return products;
    } catch (e) {
      throw Exception(e);
    }
  }
}
