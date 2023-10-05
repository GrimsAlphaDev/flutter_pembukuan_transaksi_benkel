import 'package:dio/dio.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/user.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/api/endpoint.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/api/interceptor.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/login.dart';

class AuthService extends InterceptorApi {
  Future<Map<String, dynamic>> login({required LoginModel loginData}) async {
    late Map<String, dynamic> apiResponse;
    try {
      const String url = Endpoint.baseUrl + Endpoint.login;
      final Response response = await dio.post(
        url,
        data: {
          'email': loginData.email,
          'password': loginData.password,
        },
      );
      // print(response);
      if (response.data['status'] == 'success') {
        apiResponse = {
          'status': response.data['status'],
          'message': response.data['message'],
          'token': response.data['data']['token'],
        };
      } else {
        apiResponse = {
          'status': response.data['status'],
          'message': response.data['message'],
        };
      }

      // return apiResponse;
      return apiResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> getUserInfo({required String token}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.getUser;
      final Response response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      return User.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> logout(
      {required String token, required int id}) async {
    late Map<String, dynamic> apiResponse;
    try {
      const String url = Endpoint.baseUrl + Endpoint.logout;
      final Response response = await dio.get(
        url,
        queryParameters: {
          'id': id,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.data['status'] == 'success') {
        apiResponse = {
          'status': response.data['status'],
          'message': response.data['message'],
        };
      } else {
        apiResponse = {
          'status': response.data['status'],
          'message': response.data['message'],
        };
      }

      return apiResponse;
    } catch (e) {
      throw Exception(e);
    }
  }
}
