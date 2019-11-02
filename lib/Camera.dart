import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plakad1/Home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';


void main(){
  runApp(new MaterialApp(
    title: "Camera App",
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}


class _LandingScreenState extends State<LandingScreen> {

  String _value1 = null;
  List<String> _values1 = new List<String>();
  String _value2 = null;
  List<String> _values2 = new List<String>();
  String _value3 = null;
  List<String> _values3 = new List<String>();
  String _value4 = null;
  List<String> _values4 = new List<String>();
  String _userId;


  String _text = '' ;

  File imageFile;

  String get filename => null;

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context){
    return AlertDialog(
      title: Text("Make & Choice!"),
      content: SingleChildScrollView(
        child: ListBody(
        children: <Widget>[
          GestureDetector(
            child:  Text("Gallary"),
            onTap: (){
              _openGallary(context);
            },
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          GestureDetector(
            child:  Text("Camera"),
            onTap: (){
              _openCamera(context);
            },
          )
        ],
      ),
      ),
    );
  });
}

  Future uploadPic(BuildContext context) async{
    String fileName=basename(imageFile.path);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var PicUrl = downUrl.toString();
//    FirebaseDatabase.instance.reference().child('UserHistory').
//    child('$_userId').child(_getDateNow()).set({
//      'ชนิดครีบ': '$_value1',
//      'ชนิดหาง': '$_value2',
//      'ชนิดสี' : '$_value3',
//      'ช่วงอายุ' : '$_value4',
//      'เวลาที่ทำการวิเคราะห์': _getDateNow(),
//      'ชื่อปลากัด': '$_text',
//      'Url_Picture': '$PicUrl',
//      'UID' : '$_userId'
//      },);
    FirebaseDatabase.instance.reference().child('SentToExpert').
    child(_getDateNow()).set({
      'Detail1': '$_value1',
      'Detail2': '$_value2',
      'Detail3' : '$_value3',
      'Age' : '$_value4',
      'Date': _getDateNow(),
      'Neme': '$_text',
      'Url_Picture': '$PicUrl',
      'UID' : '$_userId'
    },);
    return print('$PicUrl');
  }

  @override
  void initState(){
    _values1.addAll(["ระบุ","ครีบสั้นหางเดี่ยว","ครีบยาวหางเดี่ยว","ครีบสั้นหางคู่","ครีบยาวหางคู่"]);
    _value1 = _values1.elementAt(0);
    _values2.addAll(["ระบุ","หางพัด","หางใบโพธิ์","หางมงกุฎ","หางพระจันทร์ครึ่งดวง"]);
    _value2 = _values2.elementAt(0);
    _values3.addAll(["ระบุ","สีเดี่ยว","สองสี","ลายผีเสื้อ","ลายหินอ่อน","หลากสี"]);
    _value3 = _values3.elementAt(0);
    _values4.addAll(["ระบุ","5เเดือน ถึง 1ปี","1ปี ถึง 1ปี6เดือน","1ปี6เดือน ถึง 2ปี"]);
    _value4 = _values4.elementAt(0);

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
    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("เลือกรูปภาพ"),
      ),
      body: ListView(children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              imageFile == null
                  ? Image.asset('assets/Noimage.png',width: 400,height: 400,)
                  :Image.file(imageFile,width: 400,height: 400),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Text('ชนิดครีบ  :  ',style: TextStyle(fontSize: 15.0),),
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
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('ชนิดหาง  :  ',style: TextStyle(fontSize: 15.0),),
                      DropdownButton<String>(
                        items: _values2.map<DropdownMenuItem<String>>((String value2){
                          return DropdownMenuItem<String>(
                            value: value2,
                            child: Text(value2,style: TextStyle(color: Colors.black87),)
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('ชนิดสี  :  ',style: TextStyle(fontSize: 15.0),),
                      DropdownButton<String>(
                        items: _values3.map<DropdownMenuItem<String>>((String value3){
                          return DropdownMenuItem<String>(
                            value: value3,
                            child: new Row(
                              children: <Widget>[
                                new Text(value3,style: TextStyle(color: Colors.black87),)
                              ],
                            ),
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
                  ),



              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('ช่วงอายุ  :  ',style: TextStyle(fontSize: 15.0),),
                  DropdownButton<String>(
                    items: _values4.map<DropdownMenuItem<String>>((String value4){
                      return DropdownMenuItem<String>(
                        value: value4,
                        child: Text(value4,style: TextStyle(color: Colors.black87),)
                      );
                    }).toList(),
                    onChanged: (String newValuefour){
                      setState(() {
                        this._value4 = newValuefour;
                      });
                    },
                    value: _value4,
                  ),
                ],
              ),


              new TextField(
                onChanged:(String value){onChanged(value);},
                maxLines: 1,
                maxLength: 20,
                style: TextStyle(color: Colors.black87),
                decoration: new InputDecoration(
                    hintText: 'ใส่ชื่อปลากัดที่นี้ (ถ้ามี)',
                    labelText: 'ชื่อปลากัด',
                    border:  new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    )

                ),
              ),
              RaisedButton(
                color: Colors.black87,
                onPressed: (){
                  _showChoiceDialog(context);
                },child: Text("เพื่มรูปภาพ",style: TextStyle(color: Colors.white70),),),


              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  RaisedButton(
                    color: Colors.black87,
                    onPressed: (){
                      uploadPic(context);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HalSatu()
                      ));
                    },child: Text("ยืนยัน",style: TextStyle(color: Colors.white70),),),
                ],)
            ],
          ),
        ),
      ],

      ),
    );
  }
}

String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('HH:mm:ss dd-MM-yyyy');
  return formatter.format(now);
}