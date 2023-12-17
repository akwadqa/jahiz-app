import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/domain/entities/pagination.dart';

void main() {
  group('Pagination', () {
    test('should create pagination instance', () {
      const pagination =
          Pagination(totalItems: 5, totalPages: 1, currentPage: 1);
      expect(pagination.totalItems, 5);
      expect(pagination.totalPages, 1);
      expect(pagination.currentPage, 1);
    });
    test("should create copy of Pagination instance with updated values", () {
      const original = Pagination(totalItems: 5, totalPages: 1, currentPage: 1);
      final copy =
          original.copyWith(totalItems: 4, totalPages: 2, currentPage: 1);

      expect(copy.totalItems, 4);
      expect(copy.totalPages, 2);
      expect(copy.currentPage, 1);

      expect(original.totalItems, 5);
      expect(original.totalPages, 1);
      expect(original.currentPage, 1);
    });
  });
}
