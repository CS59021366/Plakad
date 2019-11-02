import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(
    title: "Camera App",
    home: Quamroo(),
  ));
}

class Quamroo extends StatefulWidget {
  @override
  _HomeQuamroo createState() => _HomeQuamroo();
}

class _HomeQuamroo extends State<Quamroo> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: new Text('ความรู้เกี่ยวกับปลากัด'),
      ),
      body: ListView(
        children: <Widget>[(
            StreamBuilder(
              stream: Firestore.instance.collection('quamroo').snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData) return Text('Loadaing Data.... Please Wait...');
                return Column(
                  children: <Widget>[
                    Text(snapshot.data.documents[0]['huareang'],style: new TextStyle(fontSize: 30.0),),
                    Text(snapshot.data.documents[0]['detail0'].toString()),
                    Text(snapshot.data.documents[0]['detail001'].toString(),style: TextStyle(fontSize: 25.0,color: Colors.red),),
                    Text(snapshot.data.documents[0]['detail01'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail011'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail02'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail021'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail03'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail031'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail04'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail041'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail05'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail051'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail06'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail061'].toString(),style: TextStyle(fontSize: 15.0)),
                    Image.network(snapshot.data.documents[0]['image01']),
                    Text(snapshot.data.documents[0]['detail0'].toString()),

                    Text(snapshot.data.documents[0]['detail002'].toString(),style: TextStyle(fontSize: 25.0,color: Colors.red),),
                    Text(snapshot.data.documents[0]['detail01'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail012'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail02'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail022'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail03'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail032'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail04'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail042'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail05'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail052'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail06'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail062'].toString(),style: TextStyle(fontSize: 15.0)),
                    Image.network(snapshot.data.documents[0]['image01']),
                    Text(snapshot.data.documents[0]['detail0'].toString()),

                    Text(snapshot.data.documents[0]['detail003'].toString(),style: TextStyle(fontSize: 25.0,color: Colors.red),),
                    Text(snapshot.data.documents[0]['detail01'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail013'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail02'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail023'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail03'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail033'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail04'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail043'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail05'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail053'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail06'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail063'].toString(),style: TextStyle(fontSize: 15.0)),
                    Image.network(snapshot.data.documents[0]['image01']),
                    Text(snapshot.data.documents[0]['detail0'].toString()),

                    Text(snapshot.data.documents[0]['detail004'].toString(),style: TextStyle(fontSize: 25.0,color: Colors.red),),
                    Text(snapshot.data.documents[0]['detail01'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail014'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail02'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail024'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail03'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail034'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail04'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail044'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail05'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail054'].toString(),style: TextStyle(fontSize: 15.0)),
                    Text(snapshot.data.documents[0]['detail06'].toString(),style: TextStyle(fontSize: 20.0,color: Colors.green)),
                    Text(snapshot.data.documents[0]['detail064'].toString(),style: TextStyle(fontSize: 15.0)),
                    Image.network(snapshot.data.documents[0]['image01'])
                  ],
                );
              },
            )
          ),Container(
            child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.uid);
              }
              else {
                return Text('Loading...');
              }
            },
          ),
        ),
        ],
      ),);
  }
}