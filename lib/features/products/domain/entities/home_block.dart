import 'package:equatable/equatable.dart';
import 'package:jahiz/features/products/domain/entities/home_block_data.dart';

class HomeBlock<T extends HomeBlockData> extends Equatable {
  final String id;
  final String? title;
  final String type;
  final String background;
  final String view;
  final List<T> data;

  const HomeBlock(
      {required this.id,
      required this.type,
      required this.title,
      required this.background,
      required this.view,
      required this.data});

  HomeBlock<T> copyWith({
    String? id,
    String? type,
    String? title,
    String? background,
    String? view,
    List<T>? data,
  }) =>
      HomeBlock<T>(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        background: background ?? this.background,
        view: view ?? this.view,
        data: data ?? this.data,
      );

  @override
  List<Object?> get props => [id, type, title, background, view, data];
}
