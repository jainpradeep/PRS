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
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

class PobScaffold extends StatefulWidget {
  static String tag = 'Approved-page';
  @override
  PobScaffoldState createState() => new PobScaffoldState();
}

class PobScaffoldState extends State<PobScaffold> {
  SharedPreferences prefs = null;
    PobHub pobHub;
    PobDetail pobDetail;
    Widget redederedQidget;
    String currentState = "ApporvedPobs";
    @override
    void initState(){
        fetchData();
        super.initState();
    }

    fetchData() async {
        prefs = await SharedPreferences.getInstance();
      
      http.Response res  = await http.post(Uri.parse('http://10.14.151.180:5000/approvedPOBs'),
                              headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/x-www-form-urlencoded"
                              },
                              body: {},
                              encoding: Encoding.getByName("utf-8"));
                              print(jsonDecode(res.body));
        Map<String, dynamic> dmap =jsonDecode(res.body)['record']);
        pobHub = PobHub.fromJson(dmap);
print(pobHub);
        redederedQidget  = this.setCurrentState();
       
        setState(() {   
        });
    }

  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
      final TextEditingController filter = new TextEditingController();
      final dio = new Dio();
      String searchText = "";
      List names = new List();
      List filteredNames = new List();
      Icon searchIcon = new Icon(Icons.search);
      Widget appBarTitle = new Text( 'Pat On Back' );

    //{this.callback}
    PobScaffoldState() {
      filter.addListener(() {
        if (filter.text.isEmpty) {
          setState(() {
            searchText = "";
            filteredNames = names;
          });
        } else {
          setState(() {
            searchText = filter.text;
          });
        }
      });
    }




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pobAppBar(context),
      body: redederedQidget,
      drawer:  Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
        child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            // accountName: Text(prefs.getString('name')),
            // accountEmail: Text(prefs.getString('username')),
            currentAccountPicture:  Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                         image: NetworkImage('https://xsparsh.indianoil.in/APIManager/empphoto/${int.parse(prefs.getString("username"))}.jpg'),
                          fit: BoxFit.cover,
                  )),
          )),
          ListTile(
            title: Text('Annual POBs'),
            onTap: () {
              this.currentState = "AnnualPobs";
              fetchData();
              // setState((){});
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Approved'),
            onTap: () {
              this.currentState = "ApporvedPobs";
              fetchData();
              // setState((){});
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Recomended'),
            onTap: () {
              this.currentState = "RecomendedPobs";
               fetchData();
              // setState((){});
              // callback("recomendedPobs");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Nominated'),
            onTap: () {
              this.currentState = "NominatedPobs";
              fetchData();
              // setState((){});
              // callback("nominatedPobs");
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () async{
              // Update the state of the app
              // ...
              // Then close the drawer  
              await prefs.setBool('authenticated', false);
              Navigator.of(context).pushNamed(LoginPage.tag);
            },
          )
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),   
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget setCurrentState() {
    switch(this.currentState) { 
        case "ApporvedPobs": { 
          setState(() {   
          });
          return ApporvedPobs(pobHub: this.pobHub);
        } 
        case "RecomendedPobs": { 
            //print("RecomendedPobs");
                     print("asasasas");
          setState(() {   
          }); 
            return RecomendedPobs(pobHub: this.pobHub);
        } 
        // case "NominatedPobs": { 
        //     return NominatedPobs();
        // } 
        // case "AnnualPobs": { 
        //     return AnnualPobs();
        // }  
        break; 
      }
  }


// Widget PobGrid(BuildContext context) {
//     return this.pobHub == null
//           ? Center( 
//               child: CircularProgressIndicator(),
//             )
//           :  GridView.count(
//               crossAxisCount: 2,
//               children: pobHub.pob
//                   .map((card) => Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => PobDetail(
//                                           pob: card,
//                                         )));
//                           },
//                           child: Hero(
//                             tag: card.id,
//                             child: Card(
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Container(
//                                     height: 100.0,
//                                     width: 100.0,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     image: DecorationImage(
//                                           image: NetworkImage('https://xsparsh.indianoil.in/APIManager/empphoto/${card.recommEmpno}.jpg'),
//                                           fit: BoxFit.cover,
//                                         )),
//                                 ),
//                                 Center(child:Text(card.nominatedOfficer.split(",")[0],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0))),
//                                 Center(child:Text(card.nominatedOfficer.split(",")[1],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0))),
//                                 Center(child:Text(card.nominatedOfficer.split(",")[2],  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0))),
                                
//                                   // Text(
//                                   //   card.nominatedOfficer,
//                                   //   textAlign: TextAlign.center,
//                                   //   style: TextStyle(
//                                   //     fontSize: 10.0,
//                                   //     fontWeight: FontWeight.bold,
//                                   //   ),
//                           //        )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ))
//                       .toList(),
//             );
//  }

  Widget pobAppBar(BuildContext context) {
    return new AppBar(

        title: appBarTitle,
        backgroundColor: Colors.lightBlue[400],
        actions: <Widget>[
        IconButton(
          icon: searchIcon,
          onPressed: searchPressed,
        )],
    );
  }

  // Widget buildList() {
  //   if (!(searchText.isEmpty)) {
  //     List tempList = new List();
  //     for (int i = 0; i < filteredNames.length; i++) {
  //       if (filteredNames[i]['name'].toLowerCase().contains(searchText.toLowerCase())) {
  //         tempList.add(filteredNames[i]);
  //       }
  //     }
  //     filteredNames = tempList;
  //   }
  //   return ListView.builder(
  //     itemCount: names == null ? 0 : filteredNames.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return new ListTile(
  //         title: Text(filteredNames[index]['name']),
  //         onTap: () => print(filteredNames[index]['name']),
  //       );
  //     },
  //   );
  // }

  void searchPressed() {
    setState(() {
      if (this.searchIcon.icon == Icons.search) {
        this.searchIcon = new Icon(Icons.close);
        this.appBarTitle = new TextField(
          controller: filter,
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...'
          ),
        );
      } else {
        this.searchIcon = new Icon(Icons.search);
        this.appBarTitle = new Text( 'Pat on Back' );
        filteredNames = names;
        filter.clear();
      }
    });
  }

  // void getNames() async {
  //   final response = await dio.get('https://swapi.co/api/people');
  //   List tempList = new List();
  //   for (int i = 0; i < response.data['results'].length; i++) {
  //     tempList.add(response.data['results'][i]);
  //   }
  //   setState(() {
  //     names = tempList;
  //     names.shuffle();
  //     filteredNames = names;
  //   });
  // }


}