class Category {
  String supercategory;
  int id;
  String name;
  bool isSelected;

  Category(
      {required this.supercategory,
      required this.id,
      required this.name,
      required this.isSelected});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        supercategory: json['supercategory'],
        id: json['id'],
        name: json['name'],
        isSelected: false,
      );
}
