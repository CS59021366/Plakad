import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plakad1/Camera.dart';
import 'package:plakad1/Home.dart';
import 'package:plakad1/SelectShape.dart';
import 'package:plakad1/analysis.dart';
import 'package:plakad1/analysisbody.dart';

void main(){
  runApp(new MaterialApp(
    title: "เลือกรูปแบบการวิเคราะห์",
    home: SelectFunction(),
  ));
}

class SelectFunction extends StatefulWidget {
  @override
  HomeSelectFunction createState() => HomeSelectFunction();
}

class HomeSelectFunction extends State<SelectFunction> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(icon: Icon(Icons.subdirectory_arrow_left), onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HalSatu()
          ));
        }),
        title: new Text('เลือกรูปแบบการวิเคราะห์'),
      ),
      body: ListView(
        children: <Widget>[(
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 200.0),
              SizedBox(
                width: 300.0, height: 100.0,
                child: RaisedButton(
                    color: Colors.white,
                    colorBrightness: Brightness.dark,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => analysisbody()
                      ));
                    },child: Text("วิเคราะห์โดยระบบ",style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 100.0),
              SizedBox(
                width: 400.0,height: 100,
                child: RaisedButton(
                    color: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => LandingScreen()
                      ));
                    },child: Text("ส่งให้ผู้เชี่ยวชาญวิเคราะห์",style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold),)),

              ),
            ],
          ),
        )
        )],
      ),);
  }
}