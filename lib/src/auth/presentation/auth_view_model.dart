import "package:flutter/material.dart";
import "package:ravi/src/auth/domain/sign_in_usecase.dart";


class AuthViewModel extends ChangeNotifier {
  final SignInUseCase signInUseCase;

  AuthViewModel(this.signInUseCase);

  String? errorMessage;

  Future<void> signIn(String email, String password) async {
    try {
      await signInUseCase.execute(email, password);
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
