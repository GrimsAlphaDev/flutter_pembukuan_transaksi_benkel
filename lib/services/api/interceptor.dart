import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/mainscreen.dart';

class InterceptorApi {
  final Dio _dio = Dio();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Dio get dio => _dio;

  InterceptorApi() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response!.statusCode == 401) {
            showDialog(
              context: navigatorKey.currentContext!,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 90),
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: const BorderSide(color: Colors.grey, width: .5),
                  ),
                  title: const Icon(Icons.sms_failed, color: Colors.red, size: 50),
                  content: const Text(
                    'Session Expired',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.amber, fontSize: 12),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                            (route) => false);
                        // final loginData = await SharedPreferences.getInstance();
                        // loginData.remove('token');
                        return handler.next(e);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            final messageError =
                e.response!.data['message'] ?? 'Something went wrong';
            // return error
            // print(e.response!.data['message']);
            //         print(e.response!.data['message']);
            showDialog(
              context: navigatorKey.currentContext!,
              barrierDismissible: false,
              builder: (context) {
                Timer(
                  const Duration(seconds: 2),
                  () => Navigator.of(context).pop(),
                );
                return AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 90),
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: const BorderSide(color: Colors.grey, width: .5),
                  ),
                  title: const Icon(Icons.sms_failed, color: Colors.red, size: 50),
                  content: Text(
                    messageError,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.amber, fontSize: 12),
                  ),
                );
              },
            ).then(
              (value) {
                return handler.next(e);
              },
            );
          }
        },
      ),
    );
    // _dio.options.headers['Content-Type'] = 'application/json';
  }
}
