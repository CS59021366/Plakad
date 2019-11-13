import 'package:flutter/material.dart';
import 'package:plakad1/HistoryAuto.dart';
import 'package:plakad1/Home.dart';
import 'package:plakad1/Plawad.dart';
import 'package:plakad1/select_function.dart';

void main(){
  runApp(new MaterialApp(
      title : "Analysis Fish Fighting",
      home : new SelectHistory(),
      theme: new ThemeData(
          primarySwatch: Colors.blueGrey//สีหัวข้อผ
      )
  ));
}

class SelectHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87, //สัพื้นหลังของแอป
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: new Text('ส่วนที่ต้องการวิเคราะห์'),
        leading: IconButton(icon: Icon(Icons.subdirectory_arrow_left), onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HalSatu()
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
                SizedBox(height: 70.0),
                Function1(teks: "ปลากัดที่ผู้เชี่ยวชาญวิเคราะห์"),
                SizedBox(height: 50.0),
                Function2(teks: "ปลากัดที่ระบบวิเคราะห์"),
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
              builder: (context) => Plawad()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/historyexperts.png',width: 150.0,height: 150.0,fit: BoxFit.cover,),
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
              builder: (context) => HistoryAuto()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/historyauto.png', width: 150.0,
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