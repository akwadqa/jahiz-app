// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `What are you looking for..`
  String get searchHint {
    return Intl.message(
      'What are you looking for..',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `ADD TO CART`
  String get addToCart {
    return Intl.message(
      'ADD TO CART',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Specifications`
  String get specifications {
    return Intl.message(
      'Specifications',
      name: 'specifications',
      desc: '',
      args: [],
    );
  }

  /// `Sign up / Login`
  String get signupLogin {
    return Intl.message(
      'Sign up / Login',
      name: 'signupLogin',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number to register or to sign in to your existing account`
  String get signupLoginDescription {
    return Intl.message(
      'Please enter your phone number to register or to sign in to your existing account',
      name: 'signupLoginDescription',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueLabel {
    return Intl.message(
      'Continue',
      name: 'continueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `We have found an existing account that is associated with your mobile number. Enter your Password to log in`
  String get loginDescription {
    return Intl.message(
      'We have found an existing account that is associated with your mobile number. Enter your Password to log in',
      name: 'loginDescription',
      desc: '',
      args: [],
    );
  }

  /// `Register a new Account`
  String get registerANewAccount {
    return Intl.message(
      'Register a new Account',
      name: 'registerANewAccount',
      desc: '',
      args: [],
    );
  }

  /// `No account is associated with your mobile number. We will create a new account for you using`
  String get registerDescription {
    return Intl.message(
      'No account is associated with your mobile number. We will create a new account for you using',
      name: 'registerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `I have read and agree to the`
  String get agreeTermsAndConditions {
    return Intl.message(
      'I have read and agree to the',
      name: 'agreeTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Must be 8 digits`
  String get mustBeEightDigits {
    return Intl.message(
      'Must be 8 digits',
      name: 'mustBeEightDigits',
      desc: '',
      args: [],
    );
  }

  /// `Must start with 3, 5, 6, or 7`
  String get qatariPhoneNumberValidator {
    return Intl.message(
      'Must start with 3, 5, 6, or 7',
      name: 'qatariPhoneNumberValidator',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Must be 8 digits at least`
  String get mustBeEightDigitsAtLeast {
    return Intl.message(
      'Must be 8 digits at least',
      name: 'mustBeEightDigitsAtLeast',
      desc: '',
      args: [],
    );
  }

  /// `You should agree to the terms and conditions`
  String get agreeTermsAndConditionsValidator {
    return Intl.message(
      'You should agree to the terms and conditions',
      name: 'agreeTermsAndConditionsValidator',
      desc: '',
      args: [],
    );
  }

  /// `Shop By Category`
  String get shopByCategory {
    return Intl.message(
      'Shop By Category',
      name: 'shopByCategory',
      desc: '',
      args: [],
    );
  }

  /// `All Products`
  String get allProducts {
    return Intl.message(
      'All Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `You have items in your cart`
  String get youHaveItemsInYourCart {
    return Intl.message(
      'You have items in your cart',
      name: 'youHaveItemsInYourCart',
      desc: '',
      args: [],
    );
  }

  /// `View cart`
  String get viewCart {
    return Intl.message(
      'View cart',
      name: 'viewCart',
      desc: '',
      args: [],
    );
  }

  /// `No Elements`
  String get noElements {
    return Intl.message(
      'No Elements',
      name: 'noElements',
      desc: '',
      args: [],
    );
  }

  /// `Choose your location`
  String get chooseYourLocation {
    return Intl.message(
      'Choose your location',
      name: 'chooseYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Enter your location`
  String get enterYourLocation {
    return Intl.message(
      'Enter your location',
      name: 'enterYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Office`
  String get office {
    return Intl.message(
      'Office',
      name: 'office',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get apartment {
    return Intl.message(
      'Apartment',
      name: 'apartment',
      desc: '',
      args: [],
    );
  }

  /// `Address Details`
  String get addressDetails {
    return Intl.message(
      'Address Details',
      name: 'addressDetails',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Building Number`
  String get buildingNumber {
    return Intl.message(
      'Building Number',
      name: 'buildingNumber',
      desc: '',
      args: [],
    );
  }

  /// `Street Number`
  String get streetNumber {
    return Intl.message(
      'Street Number',
      name: 'streetNumber',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Receiver Details`
  String get receiverDetails {
    return Intl.message(
      'Receiver Details',
      name: 'receiverDetails',
      desc: '',
      args: [],
    );
  }

  /// `Receiver Phone Number`
  String get receiverPhoneNumber {
    return Intl.message(
      'Receiver Phone Number',
      name: 'receiverPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Additional Directions`
  String get additionalDirections {
    return Intl.message(
      'Additional Directions',
      name: 'additionalDirections',
      desc: '',
      args: [],
    );
  }

  /// `Select your city`
  String get selectYourCity {
    return Intl.message(
      'Select your city',
      name: 'selectYourCity',
      desc: '',
      args: [],
    );
  }

  /// `Default shipping address`
  String get defaultShippingAddress {
    return Intl.message(
      'Default shipping address',
      name: 'defaultShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get myCart {
    return Intl.message(
      'My Cart',
      name: 'myCart',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subTotal {
    return Intl.message(
      'Sub Total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// ` Your Order`
  String get yourOrder {
    return Intl.message(
      ' Your Order',
      name: 'yourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Shipping to`
  String get shippingTo {
    return Intl.message(
      'Shipping to',
      name: 'shippingTo',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Apply Discount Code`
  String get applyDiscountCode {
    return Intl.message(
      'Apply Discount Code',
      name: 'applyDiscountCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter Promo Code`
  String get enterPromoCode {
    return Intl.message(
      'Enter Promo Code',
      name: 'enterPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `+Add new address`
  String get addNewAddress {
    return Intl.message(
      '+Add new address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Order price`
  String get orderPrice {
    return Intl.message(
      'Order price',
      name: 'orderPrice',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Total price`
  String get totalPrice {
    return Intl.message(
      'Total price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Select your Payment`
  String get selectYourPayment {
    return Intl.message(
      'Select your Payment',
      name: 'selectYourPayment',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `GO TO PRODUCT`
  String get goToProduct {
    return Intl.message(
      'GO TO PRODUCT',
      name: 'goToProduct',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Payment Success`
  String get paymentSuccess {
    return Intl.message(
      'Payment Success',
      name: 'paymentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Thank you!`
  String get thankYou {
    return Intl.message(
      'Thank you!',
      name: 'thankYou',
      desc: '',
      args: [],
    );
  }

  /// `Your order has got placed successfully.`
  String get orderPlaced {
    return Intl.message(
      'Your order has got placed successfully.',
      name: 'orderPlaced',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Homepage`
  String get homePage {
    return Intl.message(
      'Homepage',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `The payment is received and your order has got placed successfully.`
  String get orderAndPaymentPlaced {
    return Intl.message(
      'The payment is received and your order has got placed successfully.',
      name: 'orderAndPaymentPlaced',
      desc: '',
      args: [],
    );
  }

  /// `Payment is Failed.`
  String get paymentIsFailed {
    return Intl.message(
      'Payment is Failed.',
      name: 'paymentIsFailed',
      desc: '',
      args: [],
    );
  }

  /// `Please visit order details to re-pay again.`
  String get orderPaymentFailed {
    return Intl.message(
      'Please visit order details to re-pay again.',
      name: 'orderPaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Please add shipping address first`
  String get addShippingAddress {
    return Intl.message(
      'Please add shipping address first',
      name: 'addShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `App Share`
  String get appShare {
    return Intl.message(
      'App Share',
      name: 'appShare',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get myAccount {
    return Intl.message(
      'My Account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get myAddresses {
    return Intl.message(
      'My Addresses',
      name: 'myAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Qatar`
  String get qatar {
    return Intl.message(
      'Qatar',
      name: 'qatar',
      desc: '',
      args: [],
    );
  }

  /// `Request Error`
  String get requestError {
    return Intl.message(
      'Request Error',
      name: 'requestError',
      desc: '',
      args: [],
    );
  }

  /// `Bad Request`
  String get badRequest {
    return Intl.message(
      'Bad Request',
      name: 'badRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unprocessable Entity`
  String get unprocessableEntity {
    return Intl.message(
      'Unprocessable Entity',
      name: 'unprocessableEntity',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server Error`
  String get internalServerError {
    return Intl.message(
      'Internal Server Error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Conflict Connection`
  String get conflictConnection {
    return Intl.message(
      'Conflict Connection',
      name: 'conflictConnection',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized`
  String get unauthorized {
    return Intl.message(
      'Unauthorized',
      name: 'unauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get notFound {
    return Intl.message(
      'Not Found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Deadline Exceeded`
  String get deadlineExceeded {
    return Intl.message(
      'Deadline Exceeded',
      name: 'deadlineExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Access Forbidden`
  String get accessForbidden {
    return Intl.message(
      'Access Forbidden',
      name: 'accessForbidden',
      desc: '',
      args: [],
    );
  }

  /// `Bad Certificate`
  String get badCertificate {
    return Intl.message(
      'Bad Certificate',
      name: 'badCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connectionError {
    return Intl.message(
      'Connection Error',
      name: 'connectionError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong! Please contact our customer support.`
  String get freiendlyErrorMessage {
    return Intl.message(
      'Something went wrong! Please contact our customer support.',
      name: 'freiendlyErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Order No.`
  String get orderNo {
    return Intl.message(
      'Order No.',
      name: 'orderNo',
      desc: '',
      args: [],
    );
  }

  /// `Order Date`
  String get orderDate {
    return Intl.message(
      'Order Date',
      name: 'orderDate',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Jahiz`
  String get appTitle {
    return Intl.message(
      'Jahiz',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `QAR`
  String get qar {
    return Intl.message(
      'QAR',
      name: 'qar',
      desc: '',
      args: [],
    );
  }

  /// `Zone number`
  String get zoneNumber {
    return Intl.message(
      'Zone number',
      name: 'zoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Should be number`
  String get shouldBeNumber {
    return Intl.message(
      'Should be number',
      name: 'shouldBeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications`
  String get noNotifications {
    return Intl.message(
      'No Notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Login or Register`
  String get loginOrRegister {
    return Intl.message(
      'Login or Register',
      name: 'loginOrRegister',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Zone`
  String get zone {
    return Intl.message(
      'Zone',
      name: 'zone',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get building {
    return Intl.message(
      'Building',
      name: 'building',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder Name`
  String get cardHolderName {
    return Intl.message(
      'Card Holder Name',
      name: 'cardHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiryDate {
    return Intl.message(
      'Expiry Date',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Security Code`
  String get securityCode {
    return Intl.message(
      'Security Code',
      name: 'securityCode',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Name On Card`
  String get nameOnCard {
    return Intl.message(
      'Name On Card',
      name: 'nameOnCard',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
