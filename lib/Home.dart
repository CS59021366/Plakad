import 'package:flutter/material.dart';
import 'package:plakad1/Camera.dart';
import 'package:plakad1/Kitjakam.dart';
import 'package:plakad1/Plawad.dart';
import 'package:plakad1/ProFile.dart';
import 'package:plakad1/Punhar.dart';
import 'package:plakad1/quamroo.dart';
import 'package:plakad1/quiry.dart';

import 'Voteapp.dart';

void main(){
  runApp(new MaterialApp(
      title : "Analysis Fish Fighting",
      home : new HalSatu(),
      theme: new ThemeData(
          primarySwatch: Colors.blueGrey//สีหัวข้อผ
      )
  ));
}

class HalSatu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87, //สัพื้นหลังของแอป
      appBar: new AppBar(
        title: new Center(child: new Text('Menu',textAlign: TextAlign.center,style: TextStyle(fontSize: 50),)),
        leading: IconButton(icon: Icon(Icons.notifications),
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ProFile()
          ));
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(
              Icons.supervised_user_circle), onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProFile()
            ));
          }),
        ],
      ),
      body: new ListView(children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Function1(teks: "วิเคราะห์ปลากัด"),
                Function2(teks: "กิจกรรมที่จัดแข่ง"),
              ],),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Function3(teks: "ประวัติการวิเคราะห์"),
                Function4(teks: "วิธีดูความงามปลากัด"),
              ],),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Function5(teks: "รายงานปัญหา"),
                Function6(teks: "ให้คะแนนแอป"),
              ],
            ),
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
              builder: (context) => LandingScreen()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/Analysis.png',width: 150.0,height: 150.0,fit: BoxFit.cover,),
            new Text(teks, style: new TextStyle(fontSize: 25.0,color: Colors.white70),),
            new Padding(padding: new EdgeInsets.all(0.0),),

          ],
        ),
      ),
    );
  }
}
class Function2 extends StatelessWidget{ //class สร้างfunction

  Function2 ({this.teks});

  final String teks;

  @override
  Widget build(BuildContext context){
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.black87,borderRadius: new BorderRadius.circular(0.0)),
      alignment: Alignment.center,
      padding: new EdgeInsets.only(left: 5.0, right: 5.0, top: 30.0, bottom: 30.0),//ระยะห่างของแต่ละบรรทัด
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Kitjakam()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/Kitjakam.png',width: 150.0,height: 150.0,fit: BoxFit.cover,),
            new Text(teks, style: new TextStyle(fontSize: 25.0,color: Colors.white70),),
            new Padding(padding: new EdgeInsets.all(0.0),),
          ],
        ),
      ),
    );
  }
}

class Function3 extends StatelessWidget{ //class สร้างfunction

  Function3 ({this.teks});

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
            new Image.asset('assets/Plawad.png',width: 150.0,height: 150.0,fit: BoxFit.cover,),
            new Text(teks, style: new TextStyle(fontSize: 25.0,color: Colors.white70),),
            new Padding(padding: new EdgeInsets.all(0.0),),
          ],
        ),
      ),
    );
  }
}

class Function4 extends StatelessWidget{ //class สร้างfunction

  Function4 ({this.teks});

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
              builder: (context) => Quamroo()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/Quamroo.png',width: 150.0,height: 150.0,fit: BoxFit.cover,),
            new Text(teks, style: new TextStyle(fontSize: 25.0,color: Colors.white70),),
            new Padding(padding: new EdgeInsets.all(0.0),),
          ],
        ),
      ),
    );
  }
}

class Function5 extends StatelessWidget{ //class สร้างfunction

  Function5 ({this.teks});

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
              builder: (context) => Punhar()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/Panhar.png',width: 150.0,height: 150.0,fit: BoxFit.cover,),
            new Text(teks, style: new TextStyle(fontSize: 25.0,color: Colors.white70),),
            new Padding(padding: new EdgeInsets.all(0.0),),
          ],
        ),
      ),
    );
  }
}

class Function6 extends StatelessWidget{ //class สร้างfunction

  Function6 ({this.teks});

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
              builder: (context) => Voteapp()
          )); //MaterialPageRoute
        },
        child: new Column(
          children: <Widget>[
            new Image.asset('assets/Voteapp.png',width: 150.0,height: 150.0,fit: BoxFit.cover,),
            new Text(teks, style: new TextStyle(fontSize: 25.0,color: Colors.white70),),
            new Padding(padding: new EdgeInsets.all(0.0),),
          ],
        ),
      ),
    );
  }
}
