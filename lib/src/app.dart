import 'package:flutter/material.dart';
import 'features/homepage/presentation/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FirstMobileApp",
      themeMode: ThemeMode.light,
      home: HomePage(),
    );
  }
}
