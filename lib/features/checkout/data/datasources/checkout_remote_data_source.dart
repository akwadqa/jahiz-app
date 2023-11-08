import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class CheckoutRemoteDataSource {
  Future<String> placeOrder(String quotationId, int? isSuccess);
}

class CheckoutRemoteDataSourceImpl
    with RemoteDataSourceMixin
    implements CheckoutRemoteDataSource {
  final NetworkService<Response> _networkService;

  CheckoutRemoteDataSourceImpl(this._networkService);

  @override
  Future<String> placeOrder(String quotationId, int? isSuccess) async {
    final formData = FormData.fromMap({
      'quotation_id': quotationId,
      if (isSuccess != null) 'is_success': isSuccess,
    });
    final AppResponseModel<String> responseModel = await performRequest<String>(
        () => _networkService.post(
            endpoint: EndPoints.placeOrder, data: formData),
        (data) => data.isNotEmpty ? data['sales_order'] : null);
    return responseModel.data;
  }
}
