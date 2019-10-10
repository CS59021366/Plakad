import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Database {

  static Future<String> createMountain() async {
    String accountKey = await _getAccountKey();

    var mountain = <String, dynamic>{
      'name' : '',
      'created': _getDateNow(),
    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("mountains")
        .push();

    reference.set(mountain);

    return reference.key;
  }

  static Future<void> saveName(String mountainKey, String name) async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("mountains")
        .child(mountainKey)
        .child('name')
        .set(name);
  }

  static Future<StreamSubscription<Event>> getNameStream(String mountainKey,
      void onData(String name)) async {
    String accountKey = await _getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("mountains")
        .child(mountainKey)
        .child("name")
        .onValue
        .listen((Event event) {
      String name = event.snapshot.value as String;
      if (name == null) {
        name = "";
      }
      onData(name);
    });

    return subscription;
  }

  static Future<Query> queryMountains() async {
    String accountKey = await _getAccountKey();

    return FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("mountains")
        .orderByChild("name");
  }
}

Future<String> _getAccountKey() async {
    FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return new Text(snapshot.data.email);
        }
        else {
          return new Text(snapshot.data.email);
        }
      },
    );

}

String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}