typedef QueryParams = Map<String, dynamic>;
typedef HttpHeaders = Map<String, String>;

abstract interface class HttpClient {
  Future<T> get<T>(String url,
      {QueryParams queryParams = const {}, HttpHeaders headers = const {}});
}
