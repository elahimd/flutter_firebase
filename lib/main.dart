import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(
    GenericLogger()
  );
}

class GenericLogger extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Generic Logger",
      home: Scaffold(
        appBar: AppBar(title: Text("Generic Logger"),),
        body: Material(
          color: Colors.black12,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: FlutterImageAsset(),
                ),
                Container(
                  child: Text(
                    "GENERIC LOGGER",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 21,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: GenericLoggerButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlutterImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('images/flutter.png');
    Image image = Image(image: assetImage, height: 200, width: 200,);
    return image;
  }
}

class GenericLoggerButton extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithCustomToken(token: gSA.idToken);
    print("User Name : ${user.displayName}");
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: ()=> _signIn()
          .then((FirebaseUser user) => print(user))
          .catchError((e) => print(e)),
      child: Text("Generate Logger"),
      color: Colors.blue,
      elevation: .6,
    );
  }
}