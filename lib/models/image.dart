import 'dart:convert';

class ImageModel {
  int id;
  String cocoUrl;
  String flickrUrl;
  List<ImageInstances> instances;

  ImageModel({
    required this.id,
    required this.cocoUrl,
    required this.flickrUrl,
    required this.instances,
  });

  factory ImageModel.fromJson(
          Map<String, dynamic> json, List<ImageInstances> _instances) =>
      ImageModel(
        id: json['id'],
        cocoUrl: json['coco_url'],
        flickrUrl: json['flickr_url'],
        instances: _instances,
      );
}

class ImageInstances {
  int imageId;
  List<dynamic> segmentation;
  int categoryId;

  ImageInstances({
    required this.imageId,
    required this.segmentation,
    required this.categoryId,
  });

  factory ImageInstances.fromJson(Map<String, dynamic> json) {
    final instance = jsonDecode(json['segmentation']);
    return ImageInstances(
      imageId: json['image_id'],
      segmentation: instance is List<dynamic> ? instance : [],
      categoryId: json['category_id'],
    );
  }
}
