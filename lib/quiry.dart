import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Home02(),
    );
  }
}

class Home02 extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home02> {
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;
  String getUID;
  FirebaseUser currentUser;
  DatabaseReference watchRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("", "", "", "", "", "", "");
    _initDB();

  }

  void _initDB() async{
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    currentUser = await firebaseAuth.currentUser();
    itemRef = watchRef = database.reference().
    child('ปลากัดที่ส่งให้ผู้เชี่ยวชาญวิเคราะห์').
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
                return new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.network(items[index].Picture,width: 300.0,height: 200.0,fit: BoxFit.cover),
                        SizedBox(height: 10.0),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(items[index].NAME),
                        Text(items[index].Date),
                        Text(items[index].value1),
                        Text(items[index].value2),
                        Text(items[index].value3),
                        Text(items[index].value4),
                      ],
                    )
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
  String value1;
  String value2;
  String value3;
  String value4;
  String Date;
  String NAME;

  Item(this.Picture, this.value1, this.value2, this.value3, this.value4, this.Date, this.NAME);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Picture = snapshot.value["Url_Picture"],
        value1 = snapshot.value["ชนิดครีบ"],
        value2 = snapshot.value["ชนิดหาง"],
        value3 = snapshot.value["ชนิดสี"],
        value4 = snapshot.value["ช่วงอายุ"],
        Date = snapshot.value["เวลาที่ทำการวิเคราะห์"],
        NAME = snapshot.value["ชื่อปลากัด"];

  toJson() {
    return {
      "Url_Picture": Picture,
      "ชนิดครีบ": value1,
      "ชนิดหาง": value2,
      "ชนิดสี": value3,
      "ช่วงอายุ": value4,
      "เวลาที่ทำการวิเคราะห์": Date,
      "ชื่อปลากัด": NAME,
    };
  }
}
