import 'package:currency_calc/core/network/http/exception/could_not_fetch_any_http_response.dart';

throwException() {
  throw CouldNotFetchAnyHttpResponse(message: "This is an exception", reasonPhrase: "This is a reason phrase");
}

void main() {
  try {
    throwException();
  } on CouldNotFetchAnyHttpResponse catch (e) {
    print(e.toString());
    print('message: ' + e.message);
    print('reasonPhrase: ' + e.reasonPhrase);
  }
}