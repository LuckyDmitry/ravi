
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  LoginState _loginState = UNKNOWN();
  LoginState get loginState => _loginState;

  void login(String email) {
    _loginState = LOGGED(email);
    notifyListeners();
  }

  void logout() {
    _loginState = UNKNOWN();
    notifyListeners();
  }
}

abstract class LoginState {}
class LOGGED implements LoginState {
  String email;
  LOGGED(this.email);
}
class UNKNOWN implements LoginState {}