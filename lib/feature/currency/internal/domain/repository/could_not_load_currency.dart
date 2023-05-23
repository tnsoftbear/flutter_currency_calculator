class CouldNotLoadCurrency implements Exception {
  final String message;

  CouldNotLoadCurrency(this.message);

  CouldNotLoadCurrency.fromCode(String currencyCode)
      : message = 'Could not load currency by code: $currencyCode';
}
