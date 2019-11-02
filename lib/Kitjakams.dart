import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plakad1/Home.dart';

import 'Map.dart';

class FirestoreCRUDPage extends StatefulWidget {
  @override
  FirestoreCRUDPageState createState() {
    return FirestoreCRUDPageState();
  }
}

class FirestoreCRUDPageState extends State<FirestoreCRUDPage> {
  String id;
  final db = Firestore.instance;

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network('${doc.data['imageUrl']}',width: 300.0,height: 300.0,),
            Text(
              'ชื่อกิจกรรม: ${doc.data['Name']}',
              style: TextStyle(fontSize: 25),
            ),
            Text(
              'เวลาเริ่มต้น/สิ้นสุด: ${doc.data['Date']}',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'รายละเอียด: ${doc.data['Description']}',
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 12),
            RaisedButton(
              color: Colors.black87,
              onPressed: (){
//                uploadPic(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LocationPage()
                ));
              },child: Text("นำทางไปที่จัดแข่ง",style: TextStyle(color: Colors.white70),),),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(icon: Icon(Icons.subdirectory_arrow_left), onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HalSatu()
          ));
        }),
        title: Text('กิจกรรมแข่งขันปลากัด'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: db.collection('Events').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                id != null ? readData : null;
                return Column(children: snapshot.data.documents.map((doc) =>
                    buildItem(doc)).toList());
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }


  void readData() async {
    DocumentSnapshot snapshot = await db.collection('CRUD').document(id).get();
    print(snapshot.data);
  }
}
