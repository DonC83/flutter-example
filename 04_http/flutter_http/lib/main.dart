import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

void main() {
  runApp(NetworkApp());
}

class NetworkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NetworkBody(),
      ),
    );
  }
}

class NetworkBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Quotation(url: 'https://quotes.rest/qod.json'),
          Padding(padding: EdgeInsets.only(top: 50),),
          Image.network('')
        ],
      ),
    );
  }

}

class Quotation extends StatefulWidget {

  final String url;

  const Quotation({Key key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuotationState();

}

class _QuotationState extends State<Quotation> {

  String data = 'Loading ...';


  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    final res = await http.get(widget.url);
    setState(() => data = _parseQuoteFromJson(res.body));
  }

  _parseQuoteFromJson(String body) {
    final jsonQuote = json.decode(body);
    return jsonQuote['contents']['quotes'][0]['quote'];
  }

  @override
  Widget build(BuildContext context) {
    return Text(data, textAlign: TextAlign.center);
  }

}
