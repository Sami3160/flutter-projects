import 'package:flutter/cupertino.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobileWidget;
  final Widget desktopWidget;
  final Widget? tabletWidget;

  const ResponsiveWidget({
    super.key,
    required this.mobileWidget,
    required this.desktopWidget,
    this.tabletWidget,
  });
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width <= 940;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1200;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) return mobileWidget;
    if (isTablet(context)) return tabletWidget ?? mobileWidget;
    return desktopWidget;
  }
}
