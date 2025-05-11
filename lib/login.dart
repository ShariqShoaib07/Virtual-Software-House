//login.dart
import 'package:flutter/material.dart';
import 'bottom_nav_c.dart';
import 'signup.dart';
import 'custom_input.dart';
import 'social_buttons.dart';
import 'reset_password.dart';
import 'bottom_nav_a.dart';
import 'bottom_nav.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  static const Color buttonColor = Color(0xFF38E54D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFEFFFF2),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        Text(
                          'Welcome\nBack',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Sign in to continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 40),
                        CustomInput(
                          controller: username,
                          hintText: "Username or Email",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 15),
                        CustomInput(
                          controller: password,
                          hintText: "Password",
                          obscureText: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility_off, color: Colors.grey.shade400),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => ResetPasswordPage()),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (username.text.isEmpty || password.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please complete all fields."),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                              return;
                            }

                            if (password.text.length < 8 && username.text != 'admin') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Password must be at least 8 characters."),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                              return;
                            }

                            if (username.text == 'admin' && password.text == 'sixtynine') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => BottomNav_A()),
                              );
                            } else if (username.text == 'developer' && password.text == 'sixtynine') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => BottomNav()),
                              );
                            } else if (username.text == 'client' && password.text == 'sixtynine') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => BottomNav_c()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            minimumSize: Size(double.infinity, 0),
                            elevation: 0,
                          ),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        SocialButtons(),
                        SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => SignUpPage()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: Colors.grey.shade600),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: Color(0xFF38E54D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}