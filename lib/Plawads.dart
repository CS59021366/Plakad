import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(
    title: "Camera App",
    home: plawads(),
  ));
}

class plawads extends StatefulWidget {
  @override
  _plawads createState() => _plawads();
}


class _plawads extends State<plawads> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String _userId;
  
  @override
  void initState(){
    super.initState();
    readData();
  }
  void readData() async{
    DatabaseReference databaseReference = firebaseDatabase.reference().
    child('ปลากัดที่ส่งให้ผู้เชี่ยวชาญวิเคราะห์').child('$_userId').child('');
    await databaseReference.once().then((DataSnapshot datasnapshop){
      Map<dynamic, dynamic> values = datasnapshop.value;
      values.forEach((key, values){
        print(values['ชนิดสี']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;

      readData();
    });
  }
  
}

