import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/exception.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/core/network/network_info.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import 'package:mocktail/mocktail.dart';

//Todo: There is an error on this test

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  group('NetworkOperationHandler', () {
    late NetworkOperationHandler networkOperationHandler;
    late MockNetworkInfo mockNetworkInfo;

    setUp(() {
      mockNetworkInfo = MockNetworkInfo();
      networkOperationHandler = NetworkOperationHandler(mockNetworkInfo);
    });

    test(
        'handleNetworkOperation returns Right(result) when isConnected is true',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      const expectedResult = 'Test Result';
      operationFunction() async => expectedResult;

      final result = await networkOperationHandler
          .handleNetworkOperation(operationFunction);

      verify(() => mockNetworkInfo.isConnected).called(1);
      expect(result, const Right(expectedResult));
    });

    test(
        'handleNetworkOperation returns Left(OfflineFailure) when isConnected is false',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      operationFunction() async => 'Test Result';

      final result = await networkOperationHandler
          .handleNetworkOperation(operationFunction);

      verify(() => mockNetworkInfo.isConnected).called(1);
      expect(result, Left(OfflineFailure()));
    });

    test(
        'handleNetworkOperation returns Left(ServerFailure) on ServerException',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      const exceptionMessage = 'Server error message';
      operationFunction() async =>
          throw ServerException(message: exceptionMessage);

      final result = await networkOperationHandler
          .handleNetworkOperation(operationFunction);

      verify(() => mockNetworkInfo.isConnected).called(1);
      expect(
          result,
          Left(ServerFailure(
              exceptionMessage, isA<StackTrace>() as StackTrace)));
    });
  });
}
