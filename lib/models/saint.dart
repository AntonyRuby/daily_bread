class Saint {
  final String name;
  final String period;
  final String imagePath;
  final String about;

  Saint({
    required this.name,
    required this.period,
    required this.imagePath,
    required this.about,
  });

  factory Saint.fromJson(String name, Map<String, dynamic> json) {
    return Saint(
      name: json['name'] ?? name.replaceAll("Saint ", "").replaceAll("Blessed ", "").replaceAll("Saints ", ""),
      period: json['period'] ?? '',
      imagePath: "asset/images/" + (json['img'] ?? ''),
      about: json['about'] ?? '',
    );
  }
}
