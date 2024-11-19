import 'package:flutter/material.dart';

class AppAssets {
  static const String _icons = 'assets';
  static const String _paymentCard = 'assets/payment_card';

  static final Map<String, String> _paths = {
    // Icons
    'google_logo': '$_icons/google_logo.png',
    'facebook_logo': '$_icons/facebook_logo.png',
    'dhl': '$_icons/dhl.png',
    'fedex': '$_icons/fedex.png',
    'usps': '$_icons/usps.png',

    ///card
    'mastercard': '$_paymentCard/mastercard.png',
    'mastercard_white': '$_paymentCard/mastercard_white.png',
    'visa': '$_paymentCard/visa.png',
    'visa_white': '$_paymentCard/visa_white.png',
    'american_express': '$_paymentCard/american_express.png',
    'dinners_club': '$_paymentCard/dinners_club.png',
    'discover': '$_paymentCard/discover.png',
    'jcb': '$_paymentCard/jcb.png',
    'verve': '$_paymentCard/verve.png',

    'helper_icon': '$_paymentCard/help_outline.png',
    'chip_icon': '$_paymentCard/chip.png',

    'success_icon': '$_icons/success_icon.png',

    /// Error
    'error_icon': '$_icons/error_icon.png',
  };

  /// Error
  static Image errorIcon({required double width, required double height}) =>
      Image.asset(_paths['error_icon']!, width: width, height: height);

  /// images
  static AssetImage successBgImage() => AssetImage(_paths['success']!);

  /// card
  static Image mastercard({required double width, required double height}) =>
      Image.asset(_paths['mastercard']!, width: width, height: height);
  static Image mastercardWhite(
          {required double width, required double height}) =>
      Image.asset(_paths['mastercard_white']!, width: width, height: height);
  static Image visa({required double width, required double height}) =>
      Image.asset(_paths['visa']!, width: width, height: height);
  static Image visaWhite({required double width, required double height}) =>
      Image.asset(_paths['visa_white']!, width: width, height: height);
  static Image americanExpress(
          {required double width, required double height}) =>
      Image.asset(_paths['american_express']!, width: width, height: height);
  static Image dinnersClub({required double width, required double height}) =>
      Image.asset(_paths['dinners_club']!, width: width, height: height);
  static Image discover({required double width, required double height}) =>
      Image.asset(_paths['discover']!, width: width, height: height);
  static Image jcb({required double width, required double height}) =>
      Image.asset(_paths['jcb']!, width: width, height: height);
  static Image verve({required double width, required double height}) =>
      Image.asset(_paths['verve']!, width: width, height: height);

  static Image helperIcon({required double width, required double height}) =>
      Image.asset(_paths['helper_icon']!, width: width, height: height);
  static Image chipIcon({required double width, required double height}) =>
      Image.asset(_paths['chip_icon']!, width: width, height: height);

  static Image dhl({required double width, required double height}) =>
      Image.asset(_paths['dhl']!, width: width, height: height);
  static Image fedex({required double width, required double height}) =>
      Image.asset(_paths['fedex']!, width: width, height: height);
  static Image usps({required double width, required double height}) =>
      Image.asset(_paths['usps']!, width: width, height: height);

  static Image successIcon({required double width, required double height}) =>
      Image.asset(_paths['success_icon']!, width: width, height: height);

  static Image googleLogo({double? width, double? height}) =>
      Image.asset(_paths['google_logo']!, width: width, height: height);
  static Image facebookLogo({double? width, double? height}) =>
      Image.asset(_paths['facebook_logo']!, width: width, height: height);
  static Image arrowRight({required double width, required double height}) =>
      Image.asset(_paths['arrow_right']!, width: width, height: height);
  static Image chevronBack({required double width, required double height}) =>
      Image.asset(_paths['chevron_back']!, width: width, height: height);

  static Image emptyCart({required double width, required double height}) =>
      Image.asset(_paths['empty_cart']!, width: width, height: height);

  static AssetImage emptyCart2() => AssetImage(_paths['empty_cart']!);
}
