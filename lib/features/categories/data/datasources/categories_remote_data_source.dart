import 'package:dio/dio.dart';
import 'package:jahiz/features/categories/data/models/category_model.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoryModel> getCategories(String category);
}

class CategoriesRemoteDataSourceImpl extends CategoriesRemoteDataSource {
  final NetworkService<Response> _networkService;

  CategoriesRemoteDataSourceImpl(this._networkService);
  @override
  Future<CategoryModel> getCategories(String category) async {
    try {
      final response = await _networkService.get(
          endpoint: EndPoints.getCategories,
          queryParameters: {'category': category});
      AppResponseModel<CategoryModel> responseModel =
          AppResponseModel<CategoryModel>.fromJson(
              response.data, (data) => CategoryModel.fromJson(data));
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
