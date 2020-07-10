import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentApp/LiveClasses.dart';
import 'package:studentApp/UpcomingClasses.dart';
import 'package:studentApp/globalData.dart';

import 'Login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              automaticallyImplyLeading: false,
              actions: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.power_settings_new),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Alert'),
                            content: Text('Do you want To Logout ?'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  globalclass = null;
                                  globalstudentid = null;
                                  globalmobile = null;
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Login()));
                                },
                                child: Text('OK'),
                              )
                            ],
                          );
                        });
                  },
                ),
              ],
              title: Text('Eduvelope'),
              backgroundColor: Colors.blue[900],
              elevation: 0,
              bottom: TabBar(
                  labelColor: Colors.blue[900],
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(10),
                      //     topRight: Radius.circular(10)),
                      color: Colors.white),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Live"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Upcoming"),
                      ),
                    ),
                  ]),
            ),
          ),
          body: TabBarView(children: [
            LiveClassScreen(),
            UpcomingClassesScreen(),
          ]),
        ));
  }
}