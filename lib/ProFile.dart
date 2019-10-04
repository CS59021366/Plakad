import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plakad1/Home.dart';
import 'package:plakad1/Sign-In.dart';

class ProFile extends StatefulWidget {
  const ProFile({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;
  @override
  _ProFileState createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Color(0xFF5DB7DE))),
        backgroundColor: Color(0xFFEBE4D6),
        body:  ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image(
                        image: new AssetImage("assets/user.png"), height: 120.0, width: 120.0)
                  ],//<Widget>[]
                ),//Container
              ),//Column
            ),//Padding
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SizedBox(
                    height: 95.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                    child: new Container(
                      alignment: Alignment.topLeft,
                      height: 40.0,
                      child: new Container(
                        child: new Column(
                          children: <Widget>[
                            new Text('Email' ,style: TextStyle(fontSize: 23.0, color: Colors.black)),
                          ],//<Widget>[]
                        ),//Column
                      ),//Container
                    ),//padding
                  ),//Expanded
                )//Expanded
              ],//<Widget>[]
            ),//Row
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: new Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: new BoxDecoration(
                          color: Color(0xFFDBAC99),borderRadius: new BorderRadius.circular(10.0)),
                      child: new Container(
                        child: new GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HalSatu()));
                          },//onTap
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("HISTORY ANALYSIS",style: TextStyle(fontSize: 25.0, color: Colors.black)),
                            ],//<Widget>[]
                          ),//Column
                        ),//GestureDetector
                      ),//GestureDetector
                    ),//Container
                  ),//Padding
                )//Expanded
              ],//<Widget>[]
            ),//Row
            new Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Container(
                          child: RaisedButton(
                            onPressed: signOut,
                            color: Color(0xFFDBAC99),
                            child: Text('Sign Out'),
                          ),//RaiseButton
                        ),//Container
                      )//Padding
                    ],//<Widget>[]
                  ),//Column
                )//Expanded
              ],//<Widget>[]
            )//Row
          ],//<Widget>[]
        )//ListView
    );
  }
  void signOut() async{
    _firebaseAuth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageV2()));
  }
}
