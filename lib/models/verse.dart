class Verse {
  final String date;
  final String text;

  Verse({required this.date, required this.text});

  factory Verse.fromJson(String date, Map<String, dynamic> json) {
    return Verse(
      date: date,
      text: json['verse'] ?? '',
    );
  }
}
