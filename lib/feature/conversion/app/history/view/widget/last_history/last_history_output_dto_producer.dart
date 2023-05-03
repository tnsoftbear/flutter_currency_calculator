import 'package:currency_calc/feature/conversion/app/history/view/widget/dto/history_output_dto.dart';
import 'package:currency_calc/feature/conversion/domain/history/model/conversion_history_record.dart';
import 'package:intl/intl.dart';

class LastHistoryOutputDtoProducer {
  static List<HistoryOutputDto> produce(
      List<ConversionHistoryRecord> records, String localeName) {
    final df = DateFormat.yMMMd(localeName);
    final tf = DateFormat.Hms(localeName);
    final nf = NumberFormat.decimalPattern(localeName);
    final historyOutputDtos = records
        .map((e) => HistoryOutputDto(
            df.format(e.date) + "\n" + tf.format(e.date),
            _formatCurrency(e.sourceAmount, e.sourceCurrency, localeName),
            _formatCurrency(e.targetAmount, e.targetCurrency, localeName),
            nf.format(e.rate)))
        .toList();
    return historyOutputDtos;
  }

  static String _formatCurrency(
      double amount, String currencyCode, String localeName) {
    final format = NumberFormat.simpleCurrency(
      locale: localeName,
      name: currencyCode,
    );
    return format.format(amount);
  }
}
