import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ravi/src/auth/auth_service.dart';
import 'package:ravi/src/auth/presentation/auth_widget.dart';
import 'package:ravi/src/courses/presentation/courses_view.dart';
import 'package:ravi/src/lesson/domain/lesson_use_case.dart';
import 'package:ravi/src/lesson/presentation/lesson_view.dart';
import 'package:ravi/src/lesson/presentation/lesson_view_model.dart';
import 'package:ravi/src/service_locator.dart';

import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          initialRoute: "/",
          onGenerateRoute: (RouteSettings routeSettings) {
            
            final authService = services<AuthService>();
            if (!authService.isLoggedIn) {
              return MaterialPageRoute<dynamic>(
                settings: routeSettings,
                builder: (context) => AuthView(),
              );
            }
            Uri uri = Uri.parse(routeSettings.name ?? "");

            if (uri.pathSegments.length == 1 &&
                uri.pathSegments[0] == "courses") {
              return MaterialPageRoute<dynamic>(
                settings: routeSettings,
                builder: (context) => Scaffold(
                  appBar: AppBar(title: Text("Course"), automaticallyImplyLeading: false),
                  body:  WillPopScope(child: CoursesView(), onWillPop: () async => Future.value(false))),
              );
            } else if (uri.pathSegments.length == 2 && uri.pathSegments[0] == "lesson") { 
              return MaterialPageRoute<dynamic>(
                settings: routeSettings,
                builder: (context) => Scaffold(
                  body: LessonView(viewModel: LessonViewModel(LessonUseCase(courseId: uri.pathSegments[1]))),
                   appBar: AppBar(title: Text("Lesson"))
                   ),
              );
            }

            return MaterialPageRoute<dynamic>(
                  settings: routeSettings,
                  builder: (context) => const SampleItemListView(),
                );
          },
        );
      },
    );
  }
}
