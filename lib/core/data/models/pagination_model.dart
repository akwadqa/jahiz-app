import 'package:jahiz/core/domain/entities/pagination.dart';

class PaginationModel extends Pagination {
  const PaginationModel(
      {required super.totalItems,
      required super.totalPages,
      required super.currentPage});

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      totalItems: json['total_items'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_items': totalItems,
      'total_pages': totalPages,
      'current_page': currentPage,
    };
  }
}
