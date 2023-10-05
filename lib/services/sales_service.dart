import 'package:dio/dio.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/product.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/api/endpoint.dart';
import 'package:flutter_pembukuan_transaksi_benkel/services/api/interceptor.dart';

class SalesService extends InterceptorApi {
  Future<List<Product>> getAllProduct({required String token}) async {
    try {
      const String url = Endpoint.baseUrl + Endpoint.products;
      final Response response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjZiOGZlM2I0Mjg1YWE3M2Q5NmNiNmQ0MTUwZjQ3ZjJmMWRmYmQzYWEzZDM0MzBiMDI0ZmYwN2UxOWIwZTY2NWM1Y2Q1ZDVjOTFkZWRmZDIiLCJpYXQiOjE2OTYzOTk0MzAuMTg3MzY2LCJuYmYiOjE2OTYzOTk0MzAuMTg3MzcyLCJleHAiOjE3MjgwMjE4MzAuMDgyOTY3LCJzdWIiOiIxNSIsInNjb3BlcyI6W119.fvobOPO1SCGIbZoX9HilhJfpWfSpCT7hWs2QvqYnaqZVSS478Jh5w1bHQXlP-1FAPib42_tqWW_RMBMkZZ-sARTty_-SCJ6dekO76PJt0B4By9iG-Tj7Jw3xetUB1TADIDVzlbqZ1civem8H5dB5R5qhscRnLrZNlCRK7jd41I3Mej9TjJxLjBZJoKSUzzfmrIPAL0HmwTV0mcG7TVMfNboC74dmrfDpbzAgEzB6UnZ_Wy8xEgjsSRRvKO1d64H-xYZYnE4OtLgL3ZaGz_Hcci6dwJ_aQpPn39bCDj0dVq4Mj1aBR5iXGn02mgG-DAG3p2yZaXBkUoYbcf0bUtfUGq09L9KtjgZdNX0obft3I2srv0JcbKGCqUyDHeDwIsj0iQIqvtGNY8csMqFjKLvtuykIwIhET9olVfqQAZ5AAx0voWDWvyqL1bQwAwPmynIB5UxdP080saBSpHWplgjre7U2Y2nk34DRnCaZ6rptae6zqxf4ae6ecE5ifinkKrKXNZMMOp9XvWNt0Kpo9859OmojlUyCC8mML2KTb_7u7hA7JAh-LpL9NRMgjbO1Nt1Kw_wdtRPT3felq5wmzgNXk-9k-RxnuTgZS1TLCVnkO295b0ag2dtGl_lqPqDw2_G6GsdGgKh6Za-oE-WNO9JnXhomyQajIp248_ojWpdRd5w',
        }),
      );

      // print(response.data['data']);

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
