class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  bool isDateMatchedAsWeekDayTo(DateTime anotherDate) {
    return date.year == anotherDate.year &&
        date.month == anotherDate.month &&
        date.day == anotherDate.day;
  }
}
