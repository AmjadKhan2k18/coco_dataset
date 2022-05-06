import 'package:coco_dataset_testapp/utils/http_requests.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Load API FROM ENV', () async {
    await HttpRequest.init(isTest: true);

    final explorerUrl = HttpRequest.explorerApiUrl;
    final cloudFunctionurl = HttpRequest.cloudFunctionUrl;

    expect(explorerUrl, isA<String>());
    expect(explorerUrl.length, greaterThan(0));
    expect(cloudFunctionurl, isA<String>());
    expect(cloudFunctionurl.length, greaterThan(0));
  });
}
