import "package:flutter/cupertino.dart";
import "package:ravi/src/service_locator.dart";
import "../../../common/auth/auth_service.dart";
import "../data/user_dto.dart";

class SignInUseCase extends ChangeNotifier {
  final AuthService authService = services<AuthService>();

  Future<UserDTO> signIn(String email, String password) async {
     await Future.delayed(const Duration(seconds: 1));
     authService.login(email);
     return UserDTO(email: email, password: password);
  }
}