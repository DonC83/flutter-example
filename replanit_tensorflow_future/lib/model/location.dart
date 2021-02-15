import 'package:replanit_tensorflow_future/model/base.dart';

class Location extends Base {
  final String id;
  final String name;
  final String council;
  final String type;
  final String address;
  final double lat;
  final double lng;
  final String link;
  final List<dynamic> disposings;

  Location(
      {this.id,
      this.name,
      this.council,
      this.type,
      this.address,
      this.lat,
      this.lng,
      this.link,
      this.disposings});

  Location fromMapWithId(String id, Map<String, dynamic> map) {
    map.putIfAbsent('id', () => id);
    return fromMap(map);
  }

  @override
  Location fromMap(Map<String, dynamic> map) {
    return Location(
        id: map['id'],
        name: map['name'],
        council: map['council'],
        type: map['type'],
        address: map['address'],
        lat: map['lat'],
        lng: map['lng'],
        link: map['link'],
        disposings: map['disposings']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'council': council,
      'type': type,
      'address': address,
      'lat': lat,
      'lng': lng,
      'link': link
    };
  }

  @override
  String toString() {
    return 'Location{id: $id, name: $name, lat: $lat, lng: $lng}';
  }
}
