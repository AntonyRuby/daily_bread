// import 'package:flutter/material.dart';

// class BiblePage extends StatefulWidget {
//   final bibleindex;
//   BiblePage({Key key, @required this.bibleindex}) : super(key: key);

//   @override
//   _BiblePageState createState() => _BiblePageState();
// }

// class Bible {
//   Bible({
//     this.charset,
//     this.genesis,
//     this.exodus,
//     this.leviticus,
//     this.numbers,
//     this.deuteronomy,
//     this.joshua,
//     this.judges,
//     this.ruth,
//     this.the1Samuel,
//     this.the2Samuel,
//     this.the1Kings,
//     this.the2Kings,
//     this.the1Chronicles,
//     this.the2Chronicles,
//     this.ezra,
//     this.nehemiah,
//     this.tobit,
//     this.judith,
//     this.esther,
//     this.job,
//     this.psalms,
//     this.proverbs,
//     this.ecclesiastes,
//     this.song2,
//     this.wisdom,
//     this.sirach,
//     this.isaiah,
//     this.jeremiah,
//     this.lamentations,
//     this.baruch,
//     this.ezekiel,
//     this.daniel,
//     this.hosea,
//     this.joel,
//     this.amos,
//     this.obadiah,
//     this.jonah,
//     this.micah,
//     this.nahum,
//     this.habakkuk,
//     this.zephaniah,
//     this.haggai,
//     this.zechariah,
//     this.malachi,
//     this.the1Maccabees,
//     this.the2Maccabees,
//     this.matthew,
//     this.mark,
//     this.luke,
//     this.john,
//     this.acts,
//     this.romans,
//     this.the1Corinthians,
//     this.the2Corinthians,
//     this.galatians,
//     this.ephesians,
//     this.philippians,
//     this.colossians,
//     this.the1Thessalonians,
//     this.the2Thessalonians,
//     this.the1Timothy,
//     this.the2Timothy,
//     this.titus,
//     this.philemon,
//     this.hebrews,
//     this.james,
//     this.the1Peter,
//     this.the2Peter,
//     this.the1John,
//     this.the2John,
//     this.the3John,
//     this.jude,
//     this.revelation,
//   });

//   String charset;
//   Map<String, Map<String, String>> genesis;
//   Map<String, Map<String, String>> exodus;
//   Map<String, Map<String, String>> leviticus;
//   Map<String, Map<String, String>> numbers;
//   Map<String, Map<String, String>> deuteronomy;
//   Map<String, Map<String, String>> joshua;
//   Map<String, Map<String, String>> judges;
//   Map<String, Map<String, String>> ruth;
//   Map<String, Map<String, String>> the1Samuel;
//   Map<String, Map<String, String>> the2Samuel;
//   Map<String, Map<String, String>> the1Kings;
//   Map<String, Map<String, String>> the2Kings;
//   Map<String, Map<String, String>> the1Chronicles;
//   Map<String, Map<String, String>> the2Chronicles;
//   Map<String, Map<String, String>> ezra;
//   Map<String, Map<String, String>> nehemiah;
//   Map<String, Map<String, String>> tobit;
//   Map<String, Map<String, String>> judith;
//   Map<String, Map<String, String>> esther;
//   Map<String, Map<String, String>> job;
//   Map<String, Map<String, String>> psalms;
//   Map<String, Map<String, String>> proverbs;
//   Map<String, Map<String, String>> ecclesiastes;
//   Map<String, Map<String, String>> song2;
//   Map<String, Map<String, String>> wisdom;
//   Map<String, Map<String, String>> sirach;
//   Map<String, Map<String, String>> isaiah;
//   Map<String, Map<String, String>> jeremiah;
//   Lamentations lamentations;
//   Map<String, Map<String, String>> baruch;
//   Map<String, Map<String, String>> ezekiel;
//   Map<String, Map<String, String>> daniel;
//   Map<String, Map<String, String>> hosea;
//   Map<String, Map<String, String>> joel;
//   Map<String, Map<String, String>> amos;
//   The2John obadiah;
//   Map<String, Map<String, String>> jonah;
//   Map<String, Map<String, String>> micah;
//   Map<String, Map<String, String>> nahum;
//   Map<String, Map<String, String>> habakkuk;
//   Map<String, Map<String, String>> zephaniah;
//   Map<String, Map<String, String>> haggai;
//   Map<String, Map<String, String>> zechariah;
//   Map<String, Map<String, String>> malachi;
//   Map<String, Map<String, String>> the1Maccabees;
//   Map<String, Map<String, String>> the2Maccabees;
//   Map<String, Map<String, String>> matthew;
//   Map<String, Map<String, String>> mark;
//   Map<String, Map<String, String>> luke;
//   Map<String, Map<String, String>> john;
//   Map<String, Map<String, String>> acts;
//   Map<String, Map<String, String>> romans;
//   Map<String, Map<String, String>> the1Corinthians;
//   Map<String, Map<String, String>> the2Corinthians;
//   Map<String, Map<String, String>> galatians;
//   Map<String, Map<String, String>> ephesians;
//   Map<String, Map<String, String>> philippians;
//   Map<String, Map<String, String>> colossians;
//   Map<String, Map<String, String>> the1Thessalonians;
//   Map<String, Map<String, String>> the2Thessalonians;
//   Map<String, Map<String, String>> the1Timothy;
//   Map<String, Map<String, String>> the2Timothy;
//   Map<String, Map<String, String>> titus;
//   The2John philemon;
//   Map<String, Map<String, String>> hebrews;
//   Map<String, Map<String, String>> james;
//   Map<String, Map<String, String>> the1Peter;
//   Map<String, Map<String, String>> the2Peter;
//   Map<String, Map<String, String>> the1John;
//   The2John the2John;
//   The2John the3John;
//   The2John jude;
//   Map<String, Map<String, String>> revelation;

//   factory Bible.fromJson(Map<String, dynamic> json) => Bible(
//         charset: json["charset"],
//         genesis: Map.from(json["Genesis"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         exodus: Map.from(json["Exodus"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         leviticus: Map.from(json["Leviticus"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         numbers: Map.from(json["Numbers"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         deuteronomy: Map.from(json["Deuteronomy"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         joshua: Map.from(json["Joshua"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         judges: Map.from(json["Judges"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         ruth: Map.from(json["Ruth"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1Samuel: Map.from(json["1-Samuel"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2Samuel: Map.from(json["2-Samuel"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1Kings: Map.from(json["1-Kings"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2Kings: Map.from(json["2-Kings"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1Chronicles: Map.from(json["1-Chronicles"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2Chronicles: Map.from(json["2-Chronicles"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         ezra: Map.from(json["Ezra"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         nehemiah: Map.from(json["Nehemiah"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         tobit: Map.from(json["Tobit"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         judith: Map.from(json["Judith"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         esther: Map.from(json["Esther"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         job: Map.from(json["Job"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         psalms: Map.from(json["Psalms"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         proverbs: Map.from(json["Proverbs"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         ecclesiastes: Map.from(json["Ecclesiastes"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         song2: Map.from(json["Song2"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         wisdom: Map.from(json["Wisdom"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         sirach: Map.from(json["Sirach"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         isaiah: Map.from(json["Isaiah"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         jeremiah: Map.from(json["Jeremiah"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         lamentations: Lamentations.fromJson(json["Lamentations"]),
//         baruch: Map.from(json["Baruch"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         ezekiel: Map.from(json["Ezekiel"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         daniel: Map.from(json["Daniel"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         hosea: Map.from(json["Hosea"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         joel: Map.from(json["Joel"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         amos: Map.from(json["Amos"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         obadiah: The2John.fromJson(json["Obadiah"]),
//         jonah: Map.from(json["Jonah"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         micah: Map.from(json["Micah"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         nahum: Map.from(json["Nahum"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         habakkuk: Map.from(json["Habakkuk"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         zephaniah: Map.from(json["Zephaniah"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         haggai: Map.from(json["Haggai"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         zechariah: Map.from(json["Zechariah"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         malachi: Map.from(json["Malachi"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1Maccabees: Map.from(json["1-Maccabees"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2Maccabees: Map.from(json["2-Maccabees"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         matthew: Map.from(json["Matthew"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         mark: Map.from(json["Mark"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         luke: Map.from(json["Luke"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         john: Map.from(json["John"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         acts: Map.from(json["Acts"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         romans: Map.from(json["Romans"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1Corinthians: Map.from(json["1-Corinthians"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2Corinthians: Map.from(json["2-Corinthians"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         galatians: Map.from(json["Galatians"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         ephesians: Map.from(json["Ephesians"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         philippians: Map.from(json["Philippians"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         colossians: Map.from(json["Colossians"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1Thessalonians: Map.from(json["1-Thessalonians"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2Thessalonians: Map.from(json["2-Thessalonians"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1Timothy: Map.from(json["1-Timothy"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2Timothy: Map.from(json["2-Timothy"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         titus: Map.from(json["Titus"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         philemon: The2John.fromJson(json["Philemon"]),
//         hebrews: Map.from(json["Hebrews"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         james: Map.from(json["James"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1Peter: Map.from(json["1-Peter"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2Peter: Map.from(json["2-Peter"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the1John: Map.from(json["1-John"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//         the2John: The2John.fromJson(json["2-John"]),
//         the3John: The2John.fromJson(json["3-John"]),
//         jude: The2John.fromJson(json["Jude"]),
//         revelation: Map.from(json["Revelation"]).map((k, v) =>
//             MapEntry<String, Map<String, String>>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, String>(k, v)))),
//       );

//   Map<String, dynamic> toJson() => {
//         "charset": charset,
//         "Genesis": Map.from(genesis).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Exodus": Map.from(exodus).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Leviticus": Map.from(leviticus).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Numbers": Map.from(numbers).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Deuteronomy": Map.from(deuteronomy).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Joshua": Map.from(joshua).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Judges": Map.from(judges).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Ruth": Map.from(ruth).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-Samuel": Map.from(the1Samuel).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-Samuel": Map.from(the2Samuel).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-Kings": Map.from(the1Kings).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-Kings": Map.from(the2Kings).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-Chronicles": Map.from(the1Chronicles).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-Chronicles": Map.from(the2Chronicles).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Ezra": Map.from(ezra).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Nehemiah": Map.from(nehemiah).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Tobit": Map.from(tobit).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Judith": Map.from(judith).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Esther": Map.from(esther).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Job": Map.from(job).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Psalms": Map.from(psalms).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Proverbs": Map.from(proverbs).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Ecclesiastes": Map.from(ecclesiastes).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Song2": Map.from(song2).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Wisdom": Map.from(wisdom).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Sirach": Map.from(sirach).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Isaiah": Map.from(isaiah).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Jeremiah": Map.from(jeremiah).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Lamentations": lamentations.toJson(),
//         "Baruch": Map.from(baruch).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Ezekiel": Map.from(ezekiel).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Daniel": Map.from(daniel).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Hosea": Map.from(hosea).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Joel": Map.from(joel).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Amos": Map.from(amos).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Obadiah": obadiah.toJson(),
//         "Jonah": Map.from(jonah).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Micah": Map.from(micah).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Nahum": Map.from(nahum).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Habakkuk": Map.from(habakkuk).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Zephaniah": Map.from(zephaniah).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Haggai": Map.from(haggai).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Zechariah": Map.from(zechariah).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Malachi": Map.from(malachi).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-Maccabees": Map.from(the1Maccabees).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-Maccabees": Map.from(the2Maccabees).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Matthew": Map.from(matthew).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Mark": Map.from(mark).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Luke": Map.from(luke).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "John": Map.from(john).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Acts": Map.from(acts).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Romans": Map.from(romans).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-Corinthians": Map.from(the1Corinthians).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-Corinthians": Map.from(the2Corinthians).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Galatians": Map.from(galatians).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Ephesians": Map.from(ephesians).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Philippians": Map.from(philippians).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Colossians": Map.from(colossians).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-Thessalonians": Map.from(the1Thessalonians).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-Thessalonians": Map.from(the2Thessalonians).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-Timothy": Map.from(the1Timothy).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-Timothy": Map.from(the2Timothy).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Titus": Map.from(titus).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "Philemon": philemon.toJson(),
//         "Hebrews": Map.from(hebrews).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "James": Map.from(james).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-Peter": Map.from(the1Peter).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-Peter": Map.from(the2Peter).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "1-John": Map.from(the1John).map((k, v) => MapEntry<String, dynamic>(
//             k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//         "2-John": the2John.toJson(),
//         "3-John": the3John.toJson(),
//         "Jude": jude.toJson(),
//         "Revelation": Map.from(revelation).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
//       };
// }

// class The2John {
//   The2John({
//     this.the1,
//   });

//   Map<String, String> the1;

//   factory The2John.fromJson(Map<String, dynamic> json) => The2John(
//         the1: Map.from(json["1"]).map((k, v) => MapEntry<String, String>(k, v)),
//       );

//   Map<String, dynamic> toJson() => {
//         "1": Map.from(the1).map((k, v) => MapEntry<String, dynamic>(k, v)),
//       };
// }

// class Lamentations {
//   Lamentations({
//     this.the1,
//     this.the2,
//     this.the3,
//     this.the4,
//     this.the5,
//     this.p,
//   });

//   Map<String, String> the1;
//   Map<String, String> the2;
//   Map<String, String> the3;
//   Map<String, String> the4;
//   Map<String, String> the5;
//   Map<String, String> p;

//   factory Lamentations.fromJson(Map<String, dynamic> json) => Lamentations(
//         the1: Map.from(json["1"]).map((k, v) => MapEntry<String, String>(k, v)),
//         the2: Map.from(json["2"]).map((k, v) => MapEntry<String, String>(k, v)),
//         the3: Map.from(json["3"]).map((k, v) => MapEntry<String, String>(k, v)),
//         the4: Map.from(json["4"]).map((k, v) => MapEntry<String, String>(k, v)),
//         the5: Map.from(json["5"]).map((k, v) => MapEntry<String, String>(k, v)),
//         p: Map.from(json["P"]).map((k, v) => MapEntry<String, String>(k, v)),
//       );

//   Map<String, dynamic> toJson() => {
//         "1": Map.from(the1).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "2": Map.from(the2).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "3": Map.from(the3).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "4": Map.from(the4).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "5": Map.from(the5).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "P": Map.from(p).map((k, v) => MapEntry<String, dynamic>(k, v)),
//       };
// }

// class _BiblePageState extends State<BiblePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bible"),
//       ),
//       body: Text(widget.bibleindex),
//     );
//   }
// }
