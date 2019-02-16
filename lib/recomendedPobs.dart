import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pobappen/pob.dart';
import 'package:dio/dio.dart';
import 'package:pobappen/pobDetails.dart';
import 'package:intl/intl.dart';
import 'login_page.dart';
import 'recomendedPobs.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'pobDrawer.dart';
import 'pobGrid.dart';

class RecomendedPobs extends StatelessWidget {
  PobHub pobHub;
  RecomendedPobs({this.pobHub});
  @override
   Widget build(BuildContext context) {
    return new Container(
          decoration: new BoxDecoration(
          color: Colors.lightBlue[300],
          shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            new BoxShadow(  
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ],
      ),
        child : PobGrid(pobHub: this.pobHub)
      );
  }
}