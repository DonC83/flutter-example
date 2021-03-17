import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:replanit_tensorflow_future/classify_result_screen.dart';
import 'package:replanit_tensorflow_future/intro_showcase.dart';
import 'package:replanit_tensorflow_future/service/Classifier.dart';
import 'package:replanit_tensorflow_future/service/analytics_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _libraryKey = GlobalKey();
  final GlobalKey _captureKey = GlobalKey();
  final GlobalKey _mapKey = GlobalKey();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> _authenticate() async {
    UserCredential userCredential = await auth.signInAnonymously();
    return userCredential;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('starting from the top');
    return FutureBuilder(
      future: _authenticate(),
      builder: (context, AsyncSnapshot<UserCredential> snapshot) {
        if (snapshot.hasData) {
          print('112121212121 ${snapshot.data.user}');
        }

        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          home: IntroShowcase(1, _libraryKey, _captureKey, _mapKey, MyHomePage(_homeKey, _libraryKey, _captureKey, _mapKey)),
          // home: MyHomePage(),
          navigatorObservers: [AnalyticsHelper.observer],
        );

        // return MaterialApp(
        //   title: 'Flutter Demo',
        //   theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
        //   ),
        //   home: MyHomePage(title: 'replanit test'),
        // );
      },
    );

  }
}

class MyHomePage extends StatefulWidget {
  final GlobalKey homeKey;
  final GlobalKey libraryKey;
  final GlobalKey captureKey;
  final GlobalKey mapKey;

  MyHomePage(this.homeKey, this.libraryKey, this.captureKey, this.mapKey);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final GlobalKey _homeKey = GlobalKey();
  // final GlobalKey _libraryKey = GlobalKey();
  // final GlobalKey _captureKey = GlobalKey();
  // final GlobalKey _mapKey = GlobalKey();

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
    // if (index == 2) {
    //   _cameraOn = true;
    // } else {
    //   _cameraOn = false;
    // }
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
              key: this.widget.homeKey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_library,
              key: this.widget.libraryKey,
            ),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo, key: this.widget.captureKey),
            label: 'Capture',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place, key: this.widget.mapKey),
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
  String _category;
  bool _cameraOn = false;


  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return Container(child: Text('Home'),);
      case 1:
        return Container(child: Text('Library'));
      case 2:
        if (_pickedFile == null && !_cameraOn) {
          _cameraOn = true;
          _getImagery(ImageSource.camera);
        } else if (_pickedFile != null) {
          _cameraOn = false;
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
            _cameraOn = false;
            return Container(child: Text('No image taken'));
          }

        break;
      case 3:
        return Container(child: Text('Map'),);
    }
  }
}
