import 'dart:convert';

import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/utils/http_requests.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  static Future<List<Category>> fetchCategories() async {
    final body = await HttpRequest.get(url: 'COCO EXPLORER URL');

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

  static getImagesByCats(List<int> categoriesIds) async {
    final response = await HttpRequest.post(
      url: 'FUNCTION_URL',
      data: {
        "category_ids": categoriesIds.toString(),
        "querytype": "getImagesByCats"
      },
    );
    debugPrint(response.toString());
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
