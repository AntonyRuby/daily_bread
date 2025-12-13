import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:daily_bread/models/verse.dart';
import 'package:daily_bread/models/saint.dart';
import 'package:daily_bread/models/daily_reading.dart';

class DataService {
  static final DataService _instance = DataService._internal();

  factory DataService() {
    return _instance;
  }

  DataService._internal();

  Map<String, Verse> _verses = {};
  Map<String, Saint> _saints = {};
  Map<String, DailyReading> _dailyReadings = {};
  Map<String, dynamic> _bible = {};

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  String _normalizeSaintName(String raw) {
    return raw
        .toLowerCase()
        .replaceAll(RegExp(r'^(saint|saints|st\.?|blessed)\s+'), '')
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .trim();
  }

  Future<void> loadData({String locale = 'en'}) async {
    _isLoaded = false; // Reset loaded state to force reload if needed
    
    // Ensure valid locale
    if (locale != 'en' && locale != 'ta') {
      locale = 'en';
    }

    try {
      final versesJson = await rootBundle.loadString('asset/$locale/verses.json');
      final saintsJson = await rootBundle.loadString('asset/$locale/saints.json');
      final dailyJson = await rootBundle.loadString('asset/$locale/daily.json');
      final bibleJson = await rootBundle.loadString('asset/$locale/bible.json');

      final Map<String, dynamic> versesMap = json.decode(versesJson);
      _verses.clear();
      versesMap.forEach((date, data) {
        _verses[date] = Verse.fromJson(date, data);
      });

      final Map<String, dynamic> saintsMap = json.decode(saintsJson);
      _saints.clear();
      saintsMap.forEach((name, data) {
        _saints[name] = Saint.fromJson(name, data);
      });

      final Map<String, dynamic> dailyMap = json.decode(dailyJson);
      _dailyReadings.clear();
      dailyMap.forEach((date, data) {
        _dailyReadings[date] = DailyReading.fromJson(date, data);
      });

      _bible = json.decode(bibleJson);

      _isLoaded = true;
    } catch (e) {
      print("Error loading data for locale $locale: $e");
      // Fallback to English if loading fails (e.g. missing files)
      if (locale != 'en') {
        print("Falling back to English");
        await loadData(locale: 'en');
      }
    }
  }

  Future<void> reloadForLocale(String locale) async {
    await loadData(locale: locale);
  }

  Verse? getVerse(String date) {
    return _verses[date];
  }

  DailyReading? getDailyReading(String date) {
    return _dailyReadings[date];
  }

  Saint? getSaint(String name) {
    if (name.isEmpty) return null;

    // Exact match
    final direct = _saints[name];
    if (direct != null) return direct;

    // Normalized match (handles prefixes, punctuation, spacing)
    final target = _normalizeSaintName(name);
    for (final entry in _saints.entries) {
      final keyNormalized = _normalizeSaintName(entry.key);
      final valueNormalized = _normalizeSaintName(entry.value.name);
      if (keyNormalized == target || valueNormalized == target) {
        return entry.value;
      }
    }

    return null;
  }

  Saint? getSaintForDate(String date) {
    final reading = getDailyReading(date);
    if (reading != null) {
      final saint = getSaint(reading.saintName);
      if (saint != null) {
        return saint;
      }
      // Fallback: Create a placeholder saint so the UI doesn't crash/show error
      return Saint(
        name: reading.saintName,
        about: "Saint biography pending update.",
        period: "",
        imagePath: "", // Will trigger errorBuilder in UI -> default icon
      );
    }
    return null;
  }

  Map<String, dynamic> get bible => _bible;

  List<Saint> getAllSaints() {
    return _saints.values.toList();
  }
}
