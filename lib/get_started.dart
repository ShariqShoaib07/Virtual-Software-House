import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';
import 'package:flutter/animation.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> with SingleTickerProviderStateMixin {
  static const Color buttonColor = Color(0xFF38E54D);
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.8, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
      // Animated background
      AnimatedContainer(
      duration: Duration(seconds: 1),
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
    ),

    // Floating animated circles
    Positioned(
    top: -50,
    right: -50,
    child: Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Color(0xFF38E54D).withOpacity(0.1),
    ),
    ),
    ),

    Positioned(
      bottom: -100,
      left: -50,
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF38E54D).withOpacity(0.05),
        ),
      ),
    ),

    // Main content
    Positioned.fill(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    // Animated logo
    ScaleTransition(
    scale: _scaleAnimation,
    child: FadeTransition(
    opacity: _opacityAnimation,
    child: Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
    color: Color(0xFF38E54D).withOpacity(0.2),
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
    BoxShadow(
    color: Color(0xFF38E54D).withOpacity(0.1),
    blurRadius: 20,
    spreadRadius: 5,
    ),
    ],
    ),
    child: Icon(
    Icons.rocket_launch,
    size: 60,
    color: Color(0xFF38E54D),
    ),
    ),
    ),
    ),

    SizedBox(height: 40),

    // Animated title
    SlideTransition(
    position: _slideAnimation,
    child: FadeTransition(
    opacity: _opacityAnimation,
    child: Column(
    children: [
    Text(
    'Elevate Your',
    style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    height: 1.2,
    ),
    ),
    Text(
    'Collaboration',
    style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFF38E54D),
    height: 1.2,
    ),
    ),
    ],
    ),
    ),
    ),

    SizedBox(height: 15),

    // Animated subtitle
    SlideTransition(
    position: _slideAnimation,
    child: FadeTransition(
    opacity: _opacityAnimation,
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 40),
    child: Text(
    'Connect, create and grow with the ultimate platform for developers and clients',
    textAlign: TextAlign.center,
    style: TextStyle(
    fontSize: 16,
    color: Colors.grey.shade600,
    ),
    ),
    ),
    ),
    ),
    ],
    ),
    ),

    // Bottom buttons
    Positioned(
    bottom: 60,
    left: 0,
    right: 0,
    child: SlideTransition(
    position: _slideAnimation,
    child: FadeTransition(
    opacity: _opacityAnimation,
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 24),
    child: Column(
    children: [
    // Get started button with pulse animation
    AnimatedButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => SignUpPage()),
    );
    },
    child: Text(
    'GET STARTED',
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    ),

    SizedBox(height: 20),

    // Login text button
    TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => LoginPage()),
    );
    },
    child: Text(
    "I already have an account",
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
    ],
    ),
    );
    }
}

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AnimatedButton({required this.onPressed, required this.child});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..repeat(reverse: true);
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF38E54D),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(vertical: 16),
          minimumSize: Size(double.infinity, 0),
          elevation: 8,
          shadowColor: Color(0xFF38E54D).withOpacity(0.3),
        ),
        child: widget.child,
      ),
    );
  }
}