import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';

// Base URL for 2025 readings
const String archiveUrl = 'https://bible.catholicgallery.org/tamil-mass-reading/tr-2025/';

void main() async {
  print('Starting Tamil Daily Readings Scraper...');
  
  final Map<String, dynamic> dailyReadings = {};
  
  try {
    // 1. Fetch the archive page to get links for each month
    print('Fetching archive from $archiveUrl...');
    final response = await http.get(Uri.parse(archiveUrl));
    if (response.statusCode != 200) {
      print('Failed to load archive URL');
      return;
    }
    
    final document = parse(response.body);
    final links = document.querySelectorAll('a');
    final Set<String> monthLinks = {};
    
    // Find month links (e.g., tr-january-2025)
    for (final link in links) {
      final href = link.attributes['href'];
      if (href != null && href.contains('/tr-') && href.contains('-2025')) {
         // Exclude the archive page itself if it links to itself
         if (href != archiveUrl && !href.contains('/tr-2025')) {
            monthLinks.add(href);
         }
      }
    }
    
    print('Found ${monthLinks.length} month links.');
    
    // 2. Iterate through months to find daily links
    final Map<String, String> dateLinks = {};
    
    for (final monthUrl in monthLinks) {
       print('Fetching month: $monthUrl');
       try {
         final monthResp = await http.get(Uri.parse(monthUrl));
         if (monthResp.statusCode != 200) continue;
         
         final monthDoc = parse(monthResp.body);
         final dayLinks = monthDoc.querySelectorAll('a');
         
         for (final link in dayLinks) {
           final href = link.attributes['href'];
           if (href != null && href.contains('/tr-')) {
             // Check for tr-DDMMYY format
             // Regex: tr-(\d{6})
             final regex = RegExp(r'tr-(\d{6})');
             final match = regex.firstMatch(href);
             
             if (match != null) {
               final dateStr = match.group(1); // DDMMYY
               if (dateStr != null && dateStr.length == 6) {
                 final day = dateStr.substring(0, 2);
                 final month = dateStr.substring(2, 4);
                 final year = '20' + dateStr.substring(4, 6);
                 
                 final dateKey = '$year-$month-$day';
                 dateLinks[dateKey] = href;
               }
             }
           }
         }
       } catch (e) {
         print('Error fetching month $monthUrl: $e');
       }
    }
    
    print('Found ${dateLinks.length} daily reading links.');
    
    // 3. Iterate and scrape each day
    int count = 0;
    for (final entry in dateLinks.entries) {
      final date = entry.key;
      final url = entry.value;
      
      // Optional: Limit for testing
      // if (count > 5) break; 
      
      await processDay(date, url, dailyReadings);
      count++;
      
      // Be nice to the server
      sleep(Duration(milliseconds: 200));
    }
    
    // Save to file
    final file = File('asset/ta/daily.json');
    const encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString(encoder.convert(dailyReadings));
    print('Saved Tamil Daily Readings to asset/ta/daily.json');
    
  } catch (e) {
    print('Error: $e');
  }
}

int? _monthStringToNumber(String month) {
  // Not used in new logic but keeping just in case
  return null;
}

Future<void> processDay(String date, String url, Map<String, dynamic> dailyReadings) async {
  print('Processing $date ($url)...');
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return;
    
    final document = parse(response.body);
    
    String firstReading = '';
    String secondReading = '';
    String gospel = '';
    String psalm = '';
    
    final contentDiv = document.querySelector('.entry-content');
    if (contentDiv == null) return;
    
    // Remove ONLY specific unwanted elements
    contentDiv.querySelectorAll('.adslot_4').forEach((el) => el.remove());
    contentDiv.querySelectorAll('.Bible-4').forEach((el) => el.remove());
    contentDiv.querySelectorAll('[class*="adslot"]').forEach((el) => el.remove());
    contentDiv.querySelectorAll('script').forEach((el) => el.remove());
    contentDiv.querySelectorAll('style').forEach((el) => el.remove());
    contentDiv.querySelectorAll('table').forEach((el) => el.remove());
    contentDiv.querySelectorAll('.archive').forEach((el) => el.remove());
    contentDiv.querySelectorAll('nav').forEach((el) => el.remove());
    
    final children = contentDiv.children;
    
    for (final child in children) {
      final text = child.text.trim();
      if (text.isEmpty) continue;
      
      // Skip navigation arrows
      if (text.contains('◄') && text.contains('►') && text.length < 100) {
        continue;
      }
      
      final lowerText = text.toLowerCase();
      
      // CRITICAL FIX: Text has NO newlines! Just remove the header from the beginning
      if (lowerText.contains('முதல் வாசகம்')) {
        // Remove "முதல் வாசகம்" from the beginning
        firstReading = text.replaceFirst('முதல் வாசகம்', '').trim();
        print('  -> First reading length: ${firstReading.length}');
        continue;
      } else if (lowerText.contains('இரண்டாம் வாசகம்')) {
        secondReading = text.replaceFirst('இரண்டாம் வாசகம்', '').trim();
        print('  -> Second reading length: ${secondReading.length}');
        continue;
      } else if (lowerText.contains('பதிலுரைப் பாடல்')) {
        psalm = text.replaceFirst('பதிலுரைப் பாடல்', '').trim();
        print('  -> Psalm length: ${psalm.length}');
        continue;
      } else if (lowerText.contains('நற்செய்தி வாசகம்')) {
        gospel = text.replaceFirst('நற்செய்தி வாசகம்', '').trim();
        print('  -> Gospel length: ${gospel.length}');
        continue;
      }
    }
    
    print('  -> Saving: first=${firstReading.length}, psalm=${psalm.length}, gospel=${gospel.length}');
    
    // Clean up
    dailyReadings[date] = {
      "date": date,
      "day": "", // We could parse day of week/feast name if available
      "first": "முதல் வாசகம்",
      "first_reading": firstReading.trim(),
      "second": "இரண்டாம் வாசகம்",
      "second_reading": secondReading.trim(),
      "psalm": "பதிலுரைப் பாடல்",
      "psalm_reading": psalm.trim(),
      "gospel": "நற்செய்தி வாசகம்",
      "gospel_reading": gospel.trim(),
      "saint": "" // Placeholder as we don't have saint data here
    };
    
  } catch (e) {
    print('  -> Error processing $date: $e');
  }
}
