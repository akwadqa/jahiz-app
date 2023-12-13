import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/core/domain/entities/pagination.dart';

void main() {
  group('AppResponse', () {
    test('should create AppResponse instance', () {
      const response = AppResponse<int>(
        statusCode: 200,
        error: 0,
        message: 'Success',
        pagination: Pagination(currentPage: 1, totalItems: 20, totalPages: 2),
        data: 42,
      );

      expect(response.statusCode, 200);
      expect(response.error, 0);
      expect(response.message, 'Success');
      expect(response.pagination,
          const Pagination(currentPage: 1, totalItems: 20, totalPages: 2));
      expect(response.data, 42);
    });

    test('should create copy of AppResponse instance with updated values', () {
      const original = AppResponse<int>(
        statusCode: 200,
        error: 0,
        message: 'Success',
        pagination: Pagination(currentPage: 1, totalItems: 20, totalPages: 2),
        data: 42,
      );

      final copy = original.copyWith(
        statusCode: 404,
        error: 1,
        message: 'Not Found',
        pagination:
            const Pagination(currentPage: 1, totalItems: 20, totalPages: 2),
        data: 99,
      );

      expect(copy.statusCode, 404);
      expect(copy.error, 1);
      expect(copy.message, 'Not Found');
      expect(copy.pagination,
          const Pagination(currentPage: 1, totalItems: 20, totalPages: 2));
      expect(copy.data, 99);

      expect(original.statusCode, 200);
      expect(original.error, 0);
      expect(original.message, 'Success');
      expect(original.pagination,
          const Pagination(currentPage: 1, totalItems: 20, totalPages: 2));
      expect(original.data, 42);
    });
  });
}
