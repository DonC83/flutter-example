import 'package:replanit_tensorflow_future/model/disposing.dart';
import 'package:replanit_tensorflow_future/model/item.dart';

class Disposable {
  final int id;
  final Item item;
  final String state;
  final String country;
  final Disposing disposing;

  Disposable({this.id, this.item, this.state, this.country, this.disposing});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item': Item().toMap(),
      'state': state,
      'country': country,
      'disposing': Disposing().toMap()
    };
  }

  Disposable fromMap(Map<String, dynamic> map) {
    return Disposable(
      id: map['id'],
      item: Item().fromMap(map),
      state: map['state'],
      country: map['country'],
      disposing: Disposing().fromMap(map),
    );
  }

  @override
  String toString() {
    return 'Item{id: $id, item: ${item.toString()}, state: $state, country: $country, disposing: ${disposing.toString()}';
  }
}
