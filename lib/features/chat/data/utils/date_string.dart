import 'package:fcc_app_front/features/chat/data/utils/check_first_message.dart';
import 'package:intl/intl.dart';

getDateString(DateTime date) {
  if (isSameDate(
    date,
    DateTime.now(),
  )) return 'Сегодня';
  if (isSameDate(
    date,
    DateTime.now().subtract(
      const Duration(
        days: 1,
      ),
    ),
  )) return 'Вчера';
  return DateFormat('dd.MM.yyyy').format(date);
}
