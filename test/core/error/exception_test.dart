import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/error/exception.dart';

void main() {
  test('toString method should return the correct message', () {
    const errorMessage = 'This is an error message';
    final serverException = ServerException(message: errorMessage);

    final result = serverException.toString();

    expect(result, errorMessage);
  });
}
