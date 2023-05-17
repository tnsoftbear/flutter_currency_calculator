import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:currency_calc/feature/history/internal/ui/widget/history_output/history_output_dto.dart';
import 'package:intl/intl.dart';

final class HistoryOutputDtoProducer {
  static List<HistoryOutputDto> produce(
      List<ConversionHistoryRecord> records, String localeName) {
    final df = DateFormat.yMMMd(localeName);
    final tf = DateFormat.Hms(localeName);
    final nf = NumberFormat.decimalPattern(localeName);
    final historyOutputDtos = records
        .map((r) => HistoryOutputDto(
            df.format(r.date.toLocal()) + "\n" + tf.format(r.date.toLocal()),
            _formatCurrency(r.sourceAmount, r.sourceCurrencyCode, localeName),
            _formatCurrency(r.targetAmount, r.targetCurrencyCode, localeName),
            nf.format(r.rate)))
        .toList();
    return historyOutputDtos;
  }

  static String _formatCurrency(
      double amount, String currencyCode, String localeName) {
    final format = NumberFormat.currency(
      locale: localeName,
      name: currencyCode,
    );
    return format.format(amount);
  }
}
