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
      home: HistoryAuto(),
    );
  }
}

class HistoryAuto extends StatefulWidget {
  @override
  Home_HistoryAuto createState() => Home_HistoryAuto();
}

class Home_HistoryAuto extends State<HistoryAuto> {
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;
  FirebaseUser currentUser;
  DatabaseReference watchRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item(
        "",
        "",
        "");
    _initDB();
  }

  void _initDB() async {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    currentUser = await firebaseAuth.currentUser();
    itemRef = watchRef = database.reference().
    child('HistoryAnalyAuto').
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
    if (itemRef == null){return Text('No Data............',style: TextStyle(fontSize: 40.0,color: Colors.white),);}else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('ประวัติการวิเคราะห์โดยระบบ'),
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
                              Image.network(items[index].Picture, width: 300.0,
                                height: 200.0,),
                              SizedBox(height: 10.0),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(items[index].Date),
//                              Text(items[index].point)
                            ],
                          )
                        ],
                      ),
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
}

class Item {
  String key;
  String Picture;
  String Date;
  String point;

  Item(this.Picture,this.Date,this.point);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Picture = snapshot.value["Url_Picture"],
        Date = snapshot.value["Date"],
        point = snapshot.value["label"];

  toJson() {
    return {
      "Url_Picture": Picture,
      "Date": Date,
      "label": point,
    };
  }
}