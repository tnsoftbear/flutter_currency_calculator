import 'dart:convert';

final class FawazAhmedRateData {
  final String date;
  final double rate;

  FawazAhmedRateData({
    required this.date,
    required this.rate,
  });

  factory FawazAhmedRateData.fromJson(
      String encodedJson, String sourceCurrencyCode, String targetCurrency) {
    Map<String, dynamic> encodedMap = json.decode(encodedJson);
    return FawazAhmedRateData(
      date: encodedMap['date'] as String,
      rate: encodedMap[sourceCurrencyCode.toLowerCase()]
          [targetCurrency.toLowerCase()] as double,
    );
  }
}
