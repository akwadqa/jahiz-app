import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int totalItems;
  final int totalPages;
  final int currentPage;

  const Pagination(
      {required this.totalItems,
      required this.totalPages,
      required this.currentPage});

  Pagination copyWith({int? totalItems, int? totalPages, int? currentPage}) =>
      Pagination(
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
      );

  @override
  List<Object?> get props => [totalItems, totalPages, currentPage];
}
