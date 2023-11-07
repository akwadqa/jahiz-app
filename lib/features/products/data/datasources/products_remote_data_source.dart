import 'package:dio/dio.dart';
import 'package:jahiz/core/network/network_service.dart';
import 'package:jahiz/features/products/data/models/detailed_product_model.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';

abstract class ProductsRemoteDataSource {
  Future<DetailedProductModel> getDetailedProduct(String productId);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final NetworkService<Response> _networkService;

  ProductsRemoteDataSourceImpl(this._networkService);

  @override
  Future<DetailedProductModel> getDetailedProduct(String productId) async {
    try {
      final Response response = await _networkService.get(
          endpoint: EndPoints.getDetailedProduct,
          queryParameters: {'website_item_id': productId});
      AppResponseModel<DetailedProductModel> responseModel =
          AppResponseModel<DetailedProductModel>.fromJson(response.data,
              (data) => DetailedProductModel.fromJson((data as List).first));
      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      } else {
        return responseModel.data;
      }
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }
}
