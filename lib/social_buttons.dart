//social_button.dart
import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: Icons.facebook,
          color: Color(0xFF3B5998),
          onPressed: () {},
        ),
        SizedBox(width: 20),
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          color: Color(0xFFDB4437),
          onPressed: () {},
        ),
        SizedBox(width: 20),
        _buildSocialButton(
          icon: Icons.apple,
          color: Colors.black,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
      ),
    );
  }
}