import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentApp/classTile.dart';
import 'package:studentApp/globalData.dart';

class LiveClassScreen extends StatefulWidget {
  @override
  _LiveClassScreenState createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> {
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
            if (stream.data.documents[index]['className'] == classid &&
                stream.data.documents[index]['active'] == true) {
              return ClassTile(
                endTiming: stream.data.documents[index]['endTiming'],
                isLive: true,
                name: stream.data.documents[index]['className'],
                numOfStudents: stream.data.documents[index]['students'].length,
                standard: stream.data.documents[index]['standard'],
                startTiming: stream.data.documents[index]['startTiming'],
              );
            } else {
              return SizedBox(
                width: 0,
                height: 0,
              );
            }
          },
          itemCount: stream.data.documents.length,
        );
      },
      stream: Firestore.instance.collection('Classrooms').snapshots(),
    );
  }
}
