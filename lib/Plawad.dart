import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Plawad(),
    );
  }
}

class Plawad extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Plawad> {
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;
  FirebaseUser currentUser;
  DatabaseReference watchRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
    _initDB();

  }

  void _initDB() async{
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    currentUser = await firebaseAuth.currentUser();
    itemRef = watchRef = database.reference().
    child('UserHistory').
    child(currentUser.uid).
    reference();
    itemRef.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      itemRef.push().set(item.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติการวิเคราะห์'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new Column(
                  children: <Widget>[
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.network(items[index].Picture,width: 300.0,height: 200.0,),
                            SizedBox(height: 10.0),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(items[index].NAME),
                            Text(items[index].Date),
                            Text(items[index].Detail1),
                            Text(items[index].Detail2),
                            Text(items[index].Detail3),
                            Text(items[index].Detail4),
    //
                          ],
                        )
                      ],
                    ),
                    Text(items[index].value1),
                    Text(items[index].value2),
                    Text(items[index].value3),
                    Text(items[index].value4),
                    Text(items[index].value5),
                    Text(items[index].value6),
                    Text(items[index].value7),
                    Text(items[index].value8),
                    Text(items[index].value9),
                    Text(items[index].value10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  String key;
  String Picture;
  String Detail1;
  String Detail2;
  String Detail3;
  String Detail4;
  String Date;
  String NAME;
  String value1;
  String value2;
  String value3;
  String value4;
  String value5;
  String value6;
  String value7;
  String value8;
  String value9;
  String value10;

  Item(this.Picture, this.Detail1, this.Detail2, this.Detail3, this.Detail4, this.Date, this.NAME,
      this.value1, this.value2, this.value3, this.value4, this.value5, this.value6, this.value7,
      this.value8, this.value9, this.value10);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Picture = snapshot.value["Url_Picture"],
        Detail1 = snapshot.value["ชนิดครีบ"],
        Detail2 = snapshot.value["ชนิดหาง"],
        Detail3 = snapshot.value["ชนิดสี"],
        Detail4 = snapshot.value["ช่วงอายุ"],
        Date = snapshot.value["เวลาที่ทำการวิเคราะห์"],
        NAME = snapshot.value["ชื่อปลากัด"],
        value1 = snapshot.value["ตาและหัว"],
        value2 = snapshot.value["ลำตัวและเกร็ด"],
        value3 = snapshot.value["ครีบหลัง"],
        value4 = snapshot.value["ครีบหาง"],
        value5 = snapshot.value["ครับก้น"],
        value6 = snapshot.value["ครีบอื่นๆ"],
        value7 = snapshot.value["สีและลวดลาย"],
        value8 = snapshot.value["การทรงตัว"],
        value9 = snapshot.value["การพองสู้"],
        value10 = snapshot.value["ภาพรวม"];

  toJson() {
    return {
      "Url_Picture": Picture,
      "ชนิดครีบ": Detail1,
      "ชนิดหาง": Detail2,
      "ชนิดสี": Detail3,
      "ช่วงอายุ": Detail4,
      "เวลาที่ทำการวิเคราะห์": Date,
      "ชื่อปลากัด": NAME,
      'ตาและหัว': value1,
      'ลำตัวและเกร็ด': value2,
      'ครีบหลัง' : value3,
      'ครีบหาง' : value4,
      'ครับก้น' : value5,
      'ครีบอื่นๆ' : value6,
      'สีและลวดลาย' : value7,
      'การทรงตัว' : value8,
      'การพองสู้' : value9,
      'ภาพรวม' : value10,
    };
  }
}
