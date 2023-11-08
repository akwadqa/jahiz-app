import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/network/end_points.dart';
import '../models/sales_order_details/sales_order_details_model.dart';
import '../models/sales_order_model/sales_order_model.dart';

import '../../../../core/network/network_service.dart';

abstract class OrdersRemoteDataSource {
  Future<AppResponseModel<List<SalesOrderModel>>> getSalesOrders([int? page]);

  Future<SalesOrderDetailsModel> getSalesOrderDetails(String orderId);
}

class OrdersRemoteDataSourceImpl with RemoteDataSourceMixin implements OrdersRemoteDataSource {
  final NetworkService<Response> _networkService;

  OrdersRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppResponseModel<List<SalesOrderModel>>> getSalesOrders(
      [int? page]) async {
        return performRequest<List<SalesOrderModel>>(
        () => _networkService.get(
          endpoint: EndPoints.getSalesOrders,
          queryParameters: {
            'page': page,
          },
        ), (data) => (data as List).map((e) => SalesOrderModel.fromJson(e)).toList());
  }

  @override
  Future<SalesOrderDetailsModel> getSalesOrderDetails(String orderId) async {
    final responseModel = await performRequest<SalesOrderDetailsModel>(
      () => _networkService.get(
        endpoint: EndPoints.getSalesOrderDetails,
        queryParameters: {
          'sales_order_id': orderId,
        },
      ),
      (data) => SalesOrderDetailsModel.fromJson(data as Map<String, dynamic>),
    );
    return responseModel.data;
  }
}
