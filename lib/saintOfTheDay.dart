import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SaintPage extends StatelessWidget {
  final Map<String, dynamic> saint;
  const SaintPage({Key? key, required this.saint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(saint["name"]),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
                final text = '\n\n' + saint["period"] + '\n\n\n' + saint["about"];
                final box = context.findRenderObject() as RenderBox?;
                if (box != null) {
                  Share.share(text, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                } else {
                  Share.share(text);
                }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
          builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                  return _buildLandscape(context);
              } else {
                  return _buildPortrait(context);
              }
          }
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildImage(context, width: MediaQuery.of(context).size.width, height: 300),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(saint["period"], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SelectableText(
                saint["about"],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      );
  }

  Widget _buildLandscape(BuildContext context) {
      return Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
             Expanded(
                 flex: 4,
                 child: Column(
                     children: [
                        _buildImage(context, height: 400, fit: BoxFit.contain),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(saint["period"], style: Theme.of(context).textTheme.titleMedium),
                        ),
                     ],
                 ),
             ),
             Expanded(
                 flex: 6,
                 child: SingleChildScrollView(
                     padding: const EdgeInsets.all(24.0),
                     child: SelectableText(
                        saint["about"],
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18, height: 1.6),
                        textAlign: TextAlign.justify,
                     ),
                 ),
             ),
         ], 
      );
  }

  Widget _buildImage(BuildContext context, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImagePage(
                        saintimage: saint["img"],
                        saintname: saint["name"])));
          },
          child: Hero(
              tag: saint["img"],
              child: Image.asset(
                saint["img"],
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (c, e, s) => Container(
                    height: height, 
                    color: Colors.grey[300], 
                    child: const Center(child: Icon(Icons.image_not_supported, size: 50))
                ),
              ),
          ),
      );
  }
}

class ImagePage extends StatelessWidget {
  final String saintimage;
  final String saintname;
  const ImagePage({Key? key, required this.saintimage, required this.saintname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                try {
                    final ByteData byte = await rootBundle.load(saintimage);
                    final Uint8List bytesOfFile = byte.buffer.asUint8List();
                    final tempDir = await getTemporaryDirectory();
                    final tempFile = await File('${tempDir.path}/saint_image.jpg').writeAsBytes(bytesOfFile);
                    await Share.shareXFiles([XFile(tempFile.path)]);
                } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Could not share image.")));
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Hero(
              tag: saintimage,
              child: Image.asset(saintimage, fit: BoxFit.contain),
          ),
        ));
  }
}
