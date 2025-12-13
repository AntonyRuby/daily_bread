import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MassReadings extends StatelessWidget {
  final Map<String, dynamic> dailyreadings;
  const MassReadings({Key? key, required this.dailyreadings}) : super(key: key);

  void _shareReadings(BuildContext context) {
      String text = dailyreadings["day"] +
          '\n\n\n' +
          "First Reading" +
          '\n\n' +
          dailyreadings["first"] +
          '\n\n' +
          dailyreadings["first_reading"] +
          '\n\n\n' +
          dailyreadings["psalm"] +
          '\n\n' +
          dailyreadings["psalm_reading"] +
          '\n\n\n';
      if (dailyreadings["second"] != "") {
        text = text +
            "Second Reading" +
            '\n\n' +
            dailyreadings["second"] +
            '\n\n' +
            dailyreadings["second_reading"] +
            '\n\n\n';
      }
      text = text +
          "Gospel Reading" +
          '\n\n' +
          dailyreadings["gospel"] +
          '\n\n' +
          dailyreadings["gospel_reading"];

      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        Share.share(text, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      } else {
        Share.share(text);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Daily Mass Readings"),
            actions: [
              IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => _shareReadings(context),
              )
            ],
        ),
        body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
                Text(
                  dailyreadings["day"],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildReadingSection(context, "First Reading", dailyreadings["first"], dailyreadings["first_reading"]),
                _buildReadingSection(context, "Responsorial Psalm", dailyreadings["psalm"], dailyreadings["psalm_reading"]),
                if (dailyreadings["second"] != "")
                    _buildReadingSection(context, "Second Reading", dailyreadings["second"], dailyreadings["second_reading"]),
                _buildReadingSection(context, "Gospel", dailyreadings["gospel"], dailyreadings["gospel_reading"]),
            ]
        ),
    );
  }

  Widget _buildReadingSection(BuildContext context, String title, String subtitle, String body) {
      return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(subtitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic)),
                  const SizedBox(height: 12),
                  SelectableText(body, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5), textAlign: TextAlign.justify),
                  const Divider(height: 32),
              ],
          ),
      );
  }
}
