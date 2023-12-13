import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/data/models/app_response_model.dart';
import 'package:jahiz/core/data/models/pagination_model.dart';
import 'package:jahiz/core/error/exception.dart';

void main() {
  group('App Response Model', () {
    test('fromJson should create an instance of AppResponseModel', () {
      final Map<String, dynamic> jsonData = {
        'status_code': 200,
        'error': 0,
        'message': 'Success',
        'pagination': {'total_items': 10, 'total_pages': 1, 'current_page': 5},
        'data': {'data': 'test_data'}
      };
      final appResponseModel = AppResponseModel.fromJson(
          jsonData, (data) => TestEntity.fromJson(data));

      expect(appResponseModel, isA<AppResponseModel>());
      expect(appResponseModel.statusCode, equals(200));
      expect(appResponseModel.error, equals(0));
      expect(appResponseModel.message, equals('Success'));
      expect(appResponseModel.pagination, isA<PaginationModel>());
      expect(appResponseModel.data, isA<TestEntity>());
    });
    test("fromJson should throw ServerException on error", () {
      final Map<String, dynamic> jsonData = {
        'error': 1,
        'message': 'Error occurred',
      };
      expect(
        () => AppResponseModel.fromJson(
            jsonData, (data) => TestEntity.fromJson(data)),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          equals('Error occurred'),
        )),
      );
    });
  });
}

class TestEntity {
  String data;

  TestEntity({required this.data});
  factory TestEntity.fromJson(Map<String, dynamic> json) {
    return TestEntity(data: json["data"]);
  }
}
