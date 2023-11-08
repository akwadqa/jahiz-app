import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../../../../core/network/network_service.dart';
import '../models/detailed_product_model.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/network/end_points.dart';

abstract class ProductsRemoteDataSource {
  Future<DetailedProductModel> getDetailedProduct(String productId);
}

class ProductsRemoteDataSourceImpl with RemoteDataSourceMixin implements ProductsRemoteDataSource {
  final NetworkService<Response> _networkService;

  ProductsRemoteDataSourceImpl(this._networkService);

  @override
  Future<DetailedProductModel> getDetailedProduct(String productId) async {
    final AppResponseModel<DetailedProductModel> responseModel =
        await performRequest<DetailedProductModel>(
            () => _networkService.get(
                endpoint: EndPoints.getDetailedProduct,
                queryParameters: {'website_item_id': productId}),
            (data) => DetailedProductModel.fromJson((data as List).first));
    return responseModel.data;
  }
}
