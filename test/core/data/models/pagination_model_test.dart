import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/data/models/pagination_model.dart';

void main() {
  group("Pagination model", () {
    test('from json should create an instance of PaginationModel', () {
      final Map<String, dynamic> json = {
        "total_items": 5,
        "total_pages": 4,
        "current_page": 2
      };
      final appResponseModel = PaginationModel.fromJson(json);

      expect(appResponseModel, isA<PaginationModel>());
      expect(appResponseModel.totalItems, equals(5));
      expect(appResponseModel.totalPages, equals(4));
      expect(appResponseModel.currentPage, equals(2));
    });
    test("to json should return a Map<String, dynamic>", () {
      PaginationModel paginationModel =
          const PaginationModel(totalItems: 5, totalPages: 2, currentPage: 1);
      final map = paginationModel.toJson();
      expect(map, isA<Map<String, dynamic>>());
      expect(map["total_items"], equals(5));
      expect(map["total_pages"], equals(2));
      expect(map["current_page"], equals(1));
    });
  });
}
