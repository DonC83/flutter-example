import 'package:flutter/material.dart';

void main() {
  runApp(NavigationExample());
}

class NavigationExample extends StatelessWidget {

  Route<dynamic> _parseRoute(RouteSettings settings) {
    final List<String> path = settings.name.split('/');
    assert(path[0] == '');
    if (path[1] == 'second' && path.length == 3) {
      final value = double.parse(path[2]);

      return new MaterialPageRoute<double>(
          settings: settings,
          builder: (BuildContext) => new SecondScreenWidget(value: value),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Page',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: FirstScreenWidget(),
      onGenerateRoute: _parseRoute,
    );
  }
}

class FirstScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreenWidget> {

  var _value = 50.0;

  _navigateUsingConstructor() async {
    _value = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => new SecondScreenWidget(value: _value)
      )
    ) ?? 1.0;
  }

  _navigateUsingRoute() async {
    _value = await Navigator.of(context).pushNamed('/second/$_value') ?? 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('First Screen'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Slider(
                min: 1.0,
                max: 100,
                value: _value,
                onChanged: (value) => setState(() => _value = value)
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                    child: const Text('Pass via constructor'),
                    onPressed: _navigateUsingConstructor
                ),
                new RaisedButton(
                    child: const Text('Pass via route'),
                    onPressed: _navigateUsingRoute)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreenWidget extends StatefulWidget {

  final double value;

  SecondScreenWidget({this.value:1.0});

  @override
  State<StatefulWidget> createState() => SecondScreenState(value);
}

class SecondScreenState extends State<SecondScreenWidget> {

  double _value;

  SecondScreenState(this._value);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: const Text('Second Screen')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Slider(
                min: 1.0,
                max: 100,
                value: _value,
                onChanged: (value) => setState(() => _value = value)
            ),
            new RaisedButton(
                child: const Text('Return to first'),
                onPressed: () => Navigator.of(context).pop(_value)
            )
          ],
        ),
      ),
    );
  }
}

