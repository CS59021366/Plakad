import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plakad1/main.dart';

void main() {
  runApp(new MaterialApp(
    title: "Camera App",
    home: Plawad(),
  )
  );
}

class Plawad extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plawad plakad',
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      home: Plawad1(title: 'ประวัติวิเคราะห์ปลากัด'),
    );
  }
}

class Plawad1  extends StatefulWidget {
  Plawad1({Key key ,this.title}) : super(key: key);

  final String title;

  @override
  _HomePlawad createState() => _HomePlawad();
}

class _HomePlawad extends State<Plawad1>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(icon: Icon(Icons.subdirectory_arrow_left), onPressed: (){
         Navigator.push(context, MaterialPageRoute(
             builder: (context) => HalSatu()
         ));
       }),
        title: Text('ประวัติการวิเคราะห์'),
        actions: <Widget>[
          IconButton(icon: Icon(
            Icons.menu), onPressed: (){
            //
          }),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 260.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit:  BoxFit.scaleDown,
                    image: AssetImage('assets/Noimage.png')
                  )
                )
              ),
            ),
             ExpansionTile(
               trailing: Icon(Icons.search),
              title: Text('ปลากัดตัวที่ 1'),
              children: <Widget>[
              new Row(
                children: <Widget>[
                Column(
                  children: <Widget>[
                    new Text('       สัดส่วนของปลากัด       '),
                    new Text('หัวและตา'),
                    new Text('ลำตัวและเกร็ด'),
                    new Text('ครับหลัง'),
                    new Text('ครีบหาง'),
                    new Text('ครับก้น'),
                    new Text('ครีบอื่นๆ'),
                    new Text('สีและลวดลาย'),
                    new Text('การทรงตัว'),
                    new Text('การพองสู้'),
                    new Text('ภาพรวม')
                ],),
                Column(
                  children: <Widget>[
                    new Text('       ระบบวิเคราะห์       '),
                    new Text('8 คะแนน'),
                    new Text('7 คะแนน'),
                    new Text('10 คะแนน'),
                    new Text('4 คะแนน'),
                    new Text('3 คะแนน'),
                    new Text('8 คะแนน'),
                    new Text('15 คะแนน'),
                    new Text('8 คะแนน'),
                    new Text('9 คะแนน'),
                    new Text('6 คะแนน'),
                  ],),
                Column(
                  children: <Widget>[
                    new Text('       ผู้เชี่ยวชาญวิเคราะห์       '),
                    new Text('8 คะแนน'),
                    new Text('7 คะแนน'),
                    new Text('10 คะแนน'),
                    new Text('4 คะแนน'),
                    new Text('3 คะแนน'),
                    new Text('8 คะแนน'),
                    new Text('15 คะแนน'),
                    new Text('8 คะแนน'),
                    new Text('9 คะแนน'),
                    new Text('6 คะแนน'),
                  ],
                )
              ],
              ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 260.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit:  BoxFit.scaleDown,
                          image: AssetImage('assets/Noimage.png')
                      )
                  )
              ),
            ),
            ExpansionTile(
              trailing: Icon(Icons.search),
              title: Text('ปลากัดตัวที่ 2'),
              children: <Widget>[
                new Row(children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Text('       สัดส่วนของปลากัด       '),
                      new Text('หัวและตา'),
                      new Text('ลำตัวและเกร็ด'),
                      new Text('ครับหลัง'),
                      new Text('ครีบหาง'),
                      new Text('ครับก้น'),
                      new Text('ครีบอื่นๆ'),
                      new Text('สีและลวดลาย'),
                      new Text('การทรงตัว'),
                      new Text('การพองสู้'),
                      new Text('ภาพรวม')
                    ],),
                  Column(
                    children: <Widget>[
                      new Text('       ระบบวิเคราะห์       '),
                      new Text('8 คะแนน'),
                      new Text('7 คะแนน'),
                      new Text('10 คะแนน'),
                      new Text('4 คะแนน'),
                      new Text('3 คะแนน'),
                      new Text('8 คะแนน'),
                      new Text('15 คะแนน'),
                      new Text('8 คะแนน'),
                      new Text('9 คะแนน'),
                      new Text('6 คะแนน'),
                    ],),
                  Column(
                    children: <Widget>[
                      new Text('       ผู้เชี่ยวชาญวิเคราะห์       '),
                      new Text('8 คะแนน'),
                      new Text('7 คะแนน'),
                      new Text('10 คะแนน'),
                      new Text('4 คะแนน'),
                      new Text('3 คะแนน'),
                      new Text('8 คะแนน'),
                      new Text('15 คะแนน'),
                      new Text('8 คะแนน'),
                      new Text('9 คะแนน'),
                      new Text('6 คะแนน'),
                    ],
                  )
                ],
                ),
              ],
            ),
        ],
      )
    );
  }
}