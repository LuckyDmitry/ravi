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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(34, 34, 34, 1)
      ),
      home: HomePage(),
    );
  }
}
