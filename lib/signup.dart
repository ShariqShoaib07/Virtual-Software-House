//signup.dart
import 'package:flutter/material.dart';
import 'login.dart';
import 'custom_input.dart';
import 'social_buttons.dart';

enum UserType { Developer, Client }

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool agreeToTerms = false;
  UserType? selectedUserType;

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
                        SizedBox(height: 40),
                        Text(
                          'Create\nAccount',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Join us to get started',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomInput(
                          controller: username,
                          hintText: "Username",
                        ),
                        SizedBox(height: 15),
                        CustomInput(
                          controller: email,
                          hintText: "Email",
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
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Checkbox(
                              value: agreeToTerms,
                              onChanged: (val) {
                                setState(() {
                                  agreeToTerms = val ?? false;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              activeColor: Color(0xFF38E54D),
                            ),
                            Expanded(
                              child: Text(
                                "I agree to terms and conditions",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          "I am a:",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ChoiceChip(
                                label: Text("DEVELOPER"),
                                selected: selectedUserType == UserType.Developer,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedUserType = selected ? UserType.Developer : null;
                                  });
                                },
                                selectedColor: Color(0xFF38E54D),
                                backgroundColor: Colors.grey.shade200,
                                labelStyle: TextStyle(
                                  color: selectedUserType == UserType.Developer
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ChoiceChip(
                                label: Text("CLIENT"),
                                selected: selectedUserType == UserType.Client,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedUserType = selected ? UserType.Client : null;
                                  });
                                },
                                selectedColor: Color(0xFF38E54D),
                                backgroundColor: Colors.grey.shade200,
                                labelStyle: TextStyle(
                                  color: selectedUserType == UserType.Client
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: agreeToTerms && selectedUserType != null
                              ? () {
                            if (username.text.isEmpty ||
                                email.text.isEmpty ||
                                password.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please complete all fields."),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                              return;
                            }

                            if (password.text.length < 8) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Password must be at least 8 characters."),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                              return;
                            }

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginPage()),
                            );
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: agreeToTerms && selectedUserType != null
                                ? buttonColor
                                : Colors.grey,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            minimumSize: Size(double.infinity, 0),
                            elevation: 0,
                          ),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
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
                        SizedBox(height: 25),
                        SocialButtons(),
                        SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(color: Colors.grey.shade600),
                                children: [
                                  TextSpan(
                                    text: "Login",
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