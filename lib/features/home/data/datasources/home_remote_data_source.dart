import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
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

class HomeRemoteDataSourceImpl with RemoteDataSourceMixin implements HomeRemoteDataSource {
  final NetworkService<Response> _networkService;

  HomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<HomeBlockModel>> getHomeBlocks() async {
    final HomeResponse responseModel = await performRequest<List<HomeBlockModel>>(
        () => _networkService.get(endpoint: EndPoints.getHomeBlocks),
        (data) => (data as List).map((e) => _mapToHomeBlock(e)).toList());
    return responseModel.data;
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
