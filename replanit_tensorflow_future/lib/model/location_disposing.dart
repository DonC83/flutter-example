import 'package:replanit_tensorflow_future/model/base.dart';

class LocationDisposing extends Base {
  final int locationId;
  final int disposingId;

  LocationDisposing({this.locationId, this.disposingId});

  @override
  LocationDisposing fromMap(Map<String, dynamic> map) {
    return LocationDisposing(
        locationId: map['locationid'], disposingId: map['disposingid']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {'locationid': locationId, 'disposingid': disposingId};
  }
}
