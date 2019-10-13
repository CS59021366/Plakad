import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plakad1/Home.dart';
import 'package:plakad1/Sign-Up.dart';

class LoginPageV2 extends StatefulWidget {
@override
_LoginPageV2State createState() => _LoginPageV2State();
}

class _LoginPageV2State extends State<LoginPageV2> {
  get assetsImage => null;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.asset('assets/Logo.png',width: 300.0,height: 300.0,fit: BoxFit.cover,),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Container(
                      alignment: Alignment.center,
                      height: 37.0,
                      decoration: new BoxDecoration(
                          color: Colors.lightGreenAccent,borderRadius: new BorderRadius.circular(30.0)
                      ),
                      child: new Text("Sign In Account",style: new TextStyle(fontSize: 25.0,color: Colors.black),),
                    ),//Container
                  ),//Padding
                ),//Expanded
              ],//<Widget>
            ),//Row
            new Form(
              key: _formKey,
              child: Theme(
                data: new ThemeData(brightness: Brightness.light,
                    primarySwatch: Colors.brown,
                    inputDecorationTheme: new InputDecorationTheme(
                        labelStyle: new TextStyle(
                            color: Colors.brown,
                            fontSize: 20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please type an Email';
                          }
                        },
                        onSaved: (input) => _email = input,
                        decoration: InputDecoration(
                            labelText: 'Email'
                        ),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please type Password';
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
                        onPressed: signIn,
                        color: Colors.lime,
                        child: Text('Sign in',style: TextStyle(fontSize: 40),),
                      ),//Container
                    ),//RaisedButton
                  ),//Padding
                ),//Expanded
              ],//<Widget>[]
            ),//Row
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SignUp()));
                      },//onTap
                      child: new Text("Create A New Account",style: new TextStyle(
                          fontSize: 20.0, color: Colors.red)),
                    ),//GestureDetector
                  ),//Padding
                ],//<Widget>[]
              ),//Column
            )
          ],//<Widget>[]
        ),//Column
      ),//Container
    );
  }

  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HalSatu()));
      }catch(e){
        print(e.message);
      }
    }
  }
}