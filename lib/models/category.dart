class Category {
  String supercategory;
  int id;
  String name;

  Category({required this.supercategory, required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        supercategory: json['supercategory'],
        id: json['id'],
        name: json['name'],
      );
}
