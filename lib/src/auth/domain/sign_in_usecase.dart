import "package:ravi/src/auth/auth_service.dart";
import "package:ravi/src/auth/data/user_dto.dart";
import "package:ravi/src/service_locator.dart";

class SignInUseCase {
  final AuthService authService = services<AuthService>();

  Future<UserDTO> execute(String email, String password) async {
     await Future.delayed(const Duration(seconds: 1));
     authService.isLoggedIn = true;
     return UserDTO(email: "myEmail@gmail.com", password: "1234");
  }
}