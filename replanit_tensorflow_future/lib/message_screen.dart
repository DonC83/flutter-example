import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  final String message;
  final bool showSettings;

  const MessageScreen(this.message, this.showSettings);

  Widget settingsWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Text(
          'Click below to open settings and change permissions',
          textAlign: TextAlign.center,
        ),
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {

            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(padding: EdgeInsets.only(top: 10, bottom: 10)),
            Text('$message',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            showSettings ? settingsWidget() : Container(),
          ],
        ));
  }
}
