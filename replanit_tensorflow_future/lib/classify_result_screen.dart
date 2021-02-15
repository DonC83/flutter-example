import 'package:flutter/material.dart';
import 'package:replanit_tensorflow_future/model/disposable_item.dart';
import 'package:replanit_tensorflow_future/service/firestore_service.dart';

class ClassifyResultScreen extends StatefulWidget {

  final String category;

  const ClassifyResultScreen(this.category);

  @override
  State<StatefulWidget> createState() => ClassifyResultScreenState();

}

class ClassifyResultScreenState extends State<ClassifyResultScreen> {

  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firestoreService.findItemsByCategory(this.widget.category),
        builder: (context, AsyncSnapshot<List<DisposableItem>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Text(snapshot.data.first.item.displayName),
            );
          } else {
            return Container(
              child: Text('Nothing ffs'),
            );
          }
        }
    );
  }

}