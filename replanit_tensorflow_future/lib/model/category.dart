class Category {
  final String id;
  final String name;

  Category({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  Category fromMap(Map<String, dynamic> map) {
    return Category(id: map['id'], name: map['name']);
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name}';
  }
}
