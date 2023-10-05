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

  Future<List<Product>> searchBarang(
      {required String token, required String query}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.filterProduct;

      final Response response = await dio.get(
        url,
        queryParameters: {
          'query': query,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.data['data'] == null) {
        return [];
      }

      final List<Product> products;
      products = (response.data['data'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();

      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> createBarang(
      {required Product barang, required String token}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.products;

      final Response response = await dio.post(
        url,
        data: barang.toJson(),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
