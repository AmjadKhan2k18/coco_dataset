class ImageModel {
  int id;
  String cocoUrl;
  String flickrUrl;

  ImageModel({
    required this.id,
    required this.cocoUrl,
    required this.flickrUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json['id'],
        cocoUrl: json['coco_url'],
        flickrUrl: json['flickr_url'],
      );
}
