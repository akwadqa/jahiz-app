import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/home_block_model.dart';
import '../../../products/data/models/product_model.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../models/home_block_data_model.dart';

typedef HomeResponse
    = AppResponseModel<List<HomeBlockModel<HomeBlockDataModel>>>;

abstract class HomeRemoteDataSource {
  Future<List<HomeBlockModel>> getHomeBlocks();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkService<Response> _networkService;

  HomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<HomeBlockModel>> getHomeBlocks() async {
    try {
      final Response response =
          await _networkService.get(endpoint: EndPoints.getHomeBlocks);
      HomeResponse responseModel = HomeResponse.fromJson(response.data,
          (data) => (data as List).map((e) => _mapToHomeBlock(e)).toList());
      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      } else {
        return responseModel.data;
      }
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }

  HomeBlockModel<HomeBlockDataModel> _mapToHomeBlock(
      Map<String, dynamic> json) {
    if (json['type'] == 'Banner') {
      return HomeBlockModel<BannerModel>.fromJson(
          json,
          (data) =>
              (data as List).map((e) => BannerModel.fromJson(e)).toList());
    } else if (json['type'] == 'Categories') {
      return HomeBlockModel<CategoryModel>.fromJson(
          json,
          (data) =>
              (data as List).map((e) => CategoryModel.fromJson(e)).toList());
    } else {
      return HomeBlockModel<ProductModel>.fromJson(
          json,
          (data) =>
              (data as List).map((e) => ProductModel.fromJson(e)).toList());
    }
  }
}
