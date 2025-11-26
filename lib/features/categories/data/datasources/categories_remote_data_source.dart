import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../models/category_model.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoryModel> getCategories(String category, String? search);
}

class CategoriesRemoteDataSourceImpl
    with RemoteDataSourceMixin
    implements CategoriesRemoteDataSource {
  final NetworkService<Response> _networkService;

  CategoriesRemoteDataSourceImpl(this._networkService);
  @override
  Future<CategoryModel> getCategories(String category, String? search) async {
    final AppResponseModel<CategoryModel> responseModel =
        await performRequest<CategoryModel>(
            () => _networkService.get(
                endpoint: EndPoints.getCategories,
                queryParameters: {'category': category, 'search': search}),
            (data) => CategoryModel.fromJson(data));
    return responseModel.data;
  }
}
