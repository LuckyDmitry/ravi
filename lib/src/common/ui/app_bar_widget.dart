import 'package:flutter/material.dart';
import 'package:ravi/src/common/router/router.dart';
import 'package:ravi/src/service_locator.dart';

import '../auth/auth_service.dart';

/// Надо бы убедиться, что это FMAppBarWidget переиспользуется на экранах
class FMAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final AuthService _authService = services<AuthService>();
  final bool _hideLogin;
  FMAppBarWidget({Key? key, required bool hideLogin}) : _hideLogin = hideLogin, super(key: key);
  FMAppBarWidget.showLogin({Key? key}) : _hideLogin = false;
  FMAppBarWidget.hideLogin({Key? key}) : _hideLogin = true;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
  @override
  FMAppBarState createState() => FMAppBarState();
}

class FMAppBarState extends State<FMAppBarWidget> {
  String _loginStateTitle = _NOT_LOGGED_IN_STATE_TITLE;
  String _changeLoginStateButtonTitle = _LOGIN_BUTTON_TITLE;
  @override
  void initState() {
    widget._authService.addListener(_updateFields);
    _updateFields();
    super.initState();
  }

  @override
  void dispose() {
    widget._authService.removeListener(_updateFields);
    super.dispose();
  }

  void _updateFields() {
    setState(() {
      final loginState = widget._authService.loginState;
      if (loginState is LOGGED) {
        _loginStateTitle = loginState.email;
        _changeLoginStateButtonTitle = _LOGOUT_BUTTON_TITLE;
      } else {
        _loginStateTitle = _NOT_LOGGED_IN_STATE_TITLE;
        _changeLoginStateButtonTitle = _LOGIN_BUTTON_TITLE;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if (widget._hideLogin) {
      return AppBar(
          title: const Text("FirstMobileAcademy"),
      );
    } else {
    return AppBar(
      title: const Text("FirstMobileAcademy"),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(onPressed: () {
          FMRouters.navigateToHome(context);
        }, icon:  const Icon(Icons.home, color: Colors.black)),
        TextButton(onPressed: () {
          FMRouters.navigateToCources(context);
        }, child: const Text("Catalog")),
        Text(_loginStateTitle),
        TextButton(child: Text(_changeLoginStateButtonTitle), onPressed: () {
          if (widget._authService.loginState is LOGGED) {
            widget._authService.logout();
          } 
          FMRouters.navigateToAuth(context);
          setState(() {});
        })
      ],
    );
    }
  }

  static const String _NOT_LOGGED_IN_STATE_TITLE = "You are not logged in";
  static const String _LOGIN_BUTTON_TITLE = "LogIn";
  static const String _LOGOUT_BUTTON_TITLE = "LogOut";
}