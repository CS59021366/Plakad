import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'dart:ui' show Color;
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';

import 'SelectShape.dart';

void main() => runApp(new analysisbody());

//const String mobile = "หัวและตา";
const String ssd = "ลำตัวและเกร็ด";
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
  String _model = ssd;
  double _imageHeight;
  double _imageWidth;
  bool _busy = false;

  getImageFile(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    //Cropping the image

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    //Compress the image

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

//    switch (_model) {
//      case yolo:
//        await yolov2Tiny(image);
//        break;
//      case ssd:
//        await recognizeImage(image);
//        break;
//      case deeplab:
//        await segmentMobileNet(image);
//        break;
//      case posenet:
//        await poseNet(image);
//        break;
//      default:
    await recognizeImage(image);
    // await recognizeImageBinary(image);
//    }

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
//      switch (_model) {
//        case yolo:
//          res = await Tflite.loadModel(
//            model: "assets/yolov2_tiny.tflite",
//            labels: "assets/yolov2_tiny.txt",
//          );
//          break;
//        case ssd:
//          res = await Tflite.loadModel(
//              model: "assets/ssd_mobilenet.tflite",
//              labels: "assets/ssd_mobilenet.txt"
//          );
//          break;
//        case deeplab:
//          res = await Tflite.loadModel(
//              model: "assets/deeplabv3_257_mv_gpu.tflite",
//              labels: "assets/deeplabv3_257_mv_gpu.txt");
//          break;
//        case posenet:
//          res = await Tflite.loadModel(
//              model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
//          break;
//        default:
      res = await Tflite.loadModel(
          model: "assets/ssd_mobilenet.tflite",
          labels: "assets/ssd_mobilenet.txt"
      );
//      }
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

//  Future yolov2Tiny(File image) async {
//    var recognitions = await Tflite.detectObjectOnImage(
//      path: image.path,
//      model: "YOLO",
//      threshold: 0.3,
//      imageMean: 0.0,
//      imageStd: 255.0,
//      numResultsPerClass: 1,
//    );
  // var imageBytes = (await rootBundle.load(image.path)).buffer;
  // img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
  // img.Image resizedImage = img.copyResize(oriImage, 416, 416);
  // var recognitions = await Tflite.detectObjectOnBinary(
  //   binary: imageToByteListFloat32(resizedImage, 416, 0.0, 255.0),
  //   model: "YOLO",
  //   threshold: 0.3,
  //   numResultsPerClass: 1,
  // );
//    setState(() {
//      _recognitions = recognitions;
//    });
//  }

//  Future ssdMobileNet(File image) async {
//    var recognitions = await Tflite.detectObjectOnImage(
//      path: image.path,
//      numResultsPerClass: 1,
//    );
  // var imageBytes = (await rootBundle.load(image.path)).buffer;
  // img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
  // img.Image resizedImage = img.copyResize(oriImage, 300, 300);
  // var recognitions = await Tflite.detectObjectOnBinary(
  //   binary: imageToByteListUint8(resizedImage, 300),
  //   numResultsPerClass: 1,
  // );
//    setState(() {
//      _recognitions = recognitions;
//    });
//  }

//  Future segmentMobileNet(File image) async {
//    var recognitions = await Tflite.runSegmentationOnImage(
//      path: image.path,
//      imageMean: 127.5,
//      imageStd: 127.5,
//    );
//
//    setState(() {
//      _recognitions = recognitions;
//    });
//  }

//  Future poseNet(File image) async {
//    var recognitions = await Tflite.runPoseNetOnImage(
//      path: image.path,
//      numResults: 2,
//    );
//
//    print(recognitions);
//
//    setState(() {
//      _recognitions = recognitions;
//    });
//  }

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
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    if (_model == deeplab && _recognitions != null) {
      stackChildren.add(Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        child: _image == null
            ? Text('ยังไม่มีรูปภาพที่จะวิเคราะห์',style: TextStyle(color: Colors.black,fontSize: 20.0))
            : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: MemoryImage(_recognitions),
                    fit: BoxFit.fill)),
            child: Opacity(opacity: 0.3, child: Image.file(_image))),
      ));
    } else {
      stackChildren.add(Positioned(
        top: 100.0,
        left: 0.0,
        width: size.width,
        child: _image == null
            ? Text('ยังไม่มีรูปภาพที่จะวิเคราะห์',style: TextStyle(color: Colors.black,fontSize: 20.0))
            : Image.file(_image,fit: BoxFit.fill,),height: 400,
      ));
    }

    if (_model == ssd) {
      stackChildren.add(Center(
        child: Column(
          children: _recognitions != null
              ? _recognitions.map((rest) {
            return Text(
              "${rest["index"]} - ${rest["label"]}: ${rest["confidence"].toStringAsFixed(3)}",
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
//    else if (_model == ssd) {
//      stackChildren.add(Center(
//        child: Column(
//          children: _recognitions != null
//              ? _recognitions.map((res) {
//            return Text(
//              "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",
//              style: TextStyle(
//                color: Colors.black,
//                fontSize: 20.0,
//                background: Paint()..color = Colors.white,
//              ),
//            );
//          }).toList()
//              : [],
//        ),
//      ));
//    }
//    else if (_model == posenet) {
//      stackChildren.addAll(renderKeypoints(size));
//    }

    if (_busy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: IconButton(icon: Icon(Icons.subdirectory_arrow_left), onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SelectShape()
          ));
        }),
        title: const Text('วิเคราะห์ส่วนลำตัว'),
      ),
      body: Stack(
        children: stackChildren,
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

//  static const anchors = [
//    0.57273,
//    0.677385,
//    1.87446,
//    2.06253,
//    3.33843,
//    5.47434,
//    7.88282,
//    3.52778,
//    9.77052,
//    9.16828
//  ];

//  static Future<List> detectObjectOnImage({
//    @required String path,
//    String model = "SSDMobileNet",
//    double imageMean = 127.5,
//    double imageStd = 127.5,
//    double threshold = 0.1,
//    int numResultsPerClass = 5,
//    // Used in YOLO only
//    List anchors = anchors,
//    int blockSize = 32,
//    int numBoxesPerBlock = 5,
//    bool asynch = true,
//  }) async {
//    return await _channel.invokeMethod(
//      'detectObjectOnImage',
//      {
//        "path": path,
//        "model": model,
//        "imageMean": imageMean,
//        "imageStd": imageStd,
//        "threshold": threshold,
//        "numResultsPerClass": numResultsPerClass,
//        "anchors": anchors,
//        "blockSize": blockSize,
//        "numBoxesPerBlock": numBoxesPerBlock,
//        "asynch": asynch,
//      },
//    );
//  }
//
//  static Future<List> detectObjectOnBinary({
//    @required Uint8List binary,
//    String model = "SSDMobileNet",
//    double threshold = 0.1,
//    int numResultsPerClass = 5,
//    // Used in YOLO only
//    List anchors = anchors,
//    int blockSize = 32,
//    int numBoxesPerBlock = 5,
//    bool asynch = true,
//  }) async {
//    return await _channel.invokeMethod(
//      'detectObjectOnBinary',
//      {
//        "binary": binary,
//        "model": model,
//        "threshold": threshold,
//        "numResultsPerClass": numResultsPerClass,
//        "anchors": anchors,
//        "blockSize": blockSize,
//        "numBoxesPerBlock": numBoxesPerBlock,
//        "asynch": asynch,
//      },
//    );
//  }
//
//  static Future<List> detectObjectOnFrame({
//    @required List<Uint8List> bytesList,
//    String model = "SSDMobileNet",
//    int imageHeight = 1280,
//    int imageWidth = 720,
//    double imageMean = 127.5,
//    double imageStd = 127.5,
//    double threshold = 0.1,
//    int numResultsPerClass = 5,
//    int rotation: 90, // Android only
//    // Used in YOLO only
//    List anchors = anchors,
//    int blockSize = 32,
//    int numBoxesPerBlock = 5,
//    bool asynch = true,
//  }) async {
//    return await _channel.invokeMethod(
//      'detectObjectOnFrame',
//      {
//        "bytesList": bytesList,
//        "model": model,
//        "imageHeight": imageHeight,
//        "imageWidth": imageWidth,
//        "imageMean": imageMean,
//        "imageStd": imageStd,
//        "rotation": rotation,
//        "threshold": threshold,
//        "numResultsPerClass": numResultsPerClass,
//        "anchors": anchors,
//        "blockSize": blockSize,
//        "numBoxesPerBlock": numBoxesPerBlock,
//        "asynch": asynch,
//      },
//    );
//  }

  static Future close() async {
    return await _channel.invokeMethod('close');
  }

//  static Future<Uint8List> runPix2PixOnImage(
//      {@required String path,
//        double imageMean = 0,
//        double imageStd = 255.0,
//        String outputType = "png",
//        bool asynch = true}) async {
//    return await _channel.invokeMethod(
//      'runPix2PixOnImage',
//      {
//        "path": path,
//        "imageMean": imageMean,
//        "imageStd": imageStd,
//        "asynch": asynch,
//        "outputType": outputType,
//      },
//    );
//  }

//  static Future<Uint8List> runPix2PixOnBinary(
//      {@required Uint8List binary,
//        String outputType = "png",
//        bool asynch = true}) async {
//    return await _channel.invokeMethod(
//      'runPix2PixOnBinary',
//      {
//        "binary": binary,
//        "asynch": asynch,
//        "outputType": outputType,
//      },
//    );
//  }

//  static Future<Uint8List> runPix2PixOnFrame({
//    @required List<Uint8List> bytesList,
//    int imageHeight = 1280,
//    int imageWidth = 720,
//    double imageMean = 0,
//    double imageStd = 255.0,
//    int rotation: 90, // Android only
//    String outputType = "png",
//    bool asynch = true,
//  }) async {
//    return await _channel.invokeMethod(
//      'runPix2PixOnFrame',
//      {
//        "bytesList": bytesList,
//        "imageHeight": imageHeight,
//        "imageWidth": imageWidth,
//        "imageMean": imageMean,
//        "imageStd": imageStd,
//        "rotation": rotation,
//        "asynch": asynch,
//        "outputType": outputType,
//      },
//    );
//  }

// https://github.com/meetshah1995/pytorch-semseg/blob/master/ptsemseg/loader/pascal_voc_loader.py
//  static List<int> pascalVOCLabelColors = [
//    Color.fromARGB(255, 0, 0, 0).value, // background
//    Color.fromARGB(255, 128, 0, 0).value, // aeroplane
//    Color.fromARGB(255, 0, 128, 0).value, // biyclce
//    Color.fromARGB(255, 128, 128, 0).value, // bird
//    Color.fromARGB(255, 0, 0, 128).value, // boat
//    Color.fromARGB(255, 128, 0, 128).value, // bottle
//    Color.fromARGB(255, 0, 128, 128).value, // bus
//    Color.fromARGB(255, 128, 128, 128).value, // car
//    Color.fromARGB(255, 64, 0, 0).value, // cat
//    Color.fromARGB(255, 192, 0, 0).value, // chair
//    Color.fromARGB(255, 64, 128, 0).value, // cow
//    Color.fromARGB(255, 192, 128, 0).value, // diningtable
//    Color.fromARGB(255, 64, 0, 128).value, // dog
//    Color.fromARGB(255, 192, 0, 128).value, // horse
//    Color.fromARGB(255, 64, 128, 128).value, // motorbike
//    Color.fromARGB(255, 192, 128, 128).value, // person
//    Color.fromARGB(255, 0, 64, 0).value, // potted plant
//    Color.fromARGB(255, 128, 64, 0).value, // sheep
//    Color.fromARGB(255, 0, 192, 0).value, // sofa
//    Color.fromARGB(255, 128, 192, 0).value, // train
//    Color.fromARGB(255, 0, 64, 128).value, // tv-monitor
//  ];

//  static Future<Uint8List> runSegmentationOnImage(
//      {@required String path,
//        double imageMean = 0,
//        double imageStd = 255.0,
//        List<int> labelColors,
//        String outputType = "png",
//        bool asynch = true}) async {
//    return await _channel.invokeMethod(
//      'runSegmentationOnImage',
//      {
//        "path": path,
//        "imageMean": imageMean,
//        "imageStd": imageStd,
//        "labelColors": labelColors ?? pascalVOCLabelColors,
//        "outputType": outputType,
//        "asynch": asynch,
//      },
//    );
//  }
//
//  static Future<Uint8List> runSegmentationOnBinary(
//      {@required Uint8List binary,
//        List<int> labelColors,
//        String outputType = "png",
//        bool asynch = true}) async {
//    return await _channel.invokeMethod(
//      'runSegmentationOnBinary',
//      {
//        "binary": binary,
//        "labelColors": labelColors ?? pascalVOCLabelColors,
//        "outputType": outputType,
//        "asynch": asynch,
//      },
//    );
//  }
//
//  static Future<Uint8List> runSegmentationOnFrame(
//      {@required List<Uint8List> bytesList,
//        int imageHeight = 1280,
//        int imageWidth = 720,
//        double imageMean = 0,
//        double imageStd = 255.0,
//        int rotation: 90, // Android only
//        List<int> labelColors,
//        String outputType = "png",
//        bool asynch = true}) async {
//    return await _channel.invokeMethod(
//      'runSegmentationOnFrame',
//      {
//        "bytesList": bytesList,
//        "imageHeight": imageHeight,
//        "imageWidth": imageWidth,
//        "imageMean": imageMean,
//        "imageStd": imageStd,
//        "rotation": rotation,
//        "labelColors": labelColors ?? pascalVOCLabelColors,
//        "outputType": outputType,
//        "asynch": asynch,
//      },
//    );
//  }

//  static Future<List> runPoseNetOnImage(
//      {@required String path,
//        double imageMean = 127.5,
//        double imageStd = 127.5,
//        int numResults = 5,
//        double threshold = 0.5,
//        int nmsRadius = 20,
//        bool asynch = true}) async {
//    return await _channel.invokeMethod(
//      'runPoseNetOnImage',
//      {
//        "path": path,
//        "imageMean": imageMean,
//        "imageStd": imageStd,
//        "numResults": numResults,
//        "threshold": threshold,
//        "nmsRadius": nmsRadius,
//        "asynch": asynch,
//      },
//    );
//  }

//  static Future<List> runPoseNetOnBinary(
//      {@required Uint8List binary,
//        int numResults = 5,
//        double threshold = 0.5,
//        int nmsRadius = 20,
//        bool asynch = true}) async {
//    return await _channel.invokeMethod(
//      'runPoseNetOnBinary',
//      {
//        "binary": binary,
//        "numResults": numResults,
//        "threshold": threshold,
//        "nmsRadius": nmsRadius,
//        "asynch": asynch,
//      },
//    );
//  }

//  static Future<List> runPoseNetOnFrame(
//      {@required List<Uint8List> bytesList,
//        int imageHeight = 1280,
//        int imageWidth = 720,
//        double imageMean = 127.5,
//        double imageStd = 127.5,
//        int rotation: 90, // Android only
//        int numResults = 5,
//        double threshold = 0.5,
//        int nmsRadius = 20,
//        bool asynch = true}) async {
//    return await _channel.invokeMethod(
//      'runPoseNetOnFrame',
//      {
//        "bytesList": bytesList,
//        "imageHeight": imageHeight,
//        "imageWidth": imageWidth,
//        "imageMean": imageMean,
//        "imageStd": imageStd,
//        "rotation": rotation,
//        "numResults": numResults,
//        "threshold": threshold,
//        "nmsRadius": nmsRadius,
//        "asynch": asynch,
//      },
//    );
//  }
}