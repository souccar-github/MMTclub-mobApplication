import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(DemoPage());
}

class DemoPage extends StatelessWidget {
  _launchTo(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Offline Demo"),
          ),
          body: TextButton(
              onPressed: () async {
                await _launchTo("tel://<+963958623726>");
              },
              style: TextButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  elevation: 1),
              child: Icon(Icons.phone))),
    );
  }
}
