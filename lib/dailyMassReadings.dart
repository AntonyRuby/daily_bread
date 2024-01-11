import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MassReadings extends StatefulWidget {
  final dailyreadings;
  MassReadings({Key? key, @required this.dailyreadings}) : super(key: key);

  @override
  _MassReadingsState createState() => _MassReadingsState();
}

class _MassReadingsState extends State<MassReadings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final RenderBox? box =
                        context.findRenderObject() as RenderBox?;

                    if (box != null) {
                      String text = widget.dailyreadings["day"] +
                          '\n\n\n' +
                          "First Reading" +
                          '\n\n' +
                          widget.dailyreadings["first"] +
                          '\n\n' +
                          widget.dailyreadings["first_reading"] +
                          '\n\n\n' +
                          widget.dailyreadings["psalm"] +
                          '\n\n' +
                          widget.dailyreadings["psalm_reading"] +
                          '\n\n\n';
                      if (widget.dailyreadings["second"] != "") {
                        text = text +
                            "Second Reading" +
                            '\n\n' +
                            widget.dailyreadings["second"] +
                            '\n\n' +
                            widget.dailyreadings["second_reading"] +
                            '\n\n\n';
                      }
                      text = text +
                          "Gospel Reading" +
                          '\n\n' +
                          widget.dailyreadings["gospel"] +
                          '\n\n' +
                          widget.dailyreadings["gospel_reading"];

                      Share.share(
                        text,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size,
                      );
                    } else {
                      print("Error: RenderObject is null");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error sharing. Please try again."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  })
            ],
            title: Text(
              "Daily Mass Readings",
              style: Theme.of(context).textTheme.titleLarge,
            )),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    widget.dailyreadings["day"],
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, selectAll: true),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                      "First Reading" + '\n\n' + widget.dailyreadings["first"],
                      toolbarOptions: ToolbarOptions(
                          copy: true, paste: true, selectAll: true),
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    widget.dailyreadings["first_reading"],
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, selectAll: true),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    "Responsorial Psalm" +
                        '\n\n' +
                        widget.dailyreadings["psalm"],
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, selectAll: true),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    widget.dailyreadings["psalm_reading"],
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, selectAll: true),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
                if (widget.dailyreadings["second"] != "")
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SelectableText(
                        "Second Reading" +
                            '\n\n' +
                            widget.dailyreadings["second"],
                        toolbarOptions: ToolbarOptions(
                            copy: true, paste: true, selectAll: true),
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    widget.dailyreadings["second_reading"],
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, selectAll: true),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                      "Gospel" + '\n\n' + widget.dailyreadings["gospel"],
                      toolbarOptions: ToolbarOptions(
                          copy: true, paste: true, selectAll: true),
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    widget.dailyreadings["gospel_reading"],
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, selectAll: true),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )));
  }
}
