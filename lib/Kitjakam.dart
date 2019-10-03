import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(){
  runApp(new MaterialApp(
    title: "กิจกรรมที่จัดแข่ง",
    home: Kitjakam(),
  ));
}

class Kitjakam extends StatefulWidget {
  @override
  _HomeKitjakam createState() => _HomeKitjakam();
}

class _HomeKitjakam extends State<Kitjakam> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('กิจกรรมที่มีการจัดแข่ง'),
        flexibleSpace: _buildBar(context),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: FittedBox(
              child: Material(
                color: Colors.white,
                  elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Colors.grey,
                child: Row(
                 children: <Widget>[
                   Container(
                     child: myDetailsContainer(),
                   ),

                   Container(
                     width: 250,
                     height: 250,
                     child: ClipRRect(
                       borderRadius: new BorderRadius.circular(24.0),
                       child: Image.asset(
                         'assets/Noimage.png',
                         fit: BoxFit.scaleDown,
                         alignment: Alignment.topRight,
                       ),
                     ),),
                 ],),
            ),
          ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: FittedBox(
                child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: myDetailsContainer(),
                      ),

                      Container(
                        width: 250,
                        height: 250,
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(24.0),
                          child: Image(
                            fit: BoxFit.contain,
                            alignment: Alignment.topRight,
                            image: NetworkImage(
                                "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiv5v-OveniAhUWeysKHTzZAJ0QjRx6BAgBEAU&url=https%3A%2F%2Fprogameguides.com%2Fapex-legends%2Fapex-legends-caustic-guide%2F&psig=AOvVaw0-6oIyzPBqwPvkHJLG7BYK&ust=1560619001801920"),
                          ),
                        ),),
                    ],),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

Widget myDetailsContainer(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text('hdfghddfg')
    ],
  );
}

_buildBar(BuildContext context){
}