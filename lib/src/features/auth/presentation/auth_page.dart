import 'package:flutter/material.dart';
import '../../../common/router/router.dart';
import '../../../common/ui/app_bar_widget.dart';
import '../domain/sign_in_usecase.dart';

class AuthPage extends StatefulWidget {
  static const String screen = "/signin";
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SignInUseCase signInUseCase = SignInUseCase();

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

    return Scaffold(
      appBar: FMAppBarWidget.hideLogin(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10), // Spacing between fields
              SizedBox(
                height: 300, // Set the fixed height for the container
                child: Column(
                  children: <Widget>[
                    // Add your widgets here. They will share the height of the container.
                    SizedBox(
                      width: 300,
                      child: PrimaryTextField(
                          controller: emailController,
                          labelText: "Email",
                          onChanged: (value) { setState(() {});}),
                    ),

                    SizedBox(
                      width: 300,
                      child: PrimaryTextField(
                          controller: passwordController,
                          labelText: "Password",
                          onChanged: (value) { setState(() {}); }),
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                      onPressed: isButtonEnabled ? () {
                        signInUseCase.signIn(emailController.text, passwordController.text)
                            .then((value) => {
                            /// Здесь навигация должна вести не на хоум, а назад
                            FMRouters.navigateToHome(context)
                        });
                      } : null,
                      child: const Text('Sign In'),
                    )),
                    // ... Add more widgets as needed
                  ],
                ),
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

  const PrimaryTextField({super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0), // Rounded borders
        ),
      ),
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
