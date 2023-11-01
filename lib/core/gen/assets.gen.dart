/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Qatar_flag.png
  AssetGenImage get qatarFlag =>
      const AssetGenImage('assets/images/Qatar_flag.png');

  /// File path: assets/images/addresses_icon.svg
  SvgGenImage get addressesIcon =>
      const SvgGenImage('assets/images/addresses_icon.svg');

  /// File path: assets/images/bag_icon.svg
  SvgGenImage get bagIcon => const SvgGenImage('assets/images/bag_icon.svg');

  /// File path: assets/images/building_icon.svg
  SvgGenImage get buildingIcon =>
      const SvgGenImage('assets/images/building_icon.svg');

  /// File path: assets/images/cart_icon.svg
  SvgGenImage get cartIcon => const SvgGenImage('assets/images/cart_icon.svg');

  /// File path: assets/images/categories_icon.svg
  SvgGenImage get categoriesIcon =>
      const SvgGenImage('assets/images/categories_icon.svg');

  /// File path: assets/images/contact_us_icon.png
  AssetGenImage get contactUsIcon =>
      const AssetGenImage('assets/images/contact_us_icon.png');

  /// File path: assets/images/coupon_icon.svg
  SvgGenImage get couponIcon =>
      const SvgGenImage('assets/images/coupon_icon.svg');

  /// File path: assets/images/delete_icon.svg
  SvgGenImage get deleteIcon =>
      const SvgGenImage('assets/images/delete_icon.svg');

  /// File path: assets/images/edit_icon.svg
  SvgGenImage get editIcon => const SvgGenImage('assets/images/edit_icon.svg');

  /// File path: assets/images/edit_profile_icon.svg
  SvgGenImage get editProfileIcon =>
      const SvgGenImage('assets/images/edit_profile_icon.svg');

  /// File path: assets/images/favorite.png
  AssetGenImage get favorite =>
      const AssetGenImage('assets/images/favorite.png');

  /// File path: assets/images/folder_icon.svg
  SvgGenImage get folderIcon =>
      const SvgGenImage('assets/images/folder_icon.svg');

  /// File path: assets/images/home_icon.svg
  SvgGenImage get homeIcon => const SvgGenImage('assets/images/home_icon.svg');

  /// File path: assets/images/jahez_logo.png
  AssetGenImage get jahezLogo =>
      const AssetGenImage('assets/images/jahez_logo.png');

  /// File path: assets/images/location_icon.svg
  SvgGenImage get locationIcon =>
      const SvgGenImage('assets/images/location_icon.svg');

  /// File path: assets/images/logout_icon.svg
  SvgGenImage get logoutIcon =>
      const SvgGenImage('assets/images/logout_icon.svg');

  /// File path: assets/images/notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/images/notification.svg');

  /// File path: assets/images/outlined_home_icon.svg
  SvgGenImage get outlinedHomeIcon =>
      const SvgGenImage('assets/images/outlined_home_icon.svg');

  /// File path: assets/images/profile_icon.svg
  SvgGenImage get profileIcon =>
      const SvgGenImage('assets/images/profile_icon.svg');

  /// File path: assets/images/search.svg
  SvgGenImage get search => const SvgGenImage('assets/images/search.svg');

  /// File path: assets/images/share.svg
  SvgGenImage get share => const SvgGenImage('assets/images/share.svg');

  /// File path: assets/images/share_app_icon.svg
  SvgGenImage get shareAppIcon =>
      const SvgGenImage('assets/images/share_app_icon.svg');

  /// List of all assets
  List<dynamic> get values => [
        qatarFlag,
        addressesIcon,
        bagIcon,
        buildingIcon,
        cartIcon,
        categoriesIcon,
        contactUsIcon,
        couponIcon,
        deleteIcon,
        editIcon,
        editProfileIcon,
        favorite,
        folderIcon,
        homeIcon,
        jahezLogo,
        locationIcon,
        logoutIcon,
        notification,
        outlinedHomeIcon,
        profileIcon,
        search,
        share,
        shareAppIcon
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
