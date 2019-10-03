import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'main.dart';

void main() => runApp(GroupedButtonExample());

class GroupedButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ประเมินการใช้งานแอปพลิเคชั่น',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> _checked = ["A", "B"];
  String _picked = "Two";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("ประเมินการใช้งานแอปพลิเคชั่น"),
      ),
      body: _body(),
    );
    //
  }

  Widget _body(){
    return ListView(
        children: <Widget>[

          //--------------------
          //SIMPLE USAGE EXAMPLE
          //--------------------

          //BASIC CHECKBOXGROUP
//          Container(
//            padding: const EdgeInsets.only(left: 14.0, top: 14.0),
//            child: Text("Basic CheckboxGroup",
//              style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 20.0
//              ),
//            ),
//          ),
//
//          CheckboxGroup(
//            labels: <String>[
//              "Sunday",
//              "Monday",
//              "Tuesday",
//              "Wednesday",
//              "Thursday",
//              "Friday",
//              "Saturday",
//            ],
//            disabled: [
//              "Wednesday",
//              "Friday"
//            ],
//            onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
//            onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
//          ),



          //BASIC RADIOBUTTONGROUP
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0),
            child: Text("ให้คะแนนความง่ายในการใช้แอปพลิเคชัน",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),

          RadioButtonGroup(
            orientation: GroupedButtonsOrientation.HORIZONTAL,
            labels: [
              "1",
              "2",
              "3",
              "4",
              "5"
            ],
            disabled: [
            ],
            onChange: (String label, int index) => print("label: $label index: $index"),
            onSelected: (String label) => print(label),
          ),




          //--------------------
          //CUSTOM USAGE EXAMPLE
          //--------------------

          ///CUSTOM CHECKBOX GROUP
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0, bottom: 14.0),
            child: Text("ความรวดเร็วในการตอบสนองของแอปพลิเคชัน",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),

          RadioButtonGroup(
            orientation: GroupedButtonsOrientation.HORIZONTAL,
            labels: [
              "1",
              "2",
              "3",
              "4",
              "5"
            ],
            disabled: [
            ],
            onChange: (String label, int index) => print("label: $label index: $index"),
            onSelected: (String label) => print(label),
          ),
//          CheckboxGroup(
//            orientation: GroupedButtonsOrientation.HORIZONTAL,
//            margin: const EdgeInsets.only(left: 12.0),
//            onSelected: (List selected) => setState((){
//              _checked = selected;
//            }),
//            labels: <String>[
//              "A",
//              "B",
//            ],
//            checked: _checked,
//            itemBuilder: (Checkbox cb, Text txt, int i){
//              return Column(
//                children: <Widget>[
//                  Icon(Icons.polymer),
//                  cb,
//                  txt,
//                ],
//              );
//            },
//          ),



          ///CUSTOM RADIOBUTTON GROUP
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0, bottom: 14.0),
            child: Text("ความพึงพอใจโดยรวมในการใช้แอปปพลิเคชัน",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
          ),
          Row(children: <Widget>[
            RadioButtonGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
              labels: [
                "1",
                "2",
                "3",
                "4",
                "5"
              ],
              disabled: [
              ],
              onChange: (String label, int index) => print("label: $label index: $index"),
              onSelected: (String label) => print(label),
            ),
          ],),

          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0, bottom: 14.0),
            child: Text("",
              style: TextStyle(
                  fontSize: 250.0
              ),
            ),
          ),

//          RadioButtonGroup(
//            orientation: GroupedButtonsOrientation.HORIZONTAL,
//            margin: const EdgeInsets.only(left: 12.0),
//            onSelected: (String selected) => setState((){
//              _picked = selected;
//            }),
//            labels: <String>[
//              "One",
//              "Two",
//            ],
//            picked: _picked,
//            itemBuilder: (Radio rb, Text txt, int i){
//              return Column(
//                children: <Widget>[
//                  Icon(Icons.public),
//                  rb,
//                  txt,
//                ],
//              );
//            },
//          ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
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
                },child: Text("ตกลง",style: TextStyle(color: Colors.black87, fontSize: 30.0),),),


            RaisedButton(
              color: Colors.red,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                builder: (context) => HalSatu()
                ));
                },child: Text("ยกเลิก",style: TextStyle(color: Colors.black87, fontSize: 30.0),),),
              ],)
            ],
          ),
        ]
    );
  }
}