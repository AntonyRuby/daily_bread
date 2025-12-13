import 'dart:convert';
import 'dart:io';

void main() {
  final verses = [
    {
      "verse": "உம் வசனம் என் கால்களுக்குத் தீபமும், என் பாதைக்கு வெளிச்சமுமாய் இருக்கிறது.",
      "reference": "திருப்பாடல்கள் 119:105"
    },
    {
      "verse": "வருத்தப்பட்டுப் பாரஞ்சுமக்கிறவர்களே, நீங்கள் எல்லாரும் என்னிடத்தில் வாருங்கள்; நான் உங்களுக்கு இளைப்பாறுதல் தருவேன்.",
      "reference": "மத்தேயு 11:28"
    },
    {
      "verse": "இறைவார்த்தையைக் கேட்டு அதைக் கடைப்பிடிப்போர் பேறுபெற்றோர்.",
      "reference": "லூக்கா 11:28"
    },
    {
      "verse": "நீ நடக்கும்போது அது உனக்கு வழிகாட்டும்; நீ படுக்கும்போது அது உன்னைக் காப்பாற்றும்; நீ விழிக்கும்போது அது உன்னோடே சம்பாஷிக்கும்.",
      "reference": "நீதிமொழிகள் 6:22"
    },
    {
      "verse": "அஞ்சாதே, ஏனெனில் நான் உன்னோடு இருக்கிறேன்.",
      "reference": "ஏசாயா 41:10"
    },
    {
      "verse": "ஆண்டவரே, உம்மைப் பின்தொடர்பவர் வாழ்வின் ஒளியைக் கொண்டிருப்பார்.",
      "reference": "யோவான் 8:12"
    },
    {
      "verse": "நீரோடை ஓரம் நடப்பட்ட மரம் போல் இருப்பார்; பருவகாலத்தில் கனிதந்து, என்றும் பசுமையாய் இருக்கும் அம்மரத்திற்கு ஒப்பாவார்; தாம் செய்வதனைத்திலும் வெற்றி பெறுவார்.",
      "reference": "திருப்பாடல்கள் 1:3"
    },
    {
      "verse": "கடவுளே, உமது முக ஒளியைக் காட்டி எம்மை மீட்டருளும்.",
      "reference": "திருப்பாடல்கள் 80:3"
    }
  ];

  final Map<String, dynamic> verseMap = {};
  final startDate = DateTime(2025, 1, 1);
  final endDate = DateTime(2026, 12, 31);
  
  int verseIndex = 0;
  for (var day = startDate;
      day.isBefore(endDate) || day.isAtSameMomentAs(endDate);
      day = day.add(Duration(days: 1))) {
    final dateStr = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    
    final verse = verses[verseIndex % verses.length];
    verseMap[dateStr] = {
      "verse": "${verse['verse']}\n\n${verse['reference']}"
    };
    
    verseIndex++;
  }

  final file = File('asset/ta/verses.json');
  file.writeAsStringSync(jsonEncode(verseMap));
  print('Generated asset/ta/verses.json with ${verseMap.length} entries.');
}
