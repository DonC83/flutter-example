import 'package:replanit_tensorflow_future/model/base.dart';

class Program extends Base {
  final String id;
  final String itemId;
  final String name;
  final String desc;
  final String addInfo;
  final String image;

  Program(
      {this.id, this.itemId, this.name, this.desc, this.addInfo, this.image});

  @override
  Program fromMap(Map<String, dynamic> map) {
    return Program(
        id: map['id'],
        itemId: map['itemid'],
        name: map['name'],
        desc: map['desc'],
        addInfo: map['addinfo'],
        image: map['image']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemid': itemId,
      'name': name,
      'desc': desc,
      'addinfo': addInfo,
      'image': image
    };
  }

  @override
  String toString() {
    return 'Program{id: $id, itemId: $itemId, name: $name, desc: $desc, addinfo: $addInfo}';
  }
}
