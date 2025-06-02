import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.lightGreenAccent[700]!;
    final backgroundColor = Colors.white;
    final textColor = Colors.grey[900]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Change Password',
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryGreen),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildPasswordField(
              label: 'Current Password',
              icon: Icons.lock_outline,
              primaryGreen: primaryGreen,
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'New Password',
              icon: Icons.lock_reset,
              primaryGreen: primaryGreen,
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'Confirm New Password',
              icon: Icons.lock_clock,
              primaryGreen: primaryGreen,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Change password logic
              },
              child: Text(
                'Update Password',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Password Requirements:',
              style: GoogleFonts.roboto(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildRequirementItem('At least 8 characters', primaryGreen),
            _buildRequirementItem('One uppercase letter', primaryGreen),
            _buildRequirementItem('One number', primaryGreen),
            _buildRequirementItem('One special character', primaryGreen),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required IconData icon,
    required Color primaryGreen,
  }) {
    return TextField(
      obscureText: true,
      style: TextStyle(color: Colors.grey[800]),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: primaryGreen),
        prefixIcon: Icon(icon, color: primaryGreen),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryGreen.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryGreen.withOpacity(0.5)),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text, Color primaryGreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: primaryGreen.withOpacity(0.6),
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.roboto(
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}