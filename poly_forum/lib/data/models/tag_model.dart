class Tag {
  final String label;
  final int id;

  const Tag({
    required this.id,
    required this.label,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      label: json['tag']['label'] ?? '',
      id: json['tag']['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "tag": label,
        "id": id,
      };

  @override
  String toString() {
    return "Tag: $label, Id: $id";
  }
}
