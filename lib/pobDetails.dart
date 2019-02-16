import 'package:flutter/material.dart';
import 'package:pobappen/pob.dart';
import 'package:intl/intl.dart';


class PobDetail extends StatelessWidget {
  final Pob pob;

  PobDetail({this.pob});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(child : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(child:Text(pob.nominatedOfficer.split(",")[0],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0))),
                  Center(child:Text(pob.nominatedOfficer.split(",")[1],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0))),
                  Center(child:Text(pob.nominatedOfficer.split(",")[2],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0))),
                  Center(child:Text("Team ID: ${pob.teamid}")),
                  Center(child:Text("Pat on Back ID: ${pob.id}")),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: 
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Center(child:Text(
                          "Remarks : ${pob.nominatingRemarks}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    ),
                  ),  
                    // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: pob.type
                  //       .map((t) => FilterChip(
                  //           backgroundColor: Colors.amber,
                  //           label: Text(t),
                  //           onSelected: (b) {}))
                  //       .toList(),
                  // ),
                  Center(child:Text("Nomination Date: ${new DateFormat.yMMMd().format(DateTime.parse(pob.dtNomination))}",
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: pob.weaknesses
                  //       .map((t) => FilterChip(
                  //           backgroundColor: Colors.red,
                  //           label: Text(
                  //             t,
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //           onSelected: (b) {}))
                  //       .toList(),
                  // ),
                  // Text("Next Evolution",
                  //     style: TextStyle(fontWeight: FontWeight.bold)),
                  // // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: pob.nextEvolution
                  //       .map((n) => FilterChip(
                  //           backgroundColor: Colors.green,
                  //           label: Text(n.name,
                  //               style: TextStyle(color: Colors.white)),
                  //           onSelected: (b) {}))
                  //       .toList(),
                  // ),
                ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: pob,
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                         image: NetworkImage('https://xsparsh.indianoil.in/APIManager/empphoto/${pob.recommEmpno}.jpg'),
                          fit: BoxFit.cover,
                  )),
            )),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.lightBlue[400],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.lightBlue[300],
        title: Text(pob.id),
      ),
      body: bodyWidget(context),
    );
  }
}
