import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pobScaffold.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String passwd = "";
      final _formKey = GlobalKey<FormState>();
  Key key;
   final TextEditingController c1 = new TextEditingController();
   final TextEditingController c2 = new TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Image.asset('assets/prs.png'),
    );

    final email = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: username,
      onSaved: (String value) {

        username = value;
                print(value);
      },
      decoration: InputDecoration(
        hintText: 'Employee No.',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: passwd,
      obscureText: true,
      onSaved: (String value) {
        print(value);
        passwd = value;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        padding: EdgeInsets.all(12),
        color: Colors.lightBlue[300],
        child: Text('Log In', style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async{
          _formKey.currentState.save();
         SharedPreferences prefs = await SharedPreferences.getInstance();
         final  Map<String, String>  reqBody = {
            "username" : username,
            "password": passwd
          };
          Dio dio = Dio();
          http.Response res = await http.post(Uri.parse('http://10.14.151.180:5000/authenticate'),
                              headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/x-www-form-urlencoded"
                              },
                              body: reqBody,
                              encoding: Encoding.getByName("utf-8"));
          print(jsonDecode(res.body)['name']);
          if(jsonDecode(res.body)['msg'] == "success"){
            await prefs.setString("name", jsonDecode(res.body)['name']);
            await prefs.setString("username", username);
            await prefs.setBool('authenticated', true);
            print(jsonDecode(res.body)['name']);
            Navigator.of(context).pushNamed(PobScaffold.tag);
          }
        },
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
        
        body:Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child: logo),
                              SizedBox(height: 48.0),
                              email,
                              SizedBox(height: 8.0),
                              password,
                              SizedBox(height: 24.0),
                              Center(child: loginButton),
                            ],
                          ),
                        )
          ],
        ),
      )
    );
  }
}