import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class LaunchUrlApp extends StatelessWidget {
  final Uri _url = Uri.parse('https://www.arcgis.com/apps/instant/insets/index.html?appid=d164d6d01860453aaf5320ed62c76350');

  LaunchUrlApp() {
    UrlLauncherHelper.launchUrl(_url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Placeholder widget
        ),
      ),
    );
  }
}

class UrlLauncherHelper {
  static Future<void> launchUrl(Uri url) async {
    if (!await canLaunch(url.toString())) {
      throw Exception('Could not launch $url');
    }
    await launch(url.toString());
  }
}

