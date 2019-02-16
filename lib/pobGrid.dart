import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pobappen/pob.dart';
import 'package:dio/dio.dart';
import 'package:pobappen/pobDetails.dart';
import 'package:intl/intl.dart';
import 'login_page.dart';
import 'recomendedPobs.dart';
import 'approvedPobs.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';



class PobGrid extends StatelessWidget {
  PobHub pobHub;
  PobGrid({this.pobHub});
  @override
   Widget build(BuildContext context) {
    return this.pobHub == null
          ? Center( 
              child: CircularProgressIndicator(),
            )
          :  GridView.count(
              crossAxisCount: 2,
              children: pobHub.pob
                  .map((card) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PobDetail(
                                          pob: card,
                                        )));
                          },
                          child: Hero(
                            tag: card.id,
                            child: Card(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                          image: NetworkImage('https://xsparsh.indianoil.in/APIManager/empphoto/${card.recommEmpno}.jpg'),
                                          fit: BoxFit.cover,
                                        )),
                                ),
                                Center(child:Text(card.nominatedOfficer.split(",")[0],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0))),
                                Center(child:Text(card.nominatedOfficer.split(",")[1],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0))),
                                Center(child:Text(card.nominatedOfficer.split(",")[2],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0))),
                                
                                  // Text(
                                  //   card.nominatedOfficer,
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //     fontSize: 10.0,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                          //        )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                      .toList(),
            );
  }

}



 