import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? displayName;
  UserModel({
    this.id,
    this.email,
    this.displayName,
  });
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  LoginState get loginState {
    if (_firebaseAuth.currentUser?.email != null) {
      return LOGGED(_firebaseAuth.currentUser!.email!);
    } else {
      return UNKNOWN();
    }
  }

  Future<void> login(String email, String password) async {
    final credential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> logout() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    
    notifyListeners();
  }
}

abstract class LoginState {}

class LOGGED implements LoginState {
  String email;
  LOGGED(this.email);
}

class UNKNOWN implements LoginState {}
