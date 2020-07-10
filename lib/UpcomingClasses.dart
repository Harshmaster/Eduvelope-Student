import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studentApp/classTile.dart';

import 'globalData.dart';

class UpcomingClassesScreen extends StatefulWidget {
  @override
  _UpcomingClassesScreenState createState() => _UpcomingClassesScreenState();
}

class _UpcomingClassesScreenState extends State<UpcomingClassesScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (ctx, stream) {
        if (stream.connectionState == ConnectionState.waiting) {
          return (Center(
            child: CircularProgressIndicator(),
          ));
        }
        return ListView.builder(
          itemBuilder: (ctx, index) {
            if(stream.data.documents[index]['className'] == globalclass && stream.data.documents[index]['active'] == false && (stream.data.documents[index]['endTiming'] > int.parse(DateFormat.H().format(DateTime.now()))*100)){
              return ClassTile(
                endTiming: stream.data.documents[index]['end'],
                isLive: false,
                name: stream.data.documents[index]['className'],
                numOfStudents: stream.data.documents[index]['students'].length,
                standard: stream.data.documents[index]['standard'],
                startTiming: stream.data.documents[index]['start'],
              );
            }
            else{
              return SizedBox(width: 0, height: 0,);
            }
          },
          itemCount: stream.data.documents.length,
        );
      },
      stream: Firestore.instance.collection('Classrooms').snapshots(),
    );
  }
}