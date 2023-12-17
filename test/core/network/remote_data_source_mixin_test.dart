import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/data/models/app_response_model.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import 'package:mocktail/mocktail.dart';

//Todo: There is an error on this test

class MockResponse extends Mock implements Response {}

class MockAppResponseModel<T> extends Mock implements AppResponseModel<T> {}

void main() {
  group("RemoteDataSourceMixin", () {
    late RemoteDataSourceMixin remoteDataSourceMixin;
    late MockResponse mockResponse;

    setUp(() {
      mockResponse = MockResponse();
    });
    // test('performRequest should return AppResponseModel on successful request',
    //     () async{
    //   fromJsonFunction(dynamic json) => 'Test Result';
    //   final appResponseModel = MockAppResponseModel<String>();
    //   when(() => mockResponse.data)
    //       .thenReturn({'data': 'Test Data', 'error': 0, 'message': 'Success'});
    //   when(() => appResponseModel.error).thenReturn(0);
      
    //   final result = await remoteDataSourceMixin.performRequest<String>(
    //     () async => mockResponse,
    //     fromJsonFunction,
    //   );

    //   // Assert
    //   verify(mockResponse.data).called(1);
    //   verify(appResponseModel.fromJson('Test Data', fromJsonFunction))
    //       .called(1);
    //   expect(result, appResponseModel);
    // });
  });
}
