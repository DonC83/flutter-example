import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> pages = {
      'My Music': Center(
        child: Text('My Music not implemented'),
      ),
      'Shared': Center(
        child: Text('Shared not implemented'),
      ),
      'Feed': Feed()
    };
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                const Color.fromARGB(255, 253, 72, 72),
                const Color.fromARGB(255, 87, 97, 249)
              ],
              stops: [0, 1]
            )
          ),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Demo',
                style: textTheme.headline5.copyWith(
                  color: Colors.grey.shade800.withOpacity(0.8),
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: const Color(0x00000000),
          appBar: new AppBar(
            backgroundColor: const Color(0x00000000),
            elevation: 0.0,
            leading: new Center(
              child: new ClipOval( //top left profile icon
                child: new Image.network(
                  'http://i.imgur.com/TtNPTe0.jpg',
                ),
              ),
            ),
            actions: [
              new IconButton(
                icon: new Icon(Icons.add),
                onPressed: () {
                  print('pressing right plus sign');
                },
              ),
            ],
            title: const Text('tofu\'s songs'),
            bottom: new CustomTabBar(
              pageController: _pageController,
              pageNames: pages.keys.toList(),
            ),
          ),
          body: new PageView(
            controller: _pageController,
            children: pages.values.toList(),
          ),
        )
      ],
    );
  }

}

class CustomTabBar extends AnimatedWidget implements PreferredSizeWidget {
  final PageController pageController;
  final List<String> pageNames;

  CustomTabBar({this.pageController, this.pageNames}) : super(listenable: pageController);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: 40,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade800.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(pageNames.length, (index) {
          return InkWell(
            child: Text(
                pageNames[index],
                style: textTheme.subtitle1.copyWith(color: Colors.white.withOpacity(index == pageController.page ? 1.0 : 0.2)),
            ),
            onTap: () {
              pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut);
            },
          );
        })
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 40);

}

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        new Song(title: 'Trapadelic lobo', author: 'lillobobeats', likes: 4),
        new Song(title: 'Different', author: 'younglowkey', likes: 23),
        new Song(title: 'Future', author: 'younglowkey', likes: 2),
        new Song(title: 'ASAP', author: 'tha_producer808', likes: 13),
        new Song(title: '🌲🌲🌲', author: 'TraphousePeyton'),
        new Song(title: 'Something sweet...', author: '6ryan'),
        new Song(title: 'Sharpie', author: 'Fergie_6'),
      ],
    );
  }
  
}

class Song extends StatelessWidget {
  final String title;
  final String author;
  final int likes;

  const Song({this.title, this.author, this.likes});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 4, bottom: 4, right: 10),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'http://thecatapi.com/api/images/get?format=src&size=small&type=jpg#${title.hashCode}',
                  ),
                  radius: 20.0
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(title, style: textTheme.subtitle1),
                  Text(author, style: textTheme.caption)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite, size: 25),
                    Text('${likes ?? ''}')
                  ],
                ),
                onTap: () {
                  //todo
                },
              ),
            )
          ],
        ),
      ),
    );
  }




}
