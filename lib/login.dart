import 'package:flutter/material.dart';
import 'bottom_nav_c.dart';
import 'signup.dart';
import 'custom_input.dart';
import 'social_buttons.dart';
import 'reset_password.dart';
import 'bottom_nav_a.dart';
import 'bottom_nav.dart';
import 'package:flutter/animation.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  static const Color buttonColor = Color(0xFF38E54D);
  static const Color primaryGreen = Color(0xFF38E54D);

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
                      stops: [0.1, 0.5],
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/auth_bg.png'), // Add your own background image
                      fit: BoxFit.cover,
                      opacity: 0.05,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 500),
                          builder: (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Hello Again ',
                                          style: TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                            color: primaryGreen,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 2,
                                                color: Colors.black12,
                                                offset: Offset(1, 1),
                                              )
                                            ],
                                          ),
                                        ),
                                        TweenAnimationBuilder(
                                          tween: Tween<double>(begin: 0, end: 1),
                                          duration: Duration(milliseconds: 800),
                                          curve: Curves.elasticOut,
                                          builder: (BuildContext context, double value, Widget? child) {
                                            return Transform.scale(
                                              scale: value,
                                              child: Text(
                                                '👋',
                                                style: TextStyle(fontSize: 32),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Ready to continue your journey?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 40),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          builder: (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset((1 - value) * 20, 0),
                                child: child,
                              ),
                            );
                          },
                          child: CustomInput(
                            controller: username,
                            hintText: "Username or Email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 15),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                          builder: (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset((1 - value) * 20, 0),
                                child: child,
                              ),
                            );
                          },
                          child: CustomInput(
                            controller: password,
                            hintText: "Password",
                            obscureText: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility_off, color: Colors.grey.shade400),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 800),
                          builder: (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: child,
                            );
                          },
                          child: Align(
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
                        ),
                        SizedBox(height: 20),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 900),
                          builder: (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.scale(
                                scale: value,
                                child: child,
                              ),
                            );
                          },
                          child: ElevatedButton(
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
                              elevation: 2,
                              shadowColor: primaryGreen.withOpacity(0.3),
                            ),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 1000),
                          builder: (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: child,
                            );
                          },
                          child: Row(
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
                        ),
                        SizedBox(height: 30),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 1100),
                          builder: (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: child,
                            );
                          },
                          child: SocialButtons(),
                        ),
                        SizedBox(height: 20),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 1200),
                          builder: (BuildContext context, double value, Widget? child) {
                            return Opacity(
                              opacity: value,
                              child: child,
                            );
                          },
                          child: Center(
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
                                        color: primaryGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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