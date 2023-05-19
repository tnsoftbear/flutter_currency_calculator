import 'package:currency_calc/core/network/http/exception/could_not_fetch_any_http_response.dart';
import 'package:currency_calc/core/network/http/exception/could_not_fetch_success_http_response.dart';
import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:http/http.dart' as http;

class HttpHttpClient implements HttpClient {
  HttpHttpClient([http.Client? client]) {
    _client = client ?? http.Client();
  }

  late final http.Client _client;

  @override
  Future<T> get<T>(String url,
      {QueryParams queryParams = const {},
      HttpHeaders headers = const {}}) async {
    if (queryParams.length > 0) {
      url = url + '?' + Uri(queryParameters: queryParams).query;
    }
    Uri uri = Uri.parse(url);
    late final http.Response response;
    try {
      response = await _client.get(uri, headers: headers);
    } catch (e) {
      throw CouldNotFetchAnyHttpResponse(reasonPhrase: e.toString());
    }

    if (response.statusCode == 200) {
      return response.body as T;
    } else {
      throw CouldNotFetchSuccessHttpResponse(
          reasonPhrase: response.reasonPhrase,
          statusCode: response.statusCode);
    }
  }
}
