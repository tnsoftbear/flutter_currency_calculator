import 'package:currency_calc/core/network/http/exception/could_not_fetch_any_http_response.dart';
import 'package:currency_calc/core/network/http/exception/could_not_fetch_success_http_response.dart';
import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:dio/dio.dart';

final class DioHttpClient implements HttpClient {
  DioHttpClient([Dio? dio]) {
    _dio = dio ?? Dio();
  }

  late final Dio _dio;

  @override
  Future<T> get<T>(String url,
      {QueryParams queryParams = const {},
      HttpHeaders headers = const {}}) async {
    if (queryParams.length > 0) {
      url = url + '?' + Uri(queryParameters: queryParams).query;
    }
    final Options options = Options(headers: headers);
    late final Response response;
    try {
      response = await _dio.get<T>(url, options: options);
    } on DioError catch (e) {
      throw CouldNotFetchAnyHttpResponse(reasonPhrase: e.message.toString());
    }

    if (response.statusCode == 200) {
      return response.data as T;
    } else {
      throw CouldNotFetchSuccessHttpResponse(
          reasonPhrase: response.statusMessage,
          statusCode: response.statusCode);
    }
  }
}
