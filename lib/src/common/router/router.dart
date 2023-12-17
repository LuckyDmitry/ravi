import 'package:flutter/cupertino.dart';
import '../../features/auth/presentation/auth_page.dart';
import '../../features/courses/presentation/courses_page.dart';
import '../../features/current_cource/presentation/current_cource_page.dart';
import '../../features/homepage/presentation/home_page.dart';

class FMRouters {
  static void navigateToCources(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        _fadeRoute(CoursesPage.screen, (context, _, __) => const CoursesPage()),
        (route) => false
    );
  }
  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        _fadeRoute(HomePage.screen, (context, _, __) => const HomePage()),
            (route) => false
    );
  }
  static void navigateToCource(BuildContext context, String courceId) {
    Navigator.of(context).pushAndRemoveUntil(
        _fadeRoute("${CurrentCourcePage.screen}/$courceId",  (context, _, __) => CurrentCourcePage(courceId: courceId)),
            (route) => false
    );
  }
  static void navigateToAuth(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        _fadeRoute(AuthPage.screen, (context, _, __) => const AuthPage()),
        (route) => false
    );
  }

  static Route _fadeRoute(String name, Widget Function(BuildContext, Animation<double>, Animation<double>) builder, {Object? args}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: args),
      pageBuilder: builder,
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}