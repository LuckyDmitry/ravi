import 'package:flutter/material.dart';

import '../../../common/router/router.dart';
import '../../../common/ui/app_bar_widget.dart';


class HomePage extends StatelessWidget {
  static const String screen = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FMAppBarWidget.showLogin(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/png/homepage_welcome_logo.png'),
              height: 300.0,
              width: 300.0,
            ),
            const Text(
                "Welcome!",
                style: TextStyle(fontSize: 30, color: Colors.white70)
            ),
            TextButton(
                child: const Text(
                    "Catalog",
                    style: TextStyle(fontSize: 28,)
                ),
                onPressed: () {
                  FMRouters.navigateToCources(context);
            })
          ],
        ),
      ),
    );
  }
}