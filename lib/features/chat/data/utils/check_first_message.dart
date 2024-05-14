
// bool checkFirstMessage(MessageModel message, MessageModel? messageBefore) {
//   if (messageBefore == null) return true;
//   return !isSameDate(
//     message.createdDate ?? DateTime.now(),
//     messageBefore.createdDate ?? DateTime.now(),
//   );
// }

// bool isSameDate(
//   DateTime firstDate,
//   DateTime secondDate,
// ) {
//   return firstDate.year == secondDate.year && firstDate.month == secondDate.month && firstDate.day == secondDate.day;
// }

// int daysBetween(
//   DateTime from,
//   DateTime to,
// ) {
//   from = DateTime(from.year, from.month, from.day);
//   to = DateTime(to.year, to.month, to.day);
//   return (to.difference(from).inHours / 24).round();
// }
