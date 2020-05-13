import 'package:flutter/material.dart';

void main() {
  runApp(NavigationAppExample());
}

class NavigationAppExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: FirstRoute(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: const Text('Go to second'),
            onPressed: () {
              // Pushs the SecondScreen widget onto the navigation stack
              Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (_) => SecondRoute()));
            }
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: const Text('Go to First'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

}