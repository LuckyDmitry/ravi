import 'package:flutter/cupertino.dart';

import '../../features/auth/presentation/auth_page.dart';
import '../../features/courses/presentation/courses_page.dart';
import '../../features/homepage/presentation/home_page.dart';
import '../../features/lesson/presentation/lesson_view.dart';

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
        _fadeRoute("${LessonView.screen}/$courceId", (context, _, __) => LessonView(courceId: courceId)),
            (route) => false
    );
  }
  static void navigateToAuth(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        _fadeRoute(AuthPage.screen, (context, _, __) => const AuthPage()),
        (route) => false
    );
  }

  static Route _fadeRoute(String name, Widget Function(BuildContext, Animation<double>, Animation<double>) builder) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name),
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