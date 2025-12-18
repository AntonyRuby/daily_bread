import 'dart:convert';
import 'dart:io';

void main() {
  // Placeholder structure for Tamil Mass Readings
  // In a real scenario, this would scrape from a source or use a database.
  // For now, we will generate valid JSON structure with Tamil headers and generic content
  // to ensure the app displays correctly in Tamil.
  
  final Map<String, dynamic> dailyReadings = {};
  // Ensure we cover today and future dates
  final startDate = DateTime.now().subtract(Duration(days: 5));
  final endDate = DateTime.now().add(Duration(days: 365));

  // Some sample Tamil content to cycle through so it doesn't look completely empty
  final readings = [
    {
      "firstTitle": "முதல் வாசகம்",
      "firstReading": "ஆண்டவர் கூறுகிறார்: இதோ, நான் புதிய வானையும் புதிய மண்ணையும் படைக்கிறேன். முந்தினவை இனி நினைக்கப்படுவதுமில்லை, மனத்தில் தோன்றுவதுமில்லை.",
      "psalmTitle": "பதிலுரைப் பாடல்",
      "psalmReading": "ஆண்டவரைப் போற்றுங்கள்; ஏனெனில் அவர் நல்லவர்.",
      "secondTitle": "இரண்டாம் வாசகம்",
      "secondReading": "சகோதரர் சகோதரிகளே, நீங்கள் கிறிஸ்துவுடன் உயிர்பெற்று எழுந்தவர்களானால் மேலுலகைச் சார்ந்தவற்றையே நாடுங்கள்.",
      "gospelTitle": "நற்செய்தி வாசகம்",
      "gospelReading": "அக்காலத்தில் இயேசு தம் சீடரை நோக்கிக் கூறியது: 'விழிப்பாயிருங்கள்; ஏனெனில் உங்கள் ஆண்டவர் எந்த நாளில் வருவார் என உங்களுக்குத் தெரியாது.'"
    },
    {
      "firstTitle": "முதல் வாசகம்",
      "firstReading": "ஆண்டவருக்கு அஞ்சி நடப்போர் பேறுபெற்றோர்; அவர் வழிகளில் நடப்போர் எத்துணை பாக்கியவான்கள்!",
      "psalmTitle": "பதிலுரைப் பாடல்",
      "psalmReading": "ஆண்டவர் என் மேய்ப்பர்; எனக்கொரு குறையுமில்லை.",
      "secondTitle": "இரண்டாம் வாசகம்",
      "secondReading": "அன்பு பொறுமையுள்ளது; அன்பு நன்மை செய்யும்; அன்பு பொறாமைப்படாது.",
      "gospelTitle": "நற்செய்தி வாசகம்",
      "gospelReading": "இயேசு: 'நானே வழியும் உண்மையும் வாழ்வுமாய் இருக்கிறேன். என் வழியாய் அன்றி எவரும் தந்தையிடம் வருவதில்லை' என்றார்."
    },
    {
      "firstTitle": "முதல் வாசகம்",
      "firstReading": "ஆண்டவர் என் ஒளி; எனக்கு மீட்பளிப்பவர்; யாருக்கு நான் அஞ்சவேண்டும்? ஆண்டவர் என் வாழ்வின் அடைக்கலம்; யாருக்கு நான் நடுங்க வேண்டும்?",
      "psalmTitle": "பதிலுரைப் பாடல்",
      "psalmReading": "ஆண்டவரே, உமது முகத்தைக் காணத் தேடுகிறேன்.",
      "secondTitle": "இரண்டாம் வாசகம்",
      "secondReading": "கடவுள் நம்மோடு இருக்கிறார் என்றால், நமக்கு எதிராக இருப்பவர் யார்? தம் சொந்த மகனென்றும் பாராது அவரை ஒப்புவித்தவர், அவரோடு அனைத்தையும் நமக்கு அருளாதிருப்பாரோ?",
      "gospelTitle": "நற்செய்தி வாசகம்",
      "gospelReading": "இயேசு கூறியது: 'வருத்தப்பட்டுப் பாரஞ்சுமக்கிறவர்களே! நீங்கள் எல்லாரும் என்னிடத்தில் வாருங்கள்; நான் உங்களுக்கு இளைப்பாறுதல் தருவேன்.'"
    },
    {
      "firstTitle": "முதல் வாசகம்",
      "firstReading": "ஆண்டவர் கூறுகிறார்: தாயானவள் தன் பாலகனை மறப்பாளோ? கருத்தாங்கினவள் தன் கர்ப்பத்தின் பிள்ளைக்கு இரங்காமலிருப்பாளோ? இவர்கள் மறந்தாலும், நான் உன்னை மறப்பதில்லை.",
      "psalmTitle": "பதிலுரைப் பாடல்",
      "psalmReading": "ஆண்டவரே, என் ஆன்மா உம்மை நோக்கி வருகிறது.",
      "secondTitle": "இரண்டாம் வாசகம்",
      "secondReading": "கிறிஸ்துவின் அன்பு நம்மை ஆட்கொள்கிறது. ஒருவர் அனைவருக்காகவும் இறந்தார் என்றால், அனைவரும் இறந்தனர் என நாம் உறுதியாக நம்புகிறோம்.",
      "gospelTitle": "நற்செய்தி வாசகம்",
      "gospelReading": "இயேசு கூறியது: 'உலகில் உங்களுக்குத் துன்பம் உண்டு, எனினும் துணிவுடன் இருங்கள். நான் உலகை வென்றுவிட்டேன்.'"
    },
    {
      "firstTitle": "முதல் வாசகம்",
      "firstReading": "நீ பயப்படாதே, நான் உன்னுடனே இருக்கிறேன்; திகையாதே, நான் உன் தேவன்; நான் உன்னைப் பலப்படுத்தி உனக்குச் சகாயம்பண்ணுவேன்.",
      "psalmTitle": "பதிலுரைப் பாடல்",
      "psalmReading": "ஆண்டவர் என் மேய்ப்பர், நான் ஒன்றும் குறையேன்.",
      "secondTitle": "இரண்டாம் வாசகம்",
      "secondReading": "ஆவியின் கனியோ: அன்பு, சந்தோஷம், சமாதானம், நீடியபொறுமை, தயவு, நற்குணம், விசுவாசம், சாந்தம், இச்சையடக்கம்.",
      "gospelTitle": "நற்செய்தி வாசகம்",
      "gospelReading": "இயேசு கூறியது: 'விண்ணகத்திலும் மண்ணகத்திலும் அனைத்து அதிகாரமும் எனக்கு அருளப்பட்டிருக்கிறது. எனவே நீங்கள் போய் எல்லா மக்களினத்தாரையும் சீடராக்குங்கள்.'"
    },
    {
      "firstTitle": "முதல் வாசகம்",
      "firstReading": "கர்த்தர் என் வெளிச்சமும் என் இரட்சிப்புமானவர், யாருக்குப் பயப்படுவேன்? கர்த்தர் என் ஜீவனின் பெலனானவர், யாருக்கு அஞ்சுவேன்?",
      "psalmTitle": "பதிலுரைப் பாடல்",
      "psalmReading": "ஆண்டவர் என் வெளிச்சம், என் மீட்பர்.",
      "secondTitle": "இரண்டாம் வாசகம்",
      "secondReading": "நம்பிக்கை கொண்டோர் அனைவரும் ஒரே உள்ளமும் ஒரே உயிருமாய் இருந்தனர். அவர்களுள் எவரும் தமது உடைமைகளைத் தம்முடையதாகக் கருதவில்லை.",
      "gospelTitle": "நற்செய்தி வாசகம்",
      "gospelReading": "இயேசு கூறியது: 'என் தந்தை எனக்கு அருளிய கிண்ணத்திலிருந்து நான் குடிக்காமல் இருப்பேனா?'"
    },
    {
      "firstTitle": "முதல் வாசகம்",
      "firstReading": "இதோ, நான் கதவுக்கு வெளியே நின்று தட்டுகிறேன்; ஒருவன் என் சத்தத்தைக் கேட்டு, கதவைத் திறந்தால், அவனிடத்தில் நான் பிரவேசித்து, அவனோடே போஜனம்பண்ணுவேன்.",
      "psalmTitle": "பதிலுரைப் பாடல்",
      "psalmReading": "ஆண்டவரே, உம் வார்த்தையே என் கால்களுக்கு விளக்கு.",
      "secondTitle": "இரண்டாம் வாசகம்",
      "secondReading": "நீங்கள் கிறிஸ்து இயேசுவோடு இணைந்திருப்பதால், கடவுள் உங்களை அவரில் ஞானமும் நீதியும் புனிதமும் மீட்புமாக ஆக்கினார்.",
      "gospelTitle": "நற்செய்தி வாசகம்",
      "gospelReading": "இயேசு கூறியது: 'நானே திராட்சைச் செடி; நீங்கள் கொடிகள். ஒருவர் என்னுடனும் நான் அவருடனும் இணைந்திருந்தால் அவர் மிகுந்த கனி தருவார்.'"
    }
  ];

  int index = 0;
  for (var day = startDate;
      day.isBefore(endDate) || day.isAtSameMomentAs(endDate);
      day = day.add(Duration(days: 1))) {
    final dateStr = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    
    // Use modulo to cycle through sample readings
    final reading = readings[index % readings.length];
    
    // We need to map English saint names to Tamil if possible, or keep English
    // For now, we'll use a generic "Saint of the Day" placeholder if we don't have a specific mapping here,
    // but the app looks up saints from saints.json based on the name here.
    // So we should probably keep the English name here so the lookup works, 
    // OR update saints.json to have Tamil keys (which is harder).
    // BETTER APPROACH: Keep English keys in daily.json for 'saint', but the UI will look up the Tamil display name.
    // Wait, DataService.getSaintForDate uses getDailyReading(date).saintName to look up in _saints.
    // If we change saintName here to Tamil, we must have Tamil keys in saints.json.
    // My generate_tamil_saints.dart created saints.json with English keys but Tamil 'name' fields.
    // So we should keep English saint names here in daily.json so the lookup works!
    
    // However, we need to know WHICH saint is for today.
    // We can read the English daily.json to get the correct saint for the day.
    
    dailyReadings[dateStr] = {
      "day": "பொதுக்காலம்", // Liturgical Day
      "first": reading['firstTitle'],
      "first_reading": reading['firstReading'],
      "psalm": reading['psalmTitle'],
      "psalm_reading": reading['psalmReading'],
      "second": reading['secondTitle'],
      "second_reading": reading['secondReading'],
      "gospel": reading['gospelTitle'],
      "gospel_reading": reading['gospelReading'],
      "saint": "" // Will be filled by merging with English data below
    };
    
    index++;
  }

  // Now merge with English data to get the correct Saint keys
  final fileEn = File('asset/en/daily.json');
  if (fileEn.existsSync()) {
    final Map<String, dynamic> dailyEn = jsonDecode(fileEn.readAsStringSync());
    dailyEn.forEach((date, data) {
      if (dailyReadings.containsKey(date)) {
        dailyReadings[date]['saint'] = data['saint'];
        // Also try to get the correct liturgical day if we can translate it, otherwise keep English or generic
        // dailyReadings[date]['day'] = data['day']; 
      }
    });
  }

  final fileTa = File('asset/ta/daily.json');
  fileTa.writeAsStringSync(jsonEncode(dailyReadings));
  print('Generated asset/ta/daily.json with ${dailyReadings.length} entries.');
}
