import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Saint extends StatefulWidget {
  final saint;
  Saint({Key? key, @required this.saint}) : super(key: key);

  @override
  _SaintState createState() => _SaintState();
}

class _SaintState extends State<Saint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.saint["name"],
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              final RenderBox? box = context.findRenderObject() as RenderBox?;
              if (box != null) {
                String text = '\n\n' +
                    widget.saint["period"] +
                    '\n\n\n' +
                    widget.saint["about"];
                Share.share(
                  text,
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size,
                );
              }
            },
          )
        ],
      ),
      body: saintDetails(),
    );
  }

  Widget saintDetails() {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _image(),
            _about(),
          ],
        ),
      );
    } else {
      return Row(
        children: <Widget>[
          _imageLandscape(),
          Container(
            width: MediaQuery.of(context).size.width / 1.8,
            height: MediaQuery.of(context).size.height,
            child: _landscapeDetailsSection(),
          ),
        ],
      );
    }
  }

  Widget _image() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.05,
          height: MediaQuery.of(context).size.height / 2.50,
          child: GestureDetector(
              child: Image(
                image: AssetImage(widget.saint["img"]),
                fit: BoxFit.contain,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePage(
                            saintimage: widget.saint["img"],
                            saintname: widget.saint["name"])));
              }),
        ),
        SelectableText(widget.saint["period"],
            toolbarOptions:
                ToolbarOptions(copy: true, paste: true, selectAll: true),
            style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  Widget _about() {
    return Column(
      children: <Widget>[
        Container(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SelectableText(
            widget.saint["about"],
            toolbarOptions:
                ToolbarOptions(copy: true, paste: true, selectAll: true),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
        ))
      ],
    );
  }

  Widget _imageLandscape() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 2.5,
            child: GestureDetector(
                child: Image(
                  image: AssetImage(
                    widget.saint["img"],
                  ),
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImagePage(
                              saintimage: widget.saint["img"],
                              saintname: widget.saint["name"])));
                })),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          child: SelectableText(widget.saint["period"],
              toolbarOptions:
                  ToolbarOptions(copy: true, paste: true, selectAll: true),
              style: Theme.of(context).textTheme.titleMedium),
        )
      ],
    );
  }

  Widget _landscapeDetailsSection() {
    return SingleChildScrollView(
        child: Column(children: <Widget>[_aboutLandscape()]));
  }

  Widget _aboutLandscape() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: SelectableText(
            widget.saint["about"],
            toolbarOptions:
                ToolbarOptions(copy: true, paste: true, selectAll: true),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}

class ImagePage extends StatelessWidget {
  final saintimage;
  final saintname;
  ImagePage({Key? key, @required this.saintimage, @required this.saintname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () async {
                final ByteData byte = await rootBundle.load(saintimage);
                final Uint8List bytesOfFile = byte.buffer.asUint8List();

                final tempDir = await getTemporaryDirectory();
                final tempFile = await File('${tempDir.path}/saint_image.jpg')
                    .writeAsBytes(bytesOfFile);

                // Use Share.shareFiles to share with name
                await Share.shareFiles(
                  [tempFile.path],
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(saintimage), fit: BoxFit.contain),
            ),
          ),
        ));
  }
}
