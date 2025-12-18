import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

void main() async {
  const url = 'https://bible.catholicgallery.org/ecu-tamil/';
  print('Fetching $url...');
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    print('Failed to load page');
    return;
  }
  final document = parse(response.body);
  final links = document.querySelectorAll('a');
  print('Found ${links.length} links.');
  for (final link in links) {
    final href = link.attributes['href'];
    final text = link.text.trim();
    if (href != null && href.contains('catholicgallery.org')) {
      print('Link: $text -> $href');
    }
  }
}
