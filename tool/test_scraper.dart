import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

void main() async {
  final url = 'https://bible.catholicgallery.org/tamil-mass-reading/tr-151225/';
  print('Testing scraper on: $url');
  
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    print('Failed to load page');
    return;
  }
  
  final document = parse(response.body);
  final contentDiv = document.querySelector('.entry-content');
  
  if (contentDiv == null) {
    print('ERROR: .entry-content not found!');
    return;
  }
  
  // Remove unwanted elements
  contentDiv.querySelectorAll('.adslot_4').forEach((el) => el.remove());
  contentDiv.querySelectorAll('.Bible-4').forEach((el) => el.remove());
  contentDiv.querySelectorAll('[class*="adslot"]').forEach((el) => el.remove());
  contentDiv.querySelectorAll('script').forEach((el) => el.remove());
  contentDiv.querySelectorAll('style').forEach((el) => el.remove());
  contentDiv.querySelectorAll('table').forEach((el) => el.remove());
  contentDiv.querySelectorAll('.archive').forEach((el) => el.remove());
  contentDiv.querySelectorAll('nav').forEach((el) => el.remove());
  
  for (int i = 0; i < contentDiv.children.length; i++) {
    final child = contentDiv.children[i];
    final text = child.text.trim();
    
    if (text.isEmpty) continue;
    if (text.contains('◄') && text.contains('►') && text.length < 100) continue;
    
    final lowerText = text.toLowerCase();
    
    if (lowerText.contains('முதல் வாசகம்')) {
      print('\\n=== FIRST READING DIV ===');
      print('Text length: ${text.length}');
      print('First 200 chars: ${text.substring(0, text.length > 200 ? 200 : text.length)}');
      
      // Test split approach
      final lines = text.split('\\n');
      print('\\nNumber of lines after split: ${lines.length}');
      print('First line: ${lines.first}');
      if (lines.length > 1) {
        print('Second line: ${lines[1]}');
      }
      
      final content = lines.skip(1).join('\\n').trim();
      print('\\nContent after skip(1): length=${content.length}');
      print('Content preview: ${content.substring(0, content.length > 100 ? 100 : content.length)}');
    }
    
    if (lowerText.contains('நற்செய்தி வாசகம்')) {
      print('\\n=== GOSPEL DIV ===');
      print('Text length: ${text.length}');
      print('First 200 chars: ${text.substring(0, text.length > 200 ? 200 : text.length)}');
      
      final lines = text.split('\\n');
      print('\\nNumber of lines after split: ${lines.length}');
      print('First line: ${lines.first}');
      if (lines.length > 1) {
        print('Second line: ${lines[1]}');
      }
      
      final content = lines.skip(1).join('\\n').trim();
      print('\\nContent after skip(1): length=${content.length}');
      print('Content preview: ${content.substring(0, content.length > 100 ? 100 : content.length)}');
    }
  }
}
