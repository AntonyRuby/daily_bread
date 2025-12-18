import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

// Base URL
const String baseUrl = 'https://bible.catholicgallery.org';
const String startUrl = 'https://bible.catholicgallery.org/ecu-tamil/';

void main() async {
  print('Starting Tamil Bible Scraper...');
  
  final Map<String, dynamic> bibleData = {};
  
  try {
    // 1. Get the list of books
    print('Fetching book list from $startUrl...');
    final response = await http.get(Uri.parse(startUrl));
    if (response.statusCode != 200) {
      print('Failed to load start URL');
      return;
    }
    
    final document = parse(response.body);
    final links = document.querySelectorAll('a');
    final List<String> bookStartUrls = [];
    
    for (final link in links) {
      var href = link.attributes['href'];
      if (href != null && href.contains('/tamil/etb-') && href.endsWith('-1/')) {
        href = href.trim();
        if (!href.startsWith('http')) {
          // Handle relative URLs if necessary, though the site seems to use absolute
          continue;
        }
        // This is a book start link (Chapter 1)
        bookStartUrls.add(href);
      }
    }
    
    print('Found ${bookStartUrls.length} books.');
    
    // 2. Process each book
    for (final startLink in bookStartUrls) {
      await processBook(startLink, bibleData);
      // break; // Remove this break to scrape all books
    }
    
    // Save to file
    final file = File('asset/ta/bible.json');
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }
    const encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString(encoder.convert(bibleData));
    print('Saved Tamil Bible to asset/ta/bible.json');
    
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> processBook(String startUrl, Map<String, dynamic> bibleData) async {
  String? currentUrl = startUrl;
  String bookName = '';
  
  // Extract book name from startUrl
  // e.g. .../etb-genesis-1/ -> GENESIS
  final uri = Uri.parse(startUrl);
  final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
  if (segments.isNotEmpty) {
    final last = segments.last; // etb-genesis-1
    final parts = last.split('-');
    if (parts.length >= 3) {
      bookName = parts.sublist(1, parts.length - 1).join(' ').toUpperCase();
    }
  }
  
  if (bookName.isEmpty) return;
  print('Processing Book: $bookName');
  
  if (!bibleData.containsKey(bookName)) {
    bibleData[bookName] = {};
  }
  
      // 2. Iterate through chapters by incrementing number
      int chapterNum = 1;
      
      while (true) {
        // Construct URL: .../etb-genesis-1/
        // Need to handle book name format.
        // The bookStartUrl is .../etb-genesis-1/
        // We can derive the base from it.
        
        // Extract base: https://bible.catholicgallery.org/tamil/etb-genesis-
        final baseMatch = RegExp(r'(.*-)(\d+)/?$').firstMatch(startUrl);
        if (baseMatch == null) {
          print('  Could not parse base URL from $startUrl');
          break;
        }
        
        final baseUrl = baseMatch.group(1)!;
        final currentChapterUrl = '$baseUrl$chapterNum/';
        
        print('  Scraping Chapter $chapterNum ($currentChapterUrl)...');
        
        try {
          final response = await http.get(Uri.parse(currentChapterUrl));
          // If 404, we assume end of book (or error)
          if (response.statusCode == 404) {
             print('    -> 404 Not Found. Assuming end of book.');
             break;
          }
          if (response.statusCode != 200) {
             print('    -> Failed to load (Status ${response.statusCode}). Skipping/Stopping.');
             break;
          }
          
          // Check if we were redirected to another book or main page?
          // Some sites redirect 404s.
          if (response.request?.url.toString() != currentChapterUrl && !response.request!.url.toString().endsWith('/')) {
             // Check if it's just a slash difference
             // If completely different, stop.
          }

          final document = parse(response.body);
          final contentDiv = document.querySelector('.entry-content');
          
          if (contentDiv != null) {
              // Remove unwanted
              contentDiv.querySelectorAll('.code-block').forEach((e) => e.remove());
              
              final verses = <String, String>{};
              String? currentVerseNum;
              String currentVerseText = '';
              
              // Correct structure based on grep:
              // <p class="bibvtxt"><span class="bibvnum">1</span>Verse text...</p>
              
              final verseParagraphs = contentDiv.querySelectorAll('p.bibvtxt');
              
              if (verseParagraphs.isNotEmpty) {
                for (final p in verseParagraphs) {
                  final numSpan = p.querySelector('.bibvnum');
                  if (numSpan != null) {
                    final vNum = numSpan.text.trim();
                    
                    // Get text without the number
                    // We can clone and remove the span
                    final pClone = p.clone(true);
                    pClone.querySelector('.bibvnum')?.remove();
                    final vText = pClone.text.trim();
                    
                    if (vNum.isNotEmpty && vText.isNotEmpty) {
                      verses[vNum] = vText;
                    }
                  }
                }
              } else {
                 // Fallback to previous logic if p.bibvtxt not found (maybe some books are different?)
                 // Or maybe the class is on the span only?
                 // Let's try to find all paragraphs and check for .bibvnum inside
                 final paragraphs = contentDiv.querySelectorAll('p');
                 for (final p in paragraphs) {
                    final numSpan = p.querySelector('.bibvnum');
                    if (numSpan != null) {
                       final vNum = numSpan.text.trim();
                       final pClone = p.clone(true);
                       pClone.querySelector('.bibvnum')?.remove();
                       final vText = pClone.text.trim();
                       verses[vNum] = vText;
                    } else {
                       // Fallback to regex if no class
                       // ... (existing regex logic if needed, or maybe just skip)
                    }
                 }
              }
              
              if (verses.isNotEmpty) {
                bibleData[bookName][chapterNum.toString()] = verses;
                print('    -> Scraped ${verses.length} verses.');
              } else {
                 print('    -> No verses found in content.');
                 // If page exists but no verses, maybe intro page? 
                 // But we constructed URL for chapter 1, 2...
                 // If empty, maybe end of book?
                 // Usually if chapter doesn't exist, we get 404.
                 // If we get 200 but no verses, it might be a glitch or different format.
                 // Let's continue to next chapter just in case, but limit empty streaks.
              }
          } else {
             print('    -> No content div found.');
             break;
          }
          
        } catch (e) {
          print('    -> Error: $e');
          break;
        }
        
        chapterNum++;
        sleep(Duration(milliseconds: 100));
      }
      
      print('  Finished book $bookName.');
}

