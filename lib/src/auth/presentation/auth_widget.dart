import 'package:flutter/material.dart';
import 'package:ravi/src/auth/auth_service.dart';
import 'package:ravi/src/auth/domain/sign_in_usecase.dart';
import 'package:ravi/src/auth/presentation/auth_view_model.dart';
import 'package:ravi/src/courses/presentation/courses_view.dart';
import 'package:ravi/src/service_locator.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthViewModel viewModel = AuthViewModel(SignInUseCase());

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10), // Spacing between fields
              Container(
                height: 300, // Set the fixed height for the container
                child: Column(
                  children: <Widget>[
                    // Add your widgets here. They will share the height of the container.
                    Container(
                      width: 300,
                      child: PrimaryTextField(
                          controller: emailController,
                          labelText: "Email",
                          onChanged: (value) { setState(() {});}),
                    ),

                    Container(
                      width: 300,
                      child: PrimaryTextField(
                          controller: passwordController,
                          labelText: "Password",
                          onChanged: (value) { setState(() {}); }),
                    ),
                    Container(
                      width: 300,
                      child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () async {
                              await viewModel.signIn(emailController.text, passwordController.text);
                              Navigator.of(context).popAndPushNamed(CoursesView.screen);
                            }
                          : null,
                      child: Text('Sign In'),
                    )),
                    // ... Add more widgets as needed
                  ],
                ),
              ),
              if (viewModel.errorMessage != null)
                Text(
                  viewModel.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Function(String) onChanged;

  PrimaryTextField({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded borders
          ),
        ),
        obscureText: obscureText,
        onChanged: onChanged,
      ),
    );
  }
}
