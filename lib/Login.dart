// import '../HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studentApp/globalData.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool toKeepLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(  
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/logo.png'),
              ), 
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 29,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Mobile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: userNameController,
                          enabled: true,
                          maxLengthEnforced: true,
                          minLines: 1,
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          dragStartBehavior: DragStartBehavior.start,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                            hintText: "Registered Mobile",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 29,
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Class Id", 
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: passwordController,
                          enabled: true,
                          maxLengthEnforced: true,
                          minLines: 1,
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          dragStartBehavior: DragStartBehavior.start,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                            hintText: "Enter Class Id",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30, top: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Checkbox(
                    //     activeColor: Colors.blue[900],
                    //     value: toKeepLoggedIn,
                    //     onChanged: (isSelected) {
                    //       toKeepLoggedIn = isSelected;
                    //       setState(() {});
                    //     }),
                    // Text(
                    //   'Keep Me Logged In',
                    //   style: TextStyle(fontWeight: FontWeight.w500),
                    // ),
                    // Expanded(
                    //   child: SizedBox(),
                    // ),
                    // Text(
                    //   'Forgot Password',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w600,
                    //     color: Colors.blue[900],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20, 
                  bottom: 30
                ),
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blue[900],
                  onPressed: () async {
                    print(userNameController.text);
                    print(passwordController.text);
                    await Firestore.instance
                        .collection("Teachers")
                        .where(
                          "email",
                          isEqualTo: userNameController.text,
                        )
                        .where("password",
                            isEqualTo: passwordController.text.toString())
                        .getDocuments()
                        .then((QuerySnapshot docs) async {
                      if (docs.documents.length == 0) {
                        print("LENGTH IS ZERO");
                      } else {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             HomeScreen()));
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (toKeepLoggedIn) {
                          await prefs.setString(
                              "email", userNameController.text);
                          await prefs.setString(
                              "password", passwordController.text);
                          print(docs.documents[0].data["teacherId"]);
                          await prefs.setString(
                              "teacherId", docs.documents[0].data["teacherId"]);
                        } else {
                          await prefs.setString(
                              "teacherId", docs.documents[0].data["teacherId"]);
                        }
                      }
                    });
                  },
                  child: Text( 
                    'Login to Classroom', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
