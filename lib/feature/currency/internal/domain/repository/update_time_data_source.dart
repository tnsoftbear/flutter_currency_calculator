abstract interface class UpdateTimeDataSource {
  Future<DateTime?> loadLastUpdateDate();

  Future<void> saveLastUpdateDateToNow();
}
