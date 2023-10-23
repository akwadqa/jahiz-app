import '../../domain/entities/home_block.dart';
import 'home_block_data_model.dart';

class HomeBlockModel<T extends HomeBlockDataModel> extends HomeBlock<T> {
  const HomeBlockModel(
      {required super.id,
      required super.type,
      required super.title,
      required super.background,
      required super.view,
      required super.data});

  factory HomeBlockModel.fromJson(
          Map<String, dynamic> json, Function(dynamic) create) =>
      HomeBlockModel<T>(
          id: json['id'],
          type: json['type'],
          title: json['title'],
          background: json['background'],
          view: json['view'],
          data: create(json['data']));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'background': background,
      'view': view,
      'data': data
    };
  }
}
