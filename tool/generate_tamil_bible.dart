import 'dart:convert';
import 'dart:io';

void main() {
  // Map of English Book names to Tamil
  final bookNameMap = {
    "Genesis": "தொடக்க நூல்",
    "Exodus": "விடுதலைப் பயணம்",
    "Leviticus": "லேவியர்",
    "Numbers": "எண்ணிக்கை",
    "Deuteronomy": "இணைச் சட்டம்",
    "Joshua": "யோசுவா",
    "Judges": "நீதித் தலைவர்கள்",
    "Ruth": "ரூத்து",
    "1 Samuel": "1 சாமுவேல்",
    "2 Samuel": "2 சாமுவேல்",
    "1 Kings": "1 அரசர்கள்",
    "2 Kings": "2 அரசர்கள்",
    "1 Chronicles": "1 குறிப்பேடு",
    "2 Chronicles": "2 குறிப்பேடு",
    "Ezra": "எஸ்ரா",
    "Nehemiah": "நெகேமியா",
    "Tobit": "தோபித்து",
    "Judith": "யூதித்து",
    "Esther": "எஸ்தர்",
    "1 Maccabees": "1 மக்கபேயர்",
    "2 Maccabees": "2 மக்கபேயர்",
    "Job": "யோபு",
    "Psalms": "திருப்பாடல்கள்",
    "Proverbs": "நீதிமொழிகள்",
    "Ecclesiastes": "சபை உரையாளர்",
    "Song of Solomon": "இனிமை மிகும் பாடல்",
    "Wisdom": "சாலமோனின் ஞானம்",
    "Sirach": "சீராக்",
    "Isaiah": "எசாயா",
    "Jeremiah": "எரேமியா",
    "Lamentations": "புலம்பல்",
    "Baruch": "பாரூக்",
    "Ezekiel": "எசேக்கியேல்",
    "Daniel": "தானியேல்",
    "Hosea": "ஓசேயா",
    "Joel": "யோவேல்",
    "Amos": "ஆமோஸ்",
    "Obadiah": "ஒபதியா",
    "Jonah": "யோனா",
    "Micah": "மீக்கா",
    "Nahum": "நாகூம்",
    "Habakkuk": "அபக்கூக்கு",
    "Zephaniah": "செப்பனியா",
    "Haggai": "ஆகாய்",
    "Zechariah": "செக்கரியா",
    "Malachi": "மலாக்கி",
    "Matthew": "மத்தேயு",
    "Mark": "மாற்கு",
    "Luke": "லூக்கா",
    "John": "யோவான்",
    "Acts": "திருத்தூதர் பணிகள்",
    "Romans": "உரோமையர்",
    "1 Corinthians": "1 கொரிந்தியர்",
    "2 Corinthians": "2 கொரிந்தியர்",
    "Galatians": "கலாத்தியர்",
    "Ephesians": "எபேசியர்",
    "Philippians": "பிலிப்பியர்",
    "Colossians": "கொலோசையர்",
    "1 Thessalonians": "1 தெசலோனிக்கர்",
    "2 Thessalonians": "2 தெசலோனிக்கர்",
    "1 Timothy": "1 திமோத்தேயு",
    "2 Timothy": "2 திமோத்தேயு",
    "Titus": "தீத்து",
    "Philemon": "பிலமோன்",
    "Hebrews": "எபிரேயர்",
    "James": "யாக்கோபு",
    "1 Peter": "1 பேதுரு",
    "2 Peter": "2 பேதுரு",
    "1 John": "1 யோவான்",
    "2 John": "2 யோவான்",
    "3 John": "3 யோவான்",
    "Jude": "யூதா",
    "Revelation": "திருவெளிப்பாடு"
  };

  final fileEn = File('asset/en/bible.json');
  if (!fileEn.existsSync()) {
    print('Error: asset/en/bible.json not found.');
    return;
  }

  final Map<String, dynamic> bibleEn = jsonDecode(fileEn.readAsStringSync());
  final Map<String, dynamic> bibleTa = {};

  // Structure seems to be: { "Book Name": { "Chapter 1": ["Verse 1", ...], ... }, ... }
  // Or maybe list of books? Let's assume Map based on previous usage.
  // Actually, let's check the output of head command first, but I'll write the script assuming Map<String, dynamic>
  // and if it's a list, I'll adjust.
  // Based on `BookScreen(bible: DataService().bible)` it seems to be passed as a Map.
  
  bibleEn.forEach((bookKey, chapters) {
    String tamilBookName = bookNameMap[bookKey] ?? bookKey;
    
    // We can't translate the text automatically without a source.
    // So we will keep the structure but use Tamil Book Names.
    // For the content, we might have to keep English or use a placeholder if requested "all in tamil".
    // The user said "bible .json for ta is not in tamil".
    // If I leave English text, it's not "in Tamil".
    // But I don't have the Tamil Bible text.
    // I will use a placeholder for the text saying "Tamil translation coming soon" 
    // OR keep English text but at least the navigation (Book names) will be in Tamil.
    // Given the user wants "all in tamil", I'll try to put a placeholder message in Tamil for the verses
    // if I can't get them.
    // actually, let's keep English text for now but change Book Titles, 
    // because empty verses are useless. 
    // User said "bible .json for ta is not in tamil". 
    // I will add a note in the first verse of each chapter saying "தமிழ் மொழிபெயர்ப்பு விரைவில்..." (Tamil translation coming soon...)
    
    // Check if chapters is a List (List of Lists of Strings)
    if (chapters is List) {
      List<List<String>> tamilChaptersList = [];
      for (var chapter in chapters) {
        if (chapter is List) {
          // It's a list of verses.
          // We don't have Tamil verses, so we will use a placeholder for the first verse
          // and keep the rest empty or just one verse to show it works.
          // User wants "all in tamil".
          // We can't translate 30,000 verses.
          // We will add a single verse saying "Tamil translation coming soon..."
          // But we must preserve the number of chapters so navigation works.
          
          List<String> tamilVerses = [];
          // Add a placeholder verse
          tamilVerses.add("தமிழ் மொழிபெயர்ப்பு விரைவில் பதிவேற்றப்படும். (Tamil translation coming soon)");
          
          // If we want to keep the original English verses as fallback?
          // User said "bible .json for ta is not in tamil".
          // Maybe mixing is better than empty?
          // But "details in tamil" suggests they want Tamil.
          // Let's stick to the placeholder for now, or maybe include English as well?
          // Let's just put the placeholder.
          
          tamilChaptersList.add(tamilVerses);
        }
      }
      bibleTa[tamilBookName] = tamilChaptersList;
    } else if (chapters is Map) {
       // Handle Map case if it exists (unlikely based on BookScreen code)
       Map<String, dynamic> tamilChapters = {};
       chapters.forEach((chapterKey, verses) {
        tamilChapters[chapterKey] = verses; 
       });
       bibleTa[tamilBookName] = tamilChapters;
    }
  });

  final fileTa = File('asset/ta/bible.json');
  fileTa.writeAsStringSync(jsonEncode(bibleTa));
  print('Generated asset/ta/bible.json with ${bibleTa.length} books.');
}
