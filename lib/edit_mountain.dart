import 'dart:async';

import 'package:flutter/material.dart';

import 'database.dart';

class EditMountianPage extends StatefulWidget {
  static String routeName = '/edit_mountain';

  final String mountainKey;

  EditMountianPage({Key key, this.mountainKey}) : super(key: key);

  @override
  _EditMountianPageState createState() => new _EditMountianPageState();
}

class _EditMountianPageState extends State<EditMountianPage> {
  final _nameFieldTextController = new TextEditingController();

  StreamSubscription _subscriptionName;

  @override
  void initState() {
    _nameFieldTextController.clear();

    Database.getNameStream(widget.mountainKey, _updateName)
        .then((StreamSubscription s) => _subscriptionName = s);

    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionName != null) {
      _subscriptionName.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Mountain"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: _nameFieldTextController,
              decoration: new InputDecoration(
                  icon: new Icon(Icons.edit),
                  labelText: "Mountain Name",
                  hintText: "Enter the mountain name..."
              ),
              onChanged: (String value) {
                Database.saveName(widget.mountainKey, value);
              },
            ),
          )
        ],
      ),
    );
  }

  void _updateName(String name) {
    _nameFieldTextController.value = _nameFieldTextController.value.copyWith(
      text: name,
    );
  }
}