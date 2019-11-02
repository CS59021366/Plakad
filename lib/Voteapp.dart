import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plakad1/Home.dart';

void main() {
  runApp(new MaterialApp(
    title: "Camera App",
    home: Voteapp(),
  ));
}

class Voteapp extends StatefulWidget {
  static String routeName = '/Voteapp';


  @override
  _HomeViKror createState() => _HomeViKror();
}

class Item {
  String key;
  String _value1;
  String _value2;
  String _value3;


  Item(this._value1, this._value2, this._value3);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        _value1 = snapshot.value['ความง่ายในการใช้แอปพลิเคชัน'],
        _value2 = snapshot.value['ความง่ายในการใช้แอปพลิเคชัน'],
        _value3 = snapshot.value['ความพึงพอใจโดยรวม'];

  toJson() {  //ชื้อหัวข้อใน firestore
    return {
      "ความง่ายในการใช้แอปพลิเคชัน": _value1,
      "ความง่ายในการใช้แอปพลิเคชัน": _value2,
      "ความพึงพอใจโดยรวม": _value3,
    };
  }
}

class _HomeViKror extends State<Voteapp> {

  String _value1 = null;
  List<String> _values1 = new List<String>();
  String _value2 = null;
  List<String> _values2 = new List<String>();
  String _value3 = null;
  List<String> _values3 = new List<String>();


  @override
  void initState(){
    _values1.addAll(["0","1","2","3","4","5"]);
    _value1 = _values1.elementAt(0);
    _values2.addAll(["0","1","2","3","4","5"]);
    _value2 = _values2.elementAt(0);
    _values3.addAll(["0","1","2","3","4","5"]);
    _value3 = _values3.elementAt(0);

    item = Item(_value1, _value2, _value3);
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('items');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }
  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: new Text('ให้คะแนนแอปพลิเคชัน'),
        ),
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance.collection('quamroo').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Text('Loadaing Data.... Please Wait...');
                return Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('ความง่ายในการใช้งาน :  ',style: TextStyle(fontSize: 20.0),),
                            DropdownButton<String>(
                              items: _values1.map<DropdownMenuItem<String>>((String value1){
                                return DropdownMenuItem<String>(
                                  value: value1,
                                  child: Text(value1,style: TextStyle(color: Colors.black87),),
                                );
                              }).toList(),
                              onChanged: (String newValueone){
                                setState(() {
                                  this._value1 = newValueone;
                                });
                              },
                              value: _value1,
                            ),
                          ],
                        ),SizedBox(height: 30,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('ความรวดเร็วในการทำงาน  :  ',style: TextStyle(fontSize: 20.0),),
                            DropdownButton<String>(
                              items: _values2.map<DropdownMenuItem<String>>((String value2){
                                return DropdownMenuItem<String>(
                                  value: value2,
                                  child: Text(value2,style: TextStyle(color: Colors.black87),),
                                );
                              }).toList(),
                              onChanged: (String newValuetwo){
                                setState(() {
                                  this._value2 = newValuetwo;
                                });
                              },
                              value: _value2,
                            ),
                          ],
                        ),SizedBox(height: 30,),

                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: <Widget>[
                            Text('คะแนนความพึงพอใจโดยรวม  :  ',style: TextStyle(fontSize: 20.0),),
                            DropdownButton<String>(
                              items: _values3.map<DropdownMenuItem<String>>((String value3){
                                return DropdownMenuItem<String>(
                                  value: value3,
                                  child: Text(value3,style: TextStyle(color: Colors.black87),),
                                );
                              }).toList(),
                              onChanged: (String newValuethree){
                                setState(() {
                                  this._value3 = newValuethree;
                                });
                              },
                              value: _value3,
                            ),
                          ],
                        ),SizedBox(height: 30,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.green,
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HalSatu()
                                ));
                                FirebaseDatabase.instance.reference().
                                child("Assessment").child(_getDateNow()).
                                set({
                                  'Score1': '$_value1',
                                  'Score2': '$_value2',
                                  'Score3' : '$_value3',
                                },);
                              },child: Text("ตกลง",style: TextStyle(color: Colors.black87, fontSize: 30.0),),),


                            RaisedButton(
                              color: Colors.red,
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HalSatu()
                                ));
                              },child: Text("ยกเลิก",style: TextStyle(color: Colors.black87, fontSize: 30.0),),),
                          ],),

                      ],),
                  ],
                );
              },
            ),
          ],
        )
    );
  }
}
String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}