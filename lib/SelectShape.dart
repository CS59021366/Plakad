import 'package:flutter/material.dart';
import 'package:plakad1/analysisbody.dart';
import 'package:plakad1/select_function.dart';

import 'analysis.dart';

void main(){
  runApp(new MaterialApp(
      title : "Analysis Fish Fighting",
      home : new SelectShape(),
      theme: new ThemeData(
          primarySwatch: Colors.blueGrey//สีหัวข้อผ
      )
  ));
}

class SelectShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87, //สัพื้นหลังของแอป
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: new Text('ส่วนที่ต้องการวิเคราะห์'),
        leading: IconButton(icon: Icon(Icons.subdirectory_arrow_left), onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SelectFunction()
          ));
        }),
      ),
      body: new ListView(children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Function1(teks: "วิเคราะห์ส่วนหัว"),
                Function2(teks: "วิเคราะห์ส่วนลำตัว"),
              ],),
          ],
        ),
      ],

      ),
    );
  }
}

class Function1 extends StatelessWidget{ //class สร้างfunction

  Function1 ({this.teks});

  final String teks;

  @override
  Widget build(BuildContext context){
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.black87,borderRadius: new BorderRadius.circular(0.0)
      ),
      alignment: Alignment.center,
      padding: new EdgeInsets.only(left: 5.0, right: 5.0, top: 30.0, bottom: 30.0),//ระยะห่างของแต่ละบรรทัด
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => analysishead()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/head.jpg',width: 150.0,height: 150.0,fit: BoxFit.cover,),
            new Text(teks, style: new TextStyle(fontSize: 25.0,color: Colors.white),),
            new Padding(padding: new EdgeInsets.all(0.0),),

          ],
        ),
      ),
    );
  }
}
class Function2 extends StatelessWidget {
  //class สร้างfunction

  Function2({this.teks});

  final String teks;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.black87, borderRadius: new BorderRadius.circular(0.0)),
      alignment: Alignment.center,
      padding: new EdgeInsets.only(
          left: 5.0, right: 5.0, top: 30.0, bottom: 30.0),
      //ระยะห่างของแต่ละบรรทัด
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => analysisbody()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/body.jpg', width: 150.0,
              height: 150.0,
              fit: BoxFit.cover,),
            new Text(teks,
              style: new TextStyle(fontSize: 25.0, color: Colors.white),),
            new Padding(padding: new EdgeInsets.all(0.0),),
          ],
        ),
      ),
    );
  }
}