class CategoryModel {
  final String name;
  final String icon;
  final int countServices;
  final String categoryServices;

  CategoryModel(
      {required this.name,
      required this.icon,
      required this.countServices,
      required this.categoryServices});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      icon: json['icon'],
      countServices: json['count_services'],
      categoryServices: json['category_services'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['icon'] = icon;
    data['count_services'] = countServices;
    data['category_services'] = categoryServices;
    return data;
  }
}
