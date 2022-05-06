import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/models/image.dart';
import 'package:coco_dataset_testapp/utils/api_provider.dart';
import 'package:coco_dataset_testapp/utils/http_requests.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Get And Extract Categories', () async {
    await HttpRequest.init(isTest: true);
    final categories = await ApiProvider.fetchCategories();
    expect(categories, isA<List<Category>>());
    expect(categories.length, greaterThan(0));
  });

  test('Get Images Ids', () async {
    await HttpRequest.init(isTest: true);
    final imageIds = await ApiProvider.getImageIdsByCats([10]);
    expect(imageIds, isA<List<int>>());
    expect(imageIds.length, greaterThan(0));
  });
  test('Get Images data', () async {
    await HttpRequest.init(isTest: true);
    final images = await ApiProvider.getImages([427160, 262148, 308295, 29853]);

    expect(images, isA<List<ImageModel>>());
    expect(images.length, 4);
  });
}
