class ConversionValidationResult {
  static const int ERR_SOURCE_CURRENCY_INVALID = 1;
  static const int ERR_TARGET_CURRENCY_INVALID = 2;
  static const int ERR_SOURCE_AND_TARGET_CURRENCY_SAME = 3;
  static const int ERR_SOURCE_AMOUNT_NOT_NUMERIC = 4;
  static const int ERR_SOURCE_AMOUNT_NOT_POSITIVE = 5;

  final List<int> _errors = [];

  ConversionValidationResult();

  void addError(int error) {
    _errors.add(error);
  }

  bool isSuccess() {
    return _errors.isEmpty;
  }

  List<int> get errors => _errors;
}
