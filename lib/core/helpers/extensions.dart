import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension BuildContextExtension<T> on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.of(this).size.width;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  double get bottomViewPadding => MediaQuery.of(this).viewPadding.bottom;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ScaffoldMessengerState get scaffoldMassenger => ScaffoldMessenger.of(this);

  Size get screenSize => MediaQuery.of(this).size;

  T? get argument => ModalRoute.of(this)?.settings.arguments as T?;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension AssetExtension on String {
  String get pngIcon => "assets/icons/$this.png";

  String get pngImage => "assets/images/$this.png";

  String get devImage => "assets/dev/$this.png";

  String get lottie => 'assets/lottie/$this.json';

  String get svg => "assets/svg/$this.svg";

  String get jpgImage => "assets/images/$this.jpg";
}
