import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:replanit_tensorflow_future/classify_result_screen.dart';
import 'package:replanit_tensorflow_future/service/Classifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> _authenticate() async {
    UserCredential userCredential = await auth.signInAnonymously();
    return userCredential;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authenticate(),
      builder: (context, AsyncSnapshot<UserCredential> snapshot) {
        if (snapshot.hasData) {
          print('112121212121 ${snapshot.data.user}');
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'replanit test'),
        );
      },
    );

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _libraryKey = GlobalKey();
  final GlobalKey _captureKey = GlobalKey();
  final GlobalKey _mapKey = GlobalKey();

  PickedFile _pickedFile;
  Exception _pickedFileError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("title"),
      ),
      // drawer: DrawerMenu(),
      body: _getBody(),
      bottomNavigationBar: _getBottomNavBar(),
    );
  }


  int _currentIndex = 0;
  void _selectTabBody(int index) {
    _pickedFile = null;
    _pickedFileError = null;
    _category = null;
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getBottomNavBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        onTap: _selectTabBody,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              key: _homeKey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_library,
              key: _libraryKey,
            ),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo, key: _captureKey),
            label: 'Capture',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place, key: _mapKey),
            label: 'Map',
          ),
        ]);
  }

  final _picker = ImagePicker();

  Future<void> _getImagery(ImageSource imageSource) async {
    try {
      final pickedFile = await _picker.getImage(
          source: imageSource
      );
      setState(() {
        _pickedFile = pickedFile;
      });
    } catch(error) {
      setState(() {
        _pickedFileError = error;
      });

    }
  }

  Classifier _classifier = Classifier();
  List<dynamic> _disposables;
  String _category;

  void _classify() async {
    _classifier.recognizeImage(_pickedFile.path)
    .then((value) {
      setState(() {
        _pickedFile = null;
        _category = value[0]['label'];
      });
    });
  }


  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return Container(child: Text('Home'),);
      case 1:
        return Container(child: Text('Library'));
      case 2:
        if (_pickedFile == null) {
          _getImagery(ImageSource.camera);
        } else if (_pickedFile != null) {
            return FutureBuilder(
              future: _classifier.recognizeImage(_pickedFile.path),
              builder: (context, AsyncSnapshot<List<dynamic>>snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(child: Text('Analysing...'));
                } else if (snapshot.hasData) {
                  if (snapshot.data.isEmpty) {
                    return Container(child: Text('Cannot classify'));
                  } else {
                    _category = snapshot.data[0]['label'];
                    return ClassifyResultScreen(_category);
                  }
                } else {
                  return Container(child: Text('No results found'));
                }
              },
            );
          } else {
            return Container(child: Text('No image taken'));
          }

        // if (_pickedFile == null && _category == null && _pickedFileError == null) {
        //   _getImagery(ImageSource.camera);
        // } else if (_pickedFile != null){
        //   _classify();
        // } else if (_category != null) {
        //   // return Container(child: Text(_category),);
        //   return ClassifyResultScreen(_category);
        // } else if (_pickedFileError != null) {
        //   return Container(child: Text(_pickedFileError.toString()),);
        // }
        break;
      case 3:
        return Container(child: Text('Map'),);
    }
  }
}
