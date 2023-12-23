import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/app_constants.dart';

void main(){
  test('AppConstants should have correct constant values', () {
    expect(AppConstants.appTitle, 'Jahiz');
    expect(AppConstants.hostUrl, 'https://jahiz-new.akwad.qa');
    expect(AppConstants.baseUrl, 'https://jahiz-new.akwad.qa/api/method/jahiz.smart_api');
    expect(AppConstants.dioTimeout, const Duration(milliseconds: 120000));
    expect(AppConstants.qatarInternationalCodeLabel, '+974');
    expect(AppConstants.qatarInternationalCode, '974');
    expect(AppConstants.phoneNumberHint, '5XXXXXXX');
    expect(AppConstants.tokenKey, 'TOKEN_KEY');
    expect(AppConstants.mainCategoriesId, 'All Item Groups');
    expect(AppConstants.languageKey, 'LANGUAGE_KEY');
  });
}