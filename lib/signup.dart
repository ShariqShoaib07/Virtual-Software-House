import 'package:flutter/material.dart';
import 'login.dart';
import 'social_buttons.dart';
import 'package:flutter/animation.dart';

enum UserType { Developer, Client }

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool agreeToTerms = false;
  bool showPassword = false;
  UserType? selectedUserType;
  static const Color primaryColor = Color(0xFF38E54D);
  static const Color secondaryColor = Colors.greenAccent;

  Animation<double> _opacityAnimation = AlwaysStoppedAnimation(1.0);
  Animation<Offset> _slideAnimation = AlwaysStoppedAnimation(Offset.zero);
  Animation<double> _scaleAnimation = AlwaysStoppedAnimation(1.0);
  Animation<Color?> _gradientAnimation = AlwaysStoppedAnimation(Colors.transparent);

  // Declare controller as late since we'll initialize it in initState
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    // Set up animations using the controller
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

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

    _gradientAnimation = ColorTween(
      begin: primaryColor.withOpacity(0.5),
      end: primaryColor,
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
                        Color(0xFFF0FFF4),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.05),

                        // Animated title with gradient
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedBuilder(
                                  animation: _gradientAnimation,
                                  builder: (context, child) {
                                    return ShaderMask(
                                      shaderCallback: (bounds) {
                                        return LinearGradient(
                                          colors: [
                                            primaryColor,
                                            secondaryColor,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds);
                                      },
                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Join our community today',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // Animated form fields with floating labels
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: Column(
                                children: [
                                  AnimatedInputField(
                                    controller: username,
                                    label: "Username",
                                    icon: Icons.person_outline,
                                    animation: _controller,
                                    delay: 0.2,
                                  ),
                                  SizedBox(height: 20),
                                  AnimatedInputField(
                                    controller: email,
                                    label: "Email",
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    animation: _controller,
                                    delay: 0.3,
                                  ),
                                  SizedBox(height: 20),
                                  AnimatedInputField(
                                    controller: password,
                                    label: "Password",
                                    icon: Icons.lock_outline,
                                    obscureText: !showPassword,
                                    animation: _controller,
                                    delay: 0.4,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey.shade500,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Animated terms checkbox with bounce effect
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              transform: Matrix4.identity()
                                ..scale(agreeToTerms ? 1.02 : 1.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    agreeToTerms = !agreeToTerms;
                                  });
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          color: agreeToTerms
                                              ? primaryColor
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: agreeToTerms
                                                ? primaryColor
                                                : Colors.grey.shade400,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: AnimatedSwitcher(
                                            duration:
                                            Duration(milliseconds: 200),
                                            transitionBuilder:
                                                (Widget child,
                                                Animation<double> animation) {
                                              return ScaleTransition(
                                                scale: animation,
                                                child: child,
                                              );
                                            },
                                            child: agreeToTerms
                                                ? Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                                : SizedBox.shrink(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          "I agree to terms and conditions",
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 25),

                        // Animated user type selection with ripple effect
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "I am a:",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AnimatedUserTypeCard(
                                        label: "DEVELOPER",
                                        icon: Icons.code,
                                        selected:
                                        selectedUserType == UserType.Developer,
                                        animation: _controller,
                                        delay: 0.5,
                                        onTap: () {
                                          setState(() {
                                            selectedUserType = UserType.Developer;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: AnimatedUserTypeCard(
                                        label: "CLIENT",
                                        icon: Icons.business_center,
                                        selected:
                                        selectedUserType == UserType.Client,
                                        animation: _controller,
                                        delay: 0.6,
                                        onTap: () {
                                          setState(() {
                                            selectedUserType = UserType.Client;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // Animated sign up button with pulse effect
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: AnimatedButton(
                              animation: _controller,
                              delay: 0.7,
                              enabled: agreeToTerms && selectedUserType != null,
                              onPressed: () {
                                if (username.text.isEmpty ||
                                    email.text.isEmpty ||
                                    password.text.isEmpty) {
                                  _showErrorSnackbar(
                                      context, "Please complete all fields.");
                                  return;
                                }

                                if (password.text.length < 8) {
                                  _showErrorSnackbar(context,
                                      "Password must be at least 8 characters.");
                                  return;
                                }

                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) =>
                                        LoginPage(),
                                    transitionsBuilder:
                                        (context, animation, secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // Animated divider with growing effect
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: SizeTransition(
                            sizeFactor: CurvedAnimation(
                              parent: _controller,
                              curve: Interval(0.7, 0.9),
                            ),
                            axis: Axis.horizontal,
                            child: Center(
                              child: Text(
                                "OR CONTINUE WITH",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 25),

                        // Animated social buttons with staggered animation
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: SocialButtons(),
                          ),
                        ),

                        Spacer(),

                        // Animated login prompt with subtle bounce
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
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                          LoginPage(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: Offset(0, 0.5),
                                            end: Offset.zero,
                                          ).animate(animation),
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
                                      text: "Already have an account? ",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Login",
                                          style: TextStyle(
                                            color: primaryColor,
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
                ),
              ),
            ),
          );
        },
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

class AnimatedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Animation<double> animation;
  final double delay;

  const AnimatedInputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    required this.animation,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final animValue = animation.value;
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
                keyboardType: keyboardType,
                obscureText: obscureText,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  prefixIcon: Icon(
                    icon,
                    color: Colors.grey.shade500,
                  ),
                  suffixIcon: suffixIcon,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _SignUpPageState.primaryColor,
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
}

class AnimatedUserTypeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Animation<double> animation;
  final double delay;

  const AnimatedUserTypeCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.animation,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final animValue = animation.value;
        final delayValue = animValue >= delay ? (animValue - delay) / (1 - delay) : 0.0;

        return GestureDetector(
          onTap: onTap,
          child: Opacity(
            opacity: delayValue.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - delayValue)),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selected
                      ? _SignUpPageState.primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected
                        ? _SignUpPageState.primaryColor
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    if (selected)
                      BoxShadow(
                        color: _SignUpPageState.primaryColor.withOpacity(0.2 * delayValue),
                        blurRadius: 10 * delayValue,
                        spreadRadius: 1 * delayValue,
                      ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 32,
                      color: selected
                          ? _SignUpPageState.primaryColor
                          : Colors.grey.shade600,
                    ),
                    SizedBox(height: 8),
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected
                            ? _SignUpPageState.primaryColor
                            : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final VoidCallback? onPressed;
  final Animation<double> animation;
  final double delay;

  const AnimatedButton({
    required this.child,
    required this.enabled,
    required this.onPressed,
    required this.animation,
    required this.delay,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.02).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        final animValue = widget.animation.value;
        final delayValue = animValue >= widget.delay
            ? (animValue - widget.delay) / (1 - widget.delay)
            : 0.0;

        return Opacity(
          opacity: delayValue.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - delayValue)),
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: widget.enabled
                      ? _pulseAnimation.value
                      : 1.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: widget.enabled ? 4 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: widget.enabled
                            ? LinearGradient(
                          colors: [
                            _SignUpPageState.primaryColor,
                            _SignUpPageState.secondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : LinearGradient(
                          colors: [
                            Colors.grey.shade400,
                            Colors.grey.shade500,
                          ],
                        ),
                        boxShadow: widget.enabled
                            ? [
                          BoxShadow(
                            color: _SignUpPageState.primaryColor
                                .withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ]
                            : [],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: widget.enabled ? widget.onPressed : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            alignment: Alignment.center,
                            child: widget.child,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}