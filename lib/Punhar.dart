import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plakad1/main.dart';
void main(){
  runApp(new MaterialApp(
    title: "Camera App",
    home: Punhar(),
  ));
}

class Punhar extends StatefulWidget {
  @override
  _HomePunhar createState() => _HomePunhar();
}


class _HomePunhar extends State<Punhar> {

  String _value0 = null;
  List<String> _values0 = new List<String>();

  String _text = '';

  @override

  void initState() {
    _values0.addAll(["ส่งวิเคราะห์ไม่ได้", "ผลวิเคราะห์ไม่พบในประวัติ",'อื่นๆ']);
    _value0 = _values0.elementAt(0);
  }
  void onpressed(){
    new Text('The text is : ${_text}');
  }
  void onChanged(String value){
    setState(() {
      _text = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายงานปัญหา"),
      ),
      body: ListView(
        children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('ชนิดปัญหาที่พบ  :  ',style: TextStyle(fontSize: 15.0),),
                  DropdownButton<String>(
                    items: _values0.map<DropdownMenuItem<String>>((String value1){
                      return DropdownMenuItem<String>(
                        value: value1,
                        child: Text(value1),
                      );
                    }).toList(),
                    onChanged: (String newValueone){
                      setState(() {
                        this._value0 = newValueone;
                      });
                    },
                    value: _value0,
                  ),
                ],
              ),

              new TextField(
                onChanged:(String value){onChanged(value);},
                maxLines: 20,
                decoration: new InputDecoration(
                    hintText: 'ใส่ปัญหาเพื่มเติมที่นี้',
                    labelText: 'รายละเอีนดปัญหา',
                    border:  new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    )
                ),
              ),
              RaisedButton(
                color: Colors.black87,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HalSatu()
                  ));
                },child: Text("ส่งรายงายปัญหา",style: TextStyle(color: Colors.white70),),)
            ],
          ),
        ),
      ],

    ),
    );
  }
}