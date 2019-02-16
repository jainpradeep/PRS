import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pobappen/pob.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dio/dio.dart';
import 'package:pobappen/pobDetails.dart';
import 'package:intl/intl.dart';
import 'login_page.dart';
import 'recomendedPobs.dart';
import 'pobScaffold.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

typedef void StringCallback(String val);
final StringCallback callback = null;

void main() => runApp(MaterialApp(
      title: "Pat on Back App",
      home: PobApp(),
      debugShowCheckedModeBanner: false,
));



class PobApp extends StatefulWidget {
  @override
  PobAppState createState() => new PobAppState();
}

class PobAppState extends State<PobApp>{
  bool authenticated = false;
  SharedPreferences prefs = null;
  @override
  void initState() {
      checkLogin();
      super.initState();
  }

  checkLogin() async {
   prefs = await SharedPreferences.getInstance();
      bool authenticated = prefs.getBool('authenticated');
      setState(() { });
  }
  
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    PobScaffold.tag: (context) => PobScaffold(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pat on Back App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: (this.authenticated == false 
            ? LoginPage() 
            : PobScaffold()),
      routes: routes,
    );
  }
}


