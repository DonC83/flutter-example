import 'package:replanit_tensorflow_future/model/base.dart';
import 'package:replanit_tensorflow_future/model/category.dart';

class Item extends Base {
  final String id;
  final Category category;
  final String displayName;
  final List<dynamic> alternatives;
  final String simpleDesc;
  final String detailDesc;
  final String imageName;
  List<dynamic> programs;

  Item(
      {this.id,
      this.category,
      this.displayName,
      this.alternatives,
      this.simpleDesc,
      this.detailDesc,
      this.imageName,
      this.programs});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'displayname': displayName,
      'alternatives': alternatives,
      'simpledesc': simpleDesc,
      'detaildesc': detailDesc,
      'imagename': imageName,
      'programs': programs
    };
  }

  Item fromMapWithId(String id, Map<String, dynamic> map) {
    map.putIfAbsent('id', () => id);
    return fromMap(map);
  }

  @override
  Item fromMap(Map<String, dynamic> map) {
    return Item(
        id: map['id'],
        category: Category().fromMap(map),
        displayName: map['displayname'],
        alternatives: map['alternatives'],
        simpleDesc: map['simpledesc'],
        detailDesc: map['detaildesc'],
        imageName: map['imagename'],
        programs: map['programs']);
  }

  @override
  String toString() {
    return 'Item{id: $id, category: ${category.toString()}, displayname: $displayName}';
  }
}
