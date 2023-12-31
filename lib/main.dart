import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}
const textStyle=TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 50.0,
  fontStyle: FontStyle.normal,
);

const textStyle1=TextStyle(
  fontSize: 35.0,
  color:Colors.yellow,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.italic,

);

const textStyle2=TextStyle(
  fontSize: 20.0,
  color:Colors.white,

);
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        textTheme: TextTheme(
          bodyText2: TextStyle(color:Color(0xFFFFECB3))
        ),

      appBarTheme:AppBarTheme(
        backgroundColor: Color(0xFF0A0E21),
      ),
    ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("FOCUS  n  FETCH"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 50.0, 6.0, 20.0),
          child: Container(

          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (textScanning) const CircularProgressIndicator(),
              if (!textScanning && imageFile == null)
                Container(
                  width: 650,
                  height: 300,
                  margin:EdgeInsets.only(left: 10.0,right:10.0),
                  color:Color(0xFF1D1E33),
                  child:Column(
                    children: [
                      Container(
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                           'SCAN',
                           style:textStyle,
                          ),
                        ),
                      ),
                      Container(
                        child:Padding(
                          padding:const EdgeInsets.all(10.0),
                          child:Text(
                            'your piece of paper',
                            style:textStyle1,
                          ),
                        ),
                      ),
                      Container(
                        child:Padding(
                          padding:const EdgeInsets.all(10.0),
                          child:Text(
                            'and get the',
                            style:textStyle1,
                          ),
                        ),
                      ),
                      Container(
                        child:Padding(
                          padding:const EdgeInsets.all(10.0),
                          child:Text(
                            'DIGITAL TEXT ',
                            style:textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),



              if (imageFile != null) Image.file(File(imageFile!.path)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.grey,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.image,
                                size: 30,
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.grey,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 30,
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFbfbfbf).withOpacity(0.1),
                ),
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                               primary: Color(0xFFbfbfbf).withOpacity(0.1),
                              onPrimary: Colors.grey,
                              // shadowColor: Colors.grey[400],
                              // elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              FlutterClipboard.copy(scannedText).then(
                                    (value) {
                                  return ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Text Copied'),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Copy',
                                    style:textStyle2,
                                  ),
                                  Icon(
                                    Icons.content_copy,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ),SizedBox(
                          width: 9.0,
                        ),
                        Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFbfbfbf).withOpacity(0.1),
                                onPrimary: Colors.grey,
                                // shadowColor: Colors.grey[400],
                                // elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                Share.share(scannedText);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Share',
                                      style:textStyle2,
                                    ),
                                    Icon(
                                      Icons.share,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Text(scannedText,
                        style: TextStyle(fontSize: 15.0),),
                      ),
                    )
                  ],

                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
	  scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }
}
