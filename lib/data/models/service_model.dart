class ServiceModel {
  final String name;
  final String image;
  final int priceFrom;
  final int priceTo;
  final String detail;
  final List<String>? serviceInclude;
  final List<String>? serviceExclude;
  final int? id;
  final List<ReviewModel>? reviews;

  ServiceModel({
    required this.name,
    required this.image,
    required this.priceFrom,
    required this.priceTo,
    required this.detail,
    this.serviceInclude,
    this.serviceExclude,
    this.id,
    this.reviews,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        name: json['name'],
        image: json['image'],
        priceFrom: json['price_from'],
        priceTo: json['price_to'],
        detail: json['detail'] ?? '',
        serviceExclude: json['not_include_services'] != null
            ? json['not_include_services']
                .map((e) => e["descriptions"])
                .toList()
                .cast<String>()
            : [],
        serviceInclude: json['include_services'] != null
            ? json['include_services']
                .map((e) => e["descriptions"])
                .toList()
                .cast<String>()
            : [],
        id: json["id"],
        reviews: json["reviews"] != null
            ? json["reviews"]
                .map((e) => ReviewModel.fromJson(e))
                .toList()
                .cast<ReviewModel>()
            : []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['image'] = image;
    data['price_from'] = priceFrom;
    data['price_to'] = priceTo;
    data['detail'] = detail;
    return data;
  }
}

class CategoryWithServicesModel {
  final String name;
  final String icon;
  final List<ServiceModel> services;
  CategoryWithServicesModel(
      {required this.name, required this.icon, required this.services});

  factory CategoryWithServicesModel.fromJson(Map<String, dynamic> map) {
    return CategoryWithServicesModel(
        name: map["detail"]["name"],
        icon: map["detail"]["icon"],
        services: map["detail"]["services"]
            .map((e) => ServiceModel.fromJson(e))
            .toList()
            .cast<ServiceModel>());
  }
}

class ReviewModel {
  final int id;
  final String name;
  final String image;
  final int review;
  final String comment;
  final String createdAt;
  final String updatedAt;

  ReviewModel(
      {required this.id,
      required this.name,
      required this.comment,
      required this.image,
      required this.review,
      required this.createdAt,
      required this.updatedAt});
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
        id: json['id'],
        name: '${json['user']['first_name']} ${json['user']['last_name']}',
        image: json['user']['image'],
        review: json['review'],
        createdAt: json['create_at'],
        updatedAt: json['update_at'],
        comment: json['comment']);
  }
}
