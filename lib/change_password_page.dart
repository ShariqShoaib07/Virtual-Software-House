// change_password_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Change Password',
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent[400],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.greenAccent[400]),
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
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'New Password',
              icon: Icons.lock_reset,
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'Confirm New Password',
              icon: Icons.lock_clock,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.greenAccent.withOpacity(0.6),
                  ),
                ),
              ),
              onPressed: () {
                // Change password logic
              },
              child: Text(
                'Update Password',
                style: GoogleFonts.orbitron(
                  color: Colors.greenAccent[400],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Password Requirements:',
              style: GoogleFonts.orbitron(
                color: Colors.greenAccent[400]!.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            _buildRequirementItem('At least 8 characters'),
            _buildRequirementItem('One uppercase letter'),
            _buildRequirementItem('One number'),
            _buildRequirementItem('One special character'),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({required String label, required IconData icon}) {
    return TextField(
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.greenAccent[400]),
        prefixIcon: Icon(icon, color: Colors.greenAccent[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.greenAccent.withOpacity(0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.greenAccent.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.greenAccent[400]!.withOpacity(0.6),
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.roboto(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}