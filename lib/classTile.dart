import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentApp/LiveClassPage.dart';

class ClassTile extends StatefulWidget {
  final String name;
  final int standard;
  final int startTiming;
  final int endTiming;
  final bool isLive;
  final int numOfStudents;

  ClassTile(
      {this.name,
      this.standard,
      this.isLive,
      this.endTiming,
      this.startTiming,this.numOfStudents});

  @override
  _ClassTileState createState() => _ClassTileState();
}

class _ClassTileState extends State<ClassTile> {
  bool _validateError = false;
  @override
  void initState() {
    super.initState();
  }

  SharedPreferences prefs;
  Future<String> getTeacherId() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("teacherId");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(
        right: 15,
        top: 10,
        bottom: 10,
        left: 10,
      ),
      elevation: 7,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/classroom.jpg'),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: widget.isLive
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _validateError
                      ? Text('Class should have a name')
                      : SizedBox(
                          width: 0,
                          height: 0,
                        ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${widget.numOfStudents} Students',
                    style: TextStyle(
                      color: Colors.amber[900],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Class ${widget.standard}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${widget.startTiming} - ${widget.endTiming}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              widget.isLive
                  ? InkWell(
                      child: Center(
                        child: Icon(
                          Icons.play_circle_filled,
                          color: Colors.black,
                          size: 65,
                        ),
                      ),
                      onTap: _validateError ? null : onJoin,
                    )
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      widget.name.isEmpty ? _validateError = true : _validateError = false;
    });
    if (widget.name.isNotEmpty) {
      await _handleCameraAndMic();
      getTeacherId().then((value) {
        Firestore.instance
            .collection('Classrooms')
            .document(widget.name)
            .updateData({
          'active': true,
        });
      });
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiveClassPage(
            channelName: widget.name,
            role: ClientRole.Audience,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
