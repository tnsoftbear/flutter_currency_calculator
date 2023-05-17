import 'dart:convert';

final class FawazAhmedRateData {
  final String date;
  final double rate;

  FawazAhmedRateData({
    required this.date,
    required this.rate,
  });

  factory FawazAhmedRateData.fromJson(
      String decodedJson, String targetCurrency) {
    Map<String, dynamic> encoded = json.decode(decodedJson);
    return FawazAhmedRateData(
      date: encoded['date'] as String,
      rate: encoded[targetCurrency.toLowerCase()] as double,
    );
  }
}
