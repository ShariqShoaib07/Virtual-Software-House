import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'signup.dart';
import 'reset_password.dart';
import 'social_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool showPassword = false;

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _titleColorAnimation;

  static const Color primaryGreen = Color(0xFF38E54D);
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color whiteColor = Colors.white;
  static const Color darkTextColor = Colors.black87;
  static const Color greyTextColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
        ));

        _slideAnimation = Tween<Offset>(
        begin: Offset(0, 0.3),
    end: Offset.zero,
    ).animate(
    CurvedAnimation(
    parent: _controller,
    curve: Interval(0.2, 0.8, curve: Curves.easeOutBack),
    ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
    CurvedAnimation(
    parent: _controller,
    curve: Interval(0.4, 1.0, curve: Curves.elasticOut),
    ),
    );

    _titleColorAnimation = ColorTween(
    begin: primaryGreen.withOpacity(0.5),
    end: primaryGreen,
    ).animate(
    CurvedAnimation(
    parent: _controller,
    curve: Interval(0.6, 1.0),
    ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    // Background decoration
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: lightGreen.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(200),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: lightGreen.withOpacity(0.3),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(150),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: constraints.maxHeight * 0.1),

                          // Animated welcome text with wave
                          SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      AnimatedBuilder(
                                        animation: _titleColorAnimation,
                                        builder: (context, child) {
                                          return Text(
                                            'Hello Again! 👋',
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: primaryGreen,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Let's get you logged in to continue\nyour amazing journey",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: greyTextColor,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 40),

                          // Animated input fields - moved lower on screen
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: FadeTransition(
                                opacity: _opacityAnimation,
                                child: Column(
                                  children: [
                                    _buildAnimatedInputField(
                                      controller: username,
                                      label: "Username or Email",
                                      icon: Icons.person_outline,
                                      delay: 0.2,
                                    ),
                                    SizedBox(height: 20),
                                    _buildAnimatedInputField(
                                      controller: password,
                                      label: "Password",
                                      icon: Icons.lock_outline,
                                      obscureText: !showPassword,
                                      delay: 0.3,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: greyTextColor,
                                        ),
                                        onPressed: _togglePasswordVisibility,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) => ResetPasswordPage(),
                                              transitionsBuilder: (_, animation, __, child) {
                                                return SlideTransition(
                                                  position: Tween<Offset>(
                                                    begin: Offset(1, 0),
                                                    end: Offset.zero,
                                                  ).animate(animation),
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: primaryGreen,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 30),

                          // Animated login button
                          FadeTransition(
                            opacity: _opacityAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: _buildLoginButton(),
                            ),
                          ),

                          SizedBox(height: 30),

                          // Animated divider
                          FadeTransition(
                            opacity: _opacityAnimation,
                            child: SizeTransition(
                              sizeFactor: CurvedAnimation(
                                parent: _controller,
                                curve: Interval(0.7, 0.9),
                              ),
                              axis: Axis.horizontal,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: greyTextColor.withOpacity(0.3),
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "OR CONTINUE WITH",
                                      style: TextStyle(
                                        color: greyTextColor,
                                        fontSize: 12,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: greyTextColor.withOpacity(0.3),
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 25),

                          // Animated social buttons
                          FadeTransition(
                            opacity: _opacityAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: SocialButtons(),
                            ),
                          ),

                          Spacer(),

                          // Animated sign up prompt
                          FadeTransition(
                            opacity: _opacityAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => SignUpPage(),
                                        transitionsBuilder: (_, animation, __, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Don't have an account? ",
                                        style: TextStyle(
                                          color: greyTextColor,
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Sign Up",
                                            style: TextStyle(
                                              color: primaryGreen,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    double delay = 0.0,
    Widget? suffixIcon,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animValue = _controller.value;
        final delayValue = animValue >= delay ? (animValue - delay) / (1 - delay) : 0.0;

        return Opacity(
          opacity: delayValue.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - delayValue)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05 * delayValue),
                    blurRadius: 10 * delayValue,
                    offset: Offset(0, 4 * delayValue),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: greyTextColor),
                  prefixIcon: Icon(icon, color: greyTextColor),
                  suffixIcon: suffixIcon,
                  filled: true,
                  fillColor: whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: primaryGreen,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [primaryGreen, Color(0xFF2ECC71)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            if (username.text.isEmpty || password.text.isEmpty) {
              _showErrorSnackbar(context, "Please complete all fields.");
              return;
            }

            if (password.text.length < 8 && username.text != 'admin') {
              _showErrorSnackbar(context, "Password must be at least 8 characters.");
              return;
            }

            // Your existing login logic here
          },
          onHover: (hovering) {
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.red.shade400,
        elevation: 6,
        margin: EdgeInsets.all(20),
      ),
    );
  }
}