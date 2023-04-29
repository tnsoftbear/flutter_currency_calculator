abstract class RateCacher {
  Future<double?> get(String from, String to);
  Future<void> set(String from, String to, double rate);
}
