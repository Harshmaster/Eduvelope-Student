import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:studentApp/LiveClassPage.dart';

class VirtualClassroom extends StatefulWidget {
  final String recieverchannel;
  final String broadcastchannel;
  VirtualClassroom({this.broadcastchannel, this.recieverchannel});
  @override
  _VirtualClassroomState createState() => _VirtualClassroomState();
}

class _VirtualClassroomState extends State<VirtualClassroom> {
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top) /
                2,
            child: LiveClassPage(
              channelName: widget.recieverchannel,
              role: ClientRole.Audience,
            ),
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top) /
                2,
            child: LiveClassPage(
              channelName: widget.broadcastchannel,
              role: ClientRole.Broadcaster,
            ),
          ),
        ],
      ),
    );
  }
}
