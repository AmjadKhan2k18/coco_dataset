import 'dart:convert';

import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/models/image.dart';
import 'package:coco_dataset_testapp/utils/http_requests.dart';

class ApiProvider {
  static Future<List<Category>> fetchCategories() async {
    final body = await HttpRequest.get();

    String superCatString = extractDataFromString(
      body: body,
      startFrom: 'var superCats = [',
      endAt: 'var catNames = [',
    );
    superCatString = superCatString.replaceAll('\'', '').replaceAll('];', '');
    final superCategories = superCatString.split(',');
    String categoriesString = extractDataFromString(
      body: body,
      startFrom: 'var categories = ',
      endAt: 'var superCats =',
    );

    categoriesString =
        categoriesString.replaceAll('\'', '"').replaceAll(';', '');

    Map<String, dynamic> categoriesJson = jsonDecode(categoriesString);
    List<Category> tempCats = [];
    for (String supCategory in superCategories) {
      categoriesJson[supCategory.trim()].forEach((cat) {
        tempCats.add(Category.fromJson(cat));
      });
    }
    return tempCats;
  }

  static Future<List<int>> getImageIdsByCats(List<int> categoriesIds) async {
    final body = await HttpRequest.post(
      data: {
        "category_ids": categoriesIds,
        "querytype": "getImagesByCats",
      },
    );
    if (body == null) return [];
    return jsonDecode(body).cast<int>();
  }

  static Future<List<ImageModel>> getImages(List<int> imagesIds) async {
    final responses = await Future.wait([
      HttpRequest.post(
          data: {"image_ids": imagesIds, "querytype": "getImages"}),
      HttpRequest.post(
          data: {"image_ids": imagesIds, "querytype": "getInstances"}),
    ]);

    final decodedImagesJson = jsonDecode(responses[0] ?? '[]');
    final decodedInstancesJson = jsonDecode(responses[1] ?? '[]');

    List<ImageInstances> instances = [];
    decodedInstancesJson
        .forEach((json) => instances.add(ImageInstances.fromJson(json)));

    List<ImageModel> images = [];
    decodedImagesJson.forEach((json) {
      final tempInst =
          instances.where((inst) => inst.imageId == json['id']).toList();
      images.add(ImageModel.fromJson(json, tempInst));
    });
    return images;
  }

  static extractDataFromString({
    required String body,
    required String startFrom,
    required String endAt,
  }) {
    final startIndex = body.indexOf(startFrom);
    final endIndex = body.indexOf(endAt, startIndex + startFrom.length);

    return body.substring(startIndex + startFrom.length, endIndex);
  }
}
