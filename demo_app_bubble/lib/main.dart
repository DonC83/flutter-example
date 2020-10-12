import 'package:bubble/bubble.dart';
import 'package:bubble_showcase/bubble_showcase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IntroBubbles(),
    );
  }
}


class IntroBubbles extends StatelessWidget {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _libraryKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _captureKey = GlobalKey();
  final GlobalKey _mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2.copyWith(
      color: Colors.white,
    );
    return BubbleShowcase(
      bubbleShowcaseId: 'my_bubble_showcase',
      bubbleShowcaseVersion: 1,
      bubbleSlides: [
        _zeroSlide(textStyle, size.width),
        _firstSlide(textStyle, size.width),
        _secondSlide(textStyle, size.width),
        _thirdSlide(textStyle, size.width)
      ],
      child: MyHomePage(_homeKey, _libraryKey, _galleryKey, _captureKey, _mapKey, 'Demo App', ),
    );
  }

  BubbleSlide _zeroSlide(TextStyle textStyle, double screenWidth) => RelativeBubbleSlide(
    shape: Oval(spreadRadius: 18),
    widgetKey: _libraryKey,
    child: AbsoluteBubbleSlideChild(
        positionCalculator: (size) => Position(
          top: size.height - 115,
          left: 0,
        ),
        widget:
        Bubble(
            nip: BubbleNip.no,
            color: Colors.transparent,
            child: Container(
                width: screenWidth - 30,
                child: Text(
                    'Use the Library to fine items that can\'t be identified or browse',
                    textAlign: TextAlign.center, style: textStyle)
            )
        )
    ),
  );

  BubbleSlide _firstSlide(TextStyle textStyle, double screenWidth) => RelativeBubbleSlide(
    shape: Oval(spreadRadius: 18),
    widgetKey: _galleryKey,
    child: AbsoluteBubbleSlideChild(
      positionCalculator: (size) => Position(
        top: size.height - 115,
        left: 0,
      ),
      widget:
        Bubble(
          nip: BubbleNip.no,
          color: Colors.transparent,
          child: Container(
            width: screenWidth - 30,
            child: Text(
                'Tap on Gallery to choose an image from your phone to try identify.',
                textAlign: TextAlign.center, style: textStyle)
          )
        )
    ),
  );

  BubbleSlide _secondSlide(TextStyle textStyle, double screenWidth) => RelativeBubbleSlide(
    shape: Oval(spreadRadius: 18),
    widgetKey: _captureKey,
    child: AbsoluteBubbleSlideChild(
        positionCalculator: (size) => Position(
          top: size.height - 115,
          left: 0,
        ),
        widget:
        Bubble(
            nip: BubbleNip.no,
            color: Colors.transparent,
            child: Container(
                width: screenWidth - 30,
                child: Text(
                    'Use Capture to take a photo of something to try identify',
                    textAlign: TextAlign.center, style: textStyle)
            )
        )
    ),
  );

  BubbleSlide _thirdSlide(TextStyle textStyle, double screenWidth) => RelativeBubbleSlide(
    shape: Oval(spreadRadius: 18),
    widgetKey: _mapKey,
    child: AbsoluteBubbleSlideChild(
        positionCalculator: (size) => Position(
          top: size.height - 115,
          left: 0,
        ),
        widget:
        Bubble(
            nip: BubbleNip.no,
            color: Colors.transparent,
            child: Container(
                width: screenWidth - 30,
                child: Text(
                    'Maps can be used to find a transfer station near you.',
                    textAlign: TextAlign.center, style: textStyle)
            )
        )
    ),
  );

}

class MyHomePage extends StatefulWidget {

  final GlobalKey homeKey;
  final GlobalKey libraryKey;
  final GlobalKey galleryKey;
  final GlobalKey captureKey;
  final GlobalKey mapKey;
  final String title;

  MyHomePage(this.homeKey, this.libraryKey, this.galleryKey, this.captureKey,
      this.mapKey, this.title);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma
      bottomNavigationBar: BottomNavigationBar(
        key: Key('bottom-nav'),
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.local_library, key: widget.libraryKey), title: Text('Library')),
          BottomNavigationBarItem(icon: Icon(Icons.add_photo_alternate, key: widget.galleryKey), title: Text('Gallery')),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt, key: widget.captureKey), title: Text('Capture')),
          BottomNavigationBarItem(icon: Icon(Icons.location_on, key: widget.mapKey), title: Text('Maps')),
        ],
      ),// makes auto-formatting nicer for build methods.
    );
  }
}
