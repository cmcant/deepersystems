import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class ImageItem {
  String id;
  String url;
  String pic;

  ImageItem(
    {
    this.id,
    this.url,
    this.pic
    }
  );
  
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeeperSystems - Client',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'DeeperSystems - Client'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

@override
    void initState() {
      _listImages();
      super.initState();
      setupCameras();
    }
  
    @override
    void dispose() {
      super.dispose();
    }

Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }

IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

List dados ;

List<ImageItem> listimg = List<ImageItem>();


List<CameraDescription> cameras;
CameraController controller;
bool isReady = false;
bool showCamera = true;
String imagePath;

var refreshkey = GlobalKey<RefreshIndicatorState>();

  Future<Null> _listImages() async {
    refreshkey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds:2)) ;

    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = "http://201.76.149.210:8002/pictures/";
    //var url = "http://10.0.0.103:8000/pictures/";
  
    // Await the http get response, then decode the json-formatted responce.
  
    Map<String,String> headers = new Map<String,String>();
    headers['Content-type'] = 'application/json';
    headers['Aceept'] = 'application/json';
  
    var response = await http.get(url,headers:headers);
  
    if (response.statusCode == 200) {
  
      setState(() {
        dados =  json.decode( response.body );
      });
  
      setState(() {
        listimg.clear();
      });

      for( var i  in dados ){
          var a = new ImageItem();
          a.id = i['id'];
          a.url = i['url'];
          a.pic = i['pic'];
          listimg.add(a);
      }
  
      setState(() {
        listimg.toList();
      });
      
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  return null ;
  }  
  
  Future<void> _deleteImages(id) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = "http://localhost:8000/pictures/" + id + '/';
  http://201.76.149.210:8002/pictures/
    // Await the http get response, then decode the json-formatted responce.
  
    Map<String,String> headers = new Map<String,String>();
    headers['Content-type'] = 'application/json';
    headers['Aceept'] = 'application/json';
  
    var response = await http.delete(url,headers:headers);
  
    if (response.statusCode == 200) {
    _listImages();
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  
  }  
  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          showCamera = false;
          imagePath = filePath;
        });
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    
        if (controller.value.isTakingPicture) {
          return null;
        }
    
        try {
          await controller.takePicture(filePath);
        } on CameraException catch (e) {
          return null;
        }
        return filePath;
      }
      
      void _captureImages() {
    
        if(controller != null && controller.value.isInitialized){
          onTakePictureButtonPressed();
        }
    
      }
    
      
      Widget _buildImageItem(BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                Image.network(listimg[index].pic),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                new SizedBox(
                    width: 110,
                    height: 30,
                    child: new RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)
                    ),
                    onPressed: () => {
                    } ,
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        new Icon(Icons.cloud_download),
                        new Text(" Download",style: TextStyle(fontSize: 9),)
                      ]
                    ),
                  ),
                ),        
                new SizedBox(
                    width: 110,
                    height: 30,
                    child: new RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)
                    ),
                    onPressed: () => {
                      print(listimg[index].id ),
                      //_deleteImages( listimg[index].id )
                    } ,
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        new Icon(Icons.delete),
                        new Text(" Delete",style: TextStyle(fontSize: 9),)
                      ]
                    ),
                  ),
                ),       
                  ] 
                )
                ],
            ),
          );
        }
      
        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: RefreshIndicator(
              key: refreshkey,
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: listimg.toList()?.length,
            itemBuilder: _buildImageItem,
      
            ), onRefresh: () {
              _listImages();
            },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _captureImages,
              tooltip: 'Images',
              child: Icon(Icons.camera),
            ),
          );
        }
    
      timestamp() {}
  }
  
  class VideoPlayerController {
}
