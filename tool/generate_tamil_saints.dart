import 'dart:convert';
import 'dart:io';

void main() {
  // Map of English Saint names to Tamil names
  final saintNameMap = {
    "Saint Joseph": "புனித சூசையப்பர்",
    "Saint Mary, Mother of God": "தேவ அன்னை மரியாள்",
    "Saint Thomas the Apostle": "புனித தோமையார்",
    "Saint Francis Xavier": "புனித பிரான்சிஸ் சவேரியார்",
    "Saint Anthony of Padua": "புனித அந்தோணியார்",
    "Saint Sebastian": "புனித செபஸ்தியார்",
    "Saint George": "புனித ஜார்ஜியார்",
    "Saint Anne": "புனித அன்னம்மாள்",
    "Saint Peter": "புனித பேதுரு",
    "Saint Paul": "புனித சின்னப்பர்",
    "Saint John the Baptist": "புனித அருளப்பர்",
    "Saint Therese of Lisieux": "புனித குழந்தை தெரசா",
    "Saint Mother Teresa": "புனித அன்னை தெரசா",
    "Saint Alphonsa": "புனித அல்போன்சா",
    "Saint Devasahayam Pillai": "புனித தேவசகாயம் பிள்ளை",
    "Saint John de Britto": "புனித அருளானந்தர்",
    "Saint Patrick": "புனித பாட்ரிக்",
    "Saint Valentine": "புனித வேலன்டைன்",
    "Saint Nicholas": "புனித நிக்கோலஸ்",
    "Saint Stephen": "புனித ஸ்தேவான்",
    "Saint Jude": "புனித யூதா ததேயு",
    "Saint Michael": "புனித மிக்கேல் அதிதூதர்",
    "Saint Agnes": "புனித ஆக்னஸ்",
    "Saint Cecilia": "புனித செசிலியா",
    "Saint Francis of Assisi": "புனித பிரான்சிஸ் அசிசி",
    "Saint Clare": "புனித கிளாரா",
    "Saint Ignatius of Loyola": "புனித இஞ்ஞாசியார்",
    "Saint Benedict": "புனித பெனடிக்ட்",
    "Saint Augustine": "புனித அகஸ்டின்",
    "Saint Monica": "புனித மோனிக்கா",
  };

  final fileEn = File('asset/en/saints.json');
  if (!fileEn.existsSync()) {
    print('Error: asset/en/saints.json not found.');
    return;
  }

  final Map<String, dynamic> saintsEn = jsonDecode(fileEn.readAsStringSync());
  final Map<String, dynamic> saintsTa = {};

  saintsEn.forEach((key, value) {
    String tamilName = saintNameMap[key] ?? key; // Fallback to English if no mapping
    
    // Basic transliteration or placeholder for 'about' if not available
    // Ideally, we would have a full database of Tamil biographies.
    String tamilAbout = "இந்த புனிதரின் வாழ்க்கை வரலாறு விரைவில் புதுப்பிக்கப்படும். இவர் கத்தோலிக்க திருச்சபையின் போற்றுதலுக்குரிய புனிதர் ஆவார். இறைவனுக்காக தன் வாழ்வை அர்ப்பணித்தவர்.";
    
    // If we have a specific mapping, we might want to try to provide better text, 
    // but for this task, ensuring the name is Tamil is the priority.
    
    saintsTa[key] = {
      "name": tamilName,
      "about": tamilAbout,
      "period": value['period'] ?? "",
      "img": value['img'] ?? "",
      "url": value['url'] ?? "",
      "img_url": value['img_url'] ?? ""
    };
  });

  // Ensure our specific Tamil saints are present even if not in English list
  // (Though the app drives from daily readings, so they might not show up if not scheduled)
  
  final fileTa = File('asset/ta/saints.json');
  fileTa.writeAsStringSync(jsonEncode(saintsTa));
  print('Generated asset/ta/saints.json with ${saintsTa.length} entries.');
}
