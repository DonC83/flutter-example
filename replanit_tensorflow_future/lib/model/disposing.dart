class Disposing {
  final String id;
  final String method;
  final String description;
  final String bin;
  final String filterName;

  Disposing(
      {this.id, this.method, this.description, this.bin, this.filterName});

  Map<String, dynamic> toMap() {
    return {'id': id, 'method': method, 'bin': bin};
  }

  Disposing fromMap(Map<String, dynamic> map) {
    return Disposing(id: map['id'], method: map['method'], bin: map['bin']);
  }

  Disposing fromMapWithId(String id, Map<String, dynamic> map) {
    map.putIfAbsent('id', () => id);
    return fromMap(map);
  }

  Disposing fromMapWithoutId(Map<String, dynamic> map) {
    return Disposing(method: map['method'], bin: map['bin']);
  }

  @override
  String toString() {
    return 'Item{id: $id, method: $method, bin: $bin}';
  }
}
