import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plakad1/Sign-In.dart';



class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF5DB7DE))),//AppBar
      backgroundColor: Colors.white,
      body:new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("SIGN UP", style: new TextStyle(fontSize: 60.0)),
                  new Form(
                    key: _formKey,
                    child: Theme(
                      data: new ThemeData(brightness: Brightness.light,
                          primarySwatch: Colors.lightBlue,
                          inputDecorationTheme: new InputDecorationTheme(
                              labelStyle: new TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please type an email';
                                }
                              },
                              onSaved: (input) => _email = input,
                              decoration: InputDecoration(
                                  labelText: 'Email'
                              ),
                            ),
                            TextFormField(
                              validator: (input) {
                                if (input.length > 6) {
                                  return 'Your password need to be atleast 6 characters';
                                }
                              },
                              onSaved: (input) => _password = input,
                              decoration: InputDecoration(
                                  labelText: 'Password'
                              ),
                              obscureText: true,
                            ),
                          ],//<Widget>[]
                        ),//Column
                      ),//Padding
                    ),//Theme
                  ),//Form
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 150.0, right: 150.0, top: 0.0),
                          child: Container(
                            child: RaisedButton(
                              onPressed: signUp,
                              color: Color(0xFF5DB7DE),
                              child: Text('Sign Up'),
                            ),//Container
                          ),//RaisedButton
                        ),//Padding
                      ),//Expanded
                    ],//<Widget>[]
                  ),//Row
                ],//<Widget>[]
              ),//Column
            ),//Container
          ),//Padding
        ],//<Widget>[]
      ),//ListView
    );
  }

  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageV2()));
      }catch(e){
        print(e.message);
      }
    }
  }
}
