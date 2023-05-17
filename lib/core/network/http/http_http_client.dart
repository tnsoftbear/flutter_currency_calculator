import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:http/http.dart' as http;

class HttpHttpClient implements HttpClient {
  @override
  Future<T> get<T>(String url,
      {QueryParams queryParams = const {},
      HttpHeaders headers = const {}}) async {
    if (queryParams.length > 0) {
      url = url + '?' + Uri(queryParameters: queryParams).query;
    }
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body as T;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
