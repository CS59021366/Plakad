import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'dart:ui' show Color;
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plakad1/SelectShape.dart';
import 'package:path/path.dart';
import 'package:plakad1/select_function.dart';

void main() => runApp(new analysisbody());

const String mobile = "หัวและตา";
const String ssd = "ลำตัวและเกล็ด";
const String yolo = "Tiny YOLOv2";
const String deeplab = "DeepLab";
const String posenet = "PoseNet";

class analysisbody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home_analysisbody(),
    );
  }
}

class home_analysisbody extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<home_analysisbody> {
  File _image;
  List _recognitions;
  String _model = mobile;
  double _imageHeight;
  double _imageWidth;
  bool _busy = false;
  String _userId;
  String get filename => null;

  getImageFile(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path,
      croppedFile.path,
      quality: 100,
    );
    if (image == null) return;
    setState(() {
      image = result;
      _busy = true;
    });
    predictImage(image);
  }

  Future predictImage(File image) async {
    if (image == null) return;
    switch (_model) {
      case mobile:
        await recognizeImage(image);
        break;
      case ssd:
        await recognizeImage(image);
        break;
    }

    new FileImage(image)
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageHeight = info.image.height.toDouble();
        _imageWidth = info.image.width.toDouble();
      });
    }));

    setState(() {
      _image = image;
      _busy = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String res;
      switch (_model) {
        case mobile:
          res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.lite",
            labels: "assets/mobilenet_v1_1.0_224.txt",
          );
          break;
        case ssd:
          res = await Tflite.loadModel(
              model: "assets/ssd_mobilenet.tflite",
              labels: "assets/ssd_mobilenet.txt");
      }
      print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Future recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.3,
      imageMean: 175.0,
      imageStd: 225.0,
    );
    setState(() {
      _recognitions = recognitions;
    });
  }

  Future recognizeImageBinary(File image) async {
    var imageBytes = (await rootBundle.load(image.path)).buffer;
    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    img.Image resizedImage = img.copyResize(oriImage, 224, 224);
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(resizedImage, 224, 127.5, 127.5),
      numResults: 6,
      threshold: 0.05,
    );
    setState(() {
      _recognitions = recognitions;
    });
  }
  onSelect(model) async {
    setState(() {
      _busy = true;
      _model = model;
      _recognitions = null;
    });
    await loadModel();

    if (_image != null)
      predictImage(_image);
    else
      setState(() {
        _busy = false;
      });
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageWidth * screen.width;
    Color blue = Color.fromRGBO(37, 213, 253, 1.0);
    return _recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: blue,
              width: 2,
            ),
          ),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> renderKeypoints(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageWidth * screen.width;

    var lists = <Widget>[];
    _recognitions.forEach((re) {
      var color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
      var list = re["keypoints"].values.map<Widget>((k) {
        return Positioned(
          left: k["x"] * factorX - 6,
          top: k["y"] * factorY - 6,
          width: 100,
          height: 12,
          child: Container(
            child: Text(
              "● ${k["part"]}",
              style: TextStyle(
                color: color,
                fontSize: 12.0,
              ),
            ),
          ),
        );
      }).toList();

      lists..addAll(list);
    });

    return lists;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;
    });
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

//    if (_model == deeplab && _recognitions != null) {
//      stackChildren.add(Positioned(
//        top: 0.0,
//        left: 0.0,
//        width: size.width,
//        child: _image == null
//            ? Text('ยังไม่มีรูปภาพที่จะวิเคราะห์',style: TextStyle(color: Colors.black,fontSize: 20.0))
//            : Container(
//            decoration: BoxDecoration(
//                image: DecorationImage(
//                    alignment: Alignment.topCenter,
//                    image: MemoryImage(_recognitions),
//                    fit: BoxFit.fill)),
//            child: Opacity(opacity: 0.3, child: Image.file(_image))),
//      ));
//    } else {
//      stackChildren.add(Positioned(
//        top: 100.0,
//        left: 0.0,
//        width: size.width,
//        child: _image == null
//            ? Text('ยังไม่มีรูปภาพที่จะวิเคราะห์',style: TextStyle(color: Colors.black,fontSize: 20.0))
//            : Image.file(_image,fit: BoxFit.fill,),height: 400,
//      ));
//    }

    if (_model == mobile) {
      stackChildren.add(Center(
        child: Column(
          children: _recognitions != null
              ? _recognitions.map((rest) {
            return Text(
              "${rest["label"]}: ${rest["confidence"].toStringAsFixed(3)}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                background: Paint()..color = Colors.white,
              ),
            );
          }).toList() : [],
        ),
      ));
    }
    else if (_model == ssd) {
      stackChildren.add(Center(
        child: Column(
          children: _recognitions != null
              ? _recognitions.map((rest) {
            return Text(
              "${rest["label"]}: ${rest["confidence"].toStringAsFixed(3)}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                background: Paint()..color = Colors.white,
              ),
            );
          }).toList() : [],
        ),
      ));
    }

    if (_busy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    Future uploadPic(BuildContext context) async{
      String fileName=basename(_image.path);
      final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      final StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

      var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      var PicUrl = downUrl.toString();
      FirebaseDatabase.instance.reference().child('HistoryAnalyAuto').
      child(_userId).child(_getDateNow()).set({
        'Date': _getDateNow(),
        'Url_Picture': '$PicUrl',
        'ScoreHead': _recognitions,
        'UID' : '$_userId'
      },);
      return print('$PicUrl');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(icon: Icon(Icons.subdirectory_arrow_left), onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SelectFunction()
          ));
        }),
        actions: <Widget>[
          IconButton(icon: Icon(
              Icons.save), onPressed: (){
            uploadPic(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => SelectFunction()
            ));
          }),
        ],
        title: const Text('วิเคราะห์ปลากัด'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('คะแนนที่ได้   :   ',style: TextStyle(fontSize: 20),),
                  Stack(
                    children: stackChildren,
                  ),
                ],
              ),SizedBox(height: 50),
            _image == null
                ? Image.asset('assets/Noimage.png',width: 400,height: 400,)
                :Image.file(_image,width: 400,height: 400),SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 20),
                Column(
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.black87,
                        onPressed: (){
                          onSelect(mobile);
                        },child: Text("วิเคราะห์หัว",style: TextStyle(color: Colors.white70),)
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.black87,
                        onPressed: (){
                          onSelect(ssd);
                        },child: Text("วิเคราะห์ตัว",style: TextStyle(color: Colors.white70),)
                    )
                  ],
                ),


              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImageFile(ImageSource.gallery),
        tooltip: 'Pick Image',
        child: Icon(Icons.image),
      ),
    );
  }
}

class Tflite {
  static const MethodChannel _channel = const MethodChannel('tflite');

  static Future<String> loadModel({
    @required String model,
    String labels = "",
    int numThreads = 1,
  }) async {
    return await _channel.invokeMethod(
      'loadModel',
      {"model": model, "labels": labels, "numThreads": numThreads},
    );
  }

  static Future<List> runModelOnImage(
      {@required String path,
        double imageMean = 117.0,
        double imageStd = 1.0,
        int numResults = 5,
        double threshold = 0.1,
        bool asynch = true}) async {
    return await _channel.invokeMethod(
      'runModelOnImage',
      {
        "path": path,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "numResults": numResults,
        "threshold": threshold,
        "asynch": asynch,
      },
    );
  }

  static Future<List> runModelOnBinary(
      {@required Uint8List binary,
        int numResults = 5,
        double threshold = 0.1,
        bool asynch = true}) async {
    return await _channel.invokeMethod(
      'runModelOnBinary',
      {
        "binary": binary,
        "numResults": numResults,
        "threshold": threshold,
        "asynch": asynch,
      },
    );
  }

  static Future<List> runModelOnFrame(
      {@required List<Uint8List> bytesList,
        int imageHeight = 1280,
        int imageWidth = 720,
        double imageMean = 127.5,
        double imageStd = 127.5,
        int rotation: 90, // Android only
        int numResults = 5,
        double threshold = 0.1,
        bool asynch = true}) async {
    return await _channel.invokeMethod(
      'runModelOnFrame',
      {
        "bytesList": bytesList,
        "imageHeight": imageHeight,
        "imageWidth": imageWidth,
        "imageMean": imageMean,
        "imageStd": imageStd,
        "rotation": rotation,
        "numResults": numResults,
        "threshold": threshold,
        "asynch": asynch,
      },
    );
  }

  static Future close() async {
    return await _channel.invokeMethod('close');
  }
}

String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('HH:mm:ss dd-MM-yyyy');
  return formatter.format(now);
}