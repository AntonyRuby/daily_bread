class DailyReading {
  final String date;
  final String day;
  final String firstTitle;
  final String firstReading;
  final String psalmTitle;
  final String psalmReading;
  final String secondTitle;
  final String secondReading;
  final String gospelTitle;
  final String gospelReading;
  final String saintName;

  DailyReading({
    required this.date,
    required this.day,
    required this.firstTitle,
    required this.firstReading,
    required this.psalmTitle,
    required this.psalmReading,
    required this.secondTitle,
    required this.secondReading,
    required this.gospelTitle,
    required this.gospelReading,
    required this.saintName,
  });

  factory DailyReading.fromJson(String date, Map<String, dynamic> json) {
    final readings = json['readings'] ?? {};
    return DailyReading(
      date: date,
      day: readings['day'] ?? '',
      firstTitle: readings['first'] ?? '',
      firstReading: readings['first_reading'] ?? '',
      psalmTitle: readings['psalm'] ?? '',
      psalmReading: readings['psalm_reading'] ?? '',
      secondTitle: readings['second'] ?? '',
      secondReading: readings['second_reading'] ?? '',
      gospelTitle: readings['gospel'] ?? '',
      gospelReading: readings['gospel_reading'] ?? '',
      saintName: json['saint'] ?? '',
    );
  }
}
