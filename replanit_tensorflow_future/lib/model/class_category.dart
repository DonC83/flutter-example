class ClassCategory {
  final double confidence;
  final int index;
  final String label;

  ClassCategory(this.confidence, this.index, this.label);

  ClassCategory.fromJson(Map<dynamic, dynamic> json)
      : confidence = json['confidence'],
        index = json['index'],
        label = json['label'];
}
