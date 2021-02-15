import 'package:replanit_tensorflow_future/model/base.dart';

class ItemSubItem extends Base {
  final int itemId;
  final int subItemId;

  ItemSubItem({this.itemId, this.subItemId});

  @override
  ItemSubItem fromMap(Map<String, dynamic> map) {
    return ItemSubItem(itemId: map['itemid'], subItemId: map['subitemid']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {'itemid': itemId, 'subitemid': subItemId};
  }
}
