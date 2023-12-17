import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';
import 'package:jahiz/core/network/network_service.dart';
import 'package:jahiz/features/auth/application/auth_cubit.dart';
import 'package:mocktail/mocktail.dart';

//Todo: There is an error on this test
class MockSelectedLanguageCubit extends Mock implements SelectedLanguageCubit {}

class MockAuthCubit extends Mock implements AuthCubit {}

class MockResponse extends Mock implements Response {}

class MockDio extends Mock implements Dio {}

void main() {
  group('DioNetworkService', () {
    late DioNetworkService dioNetworkService;
    late MockSelectedLanguageCubit mockSelectedLanguageCubit;
    late MockAuthCubit mockAuthCubit;
    late Dio mockDio;

    setUp(() {
      mockSelectedLanguageCubit = MockSelectedLanguageCubit();
      mockAuthCubit = MockAuthCubit();
      mockDio = MockDio();
      dioNetworkService = DioNetworkService(
        mockSelectedLanguageCubit,
        mockAuthCubit,
      );
    });

    test('get returns Response on success', () async {
      final mockResponse = MockResponse();
      const endpoint = 'test_endpoint';
      final queryParameters = {'param1': 'value1'};

      when(() => mockDio.get(endpoint, queryParameters: queryParameters))
          .thenAnswer((_) async => mockResponse);

      final result = await dioNetworkService.get(
          endpoint: endpoint, queryParameters: queryParameters);

      verify(() => mockDio.get(
            endpoint,
            queryParameters: queryParameters,
          )).called(1);
      expect(result, mockResponse);
    });
  });
  // test('post method should make a POST request with the correct parameters',
  //     () async {
  //   final mockResponse = MockResponse();
  //   const endpoint = 'test_endpoint';
  //   final data = {'key': 'value'};
  //   final headers = {'Authorization': 'token token123'};

  //   when(()=> mockDio.post(
  //     any,
  //     data: anyNamed('data'),
  //     options: anyNamed('options'),
  //   )).thenAnswer((_) async => mockResponse);

  //   // Act
  //   final result = await dioNetworkService.post(
  //     endpoint: endpoint,
  //     data: data,
  //     headers: headers,
  //   );

  //   // Assert
  //   verify(mockDio.post(
  //     endpoint,
  //     data: data,
  //     options: Options(headers: headers),
  //   )).called(1);
  //   expect(result, mockResponse);
  // });
}
