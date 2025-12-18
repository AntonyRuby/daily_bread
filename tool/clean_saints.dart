import 'dart:convert';
import 'dart:io';

void main() {
  final files = [
    'asset/en/saints.json',
    'asset/ta/saints.json',
  ];

  final keywordsToRemove = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Week",
    "Octave",
    "Advent",
    "Lent",
    "Easter",
    "Christmas",
    "Ordinary Time",
    "Ash Wednesday",
    "Pentecost",
    "Ascension",
    "Trinity",
    "Corpus Christi",
    "Sacred Heart",
    "Christ the King",
    "Family",
    "Mother of God",
    "Presentation",
    "Transfiguration",
    "Exaltation",
    "Dedication",
    "Immaculate Conception",
    "Nativity",
    "Visitation",
    "Annunciation",
    "Assumption",
    "Queenship",
    "All Saints",
    "All Souls",
    "Chair of",
    "Conversion of",
    "Baptism of",
  ];

  // Additional specific non-saint entries found during analysis
  final specificRemovals = [
    "The Story of the Solemnity of All Saints",
    "The Story of the Presentation of the Blessed Virgin Mary",
    "The Story of the Nativity of the Blessed Virgin Mary",
    "The Story of the Exaltation of the Holy Cross",
    "The Story of the Transfiguration of the Lord",
    "The Story of the Solemnity of the Assumption of Mary",
    "The Story of the Immaculate Conception of Mary",
  ];

  for (final filePath in files) {
    final file = File(filePath);
    if (!file.existsSync()) {
      print('File not found: $filePath');
      continue;
    }

    print('\nProcessing $filePath...');
    final content = file.readAsStringSync();
    final Map<String, dynamic> jsonMap = json.decode(content);
    final originalCount = jsonMap.length;
    final Map<String, dynamic> cleanedMap = {};
    final List<String> removedKeys = [];

    jsonMap.forEach((key, value) {
      bool shouldRemove = false;

      // Check against keywords
      for (final keyword in keywordsToRemove) {
        if (key.contains(keyword)) {
          shouldRemove = true;
          break;
        }
      }

      // Check against specific removals
      if (specificRemovals.contains(key)) {
        shouldRemove = true;
      }
      
      // Heuristic: If it starts with "Saint", "Blessed", "Venerable", "Pope", "Servant of God", keep it.
      // This overrides the removal if it accidentally caught a saint (e.g. "Saint Easter" - unlikely but possible).
      // However, some feasts might start with these, so we need to be careful.
      // Actually, let's stick to the removal list first. 
      // "Chair of Saint Peter" contains "Chair of", so it will be removed. Correct.
      // "Conversion of Saint Paul" contains "Conversion of", so it will be removed. Correct.
      
      // Let's check if we are removing something that looks like a saint but has a keyword.
      // e.g. "Saint John of the Cross" - "Cross" is not in keywords.
      // "Saint Francis of Assisi" - OK.
      
      if (shouldRemove) {
        removedKeys.add(key);
      } else {
        cleanedMap[key] = value;
      }
    });

    if (removedKeys.isNotEmpty) {
      print('Removed ${removedKeys.length} entries:');
      for (final key in removedKeys) {
        print(' - $key');
      }
      
      // Write back to file
      final encoder = JsonEncoder.withIndent('  ');
      file.writeAsStringSync(encoder.convert(cleanedMap));
      print('Saved cleaned file. Count: $originalCount -> ${cleanedMap.length}');
    } else {
      print('No entries removed.');
    }
  }
}
