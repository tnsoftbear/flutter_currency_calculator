import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:dio/dio.dart';

class DioHttpClient implements HttpClient {
  final Dio _dio = Dio();

  @override
  Future<T> get<T>(String url,
      {QueryParams queryParams = const {},
        HttpHeaders headers = const {}}) async {
    if (queryParams.length > 0) {
      url = url + '?' + Uri(queryParameters: queryParams).query;
    }
    final options = Options(headers: headers);
    try {
      final response = await _dio.get<T>(url, options: options);
      if (response.statusCode == 200) {
        return response.data as T;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
