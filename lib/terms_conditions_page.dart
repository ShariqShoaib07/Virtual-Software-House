// terms_conditions_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent[400],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.greenAccent[400]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Updated: January 1, 2023',
              style: GoogleFonts.roboto(
                color: Colors.greenAccent[400]!.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            _buildSection('1. Acceptance of Terms'),
            _buildParagraph(
                'By accessing or using the Software Suite application, you agree to be bound by these Terms and Conditions.'),
            _buildSection('2. User Responsibilities'),
            _buildParagraph(
                'You are responsible for maintaining the confidentiality of your account and password.'),
            _buildSection('3. Privacy Policy'),
            _buildParagraph(
                'Your use of the app is subject to our Privacy Policy.'),
            _buildSection('4. Intellectual Property'),
            _buildParagraph(
                'All content included in the app is the property of Software Suite.'),
            _buildSection('5. Limitation of Liability'),
            _buildParagraph(
                'Software Suite shall not be liable for any indirect, incidental damages.'),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A261A),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.greenAccent.withOpacity(0.6),
                    ),
                  ),
                ),
                onPressed: () {
                  // Accept terms logic
                },
                child: Text(
                  'I Accept',
                  style: GoogleFonts.orbitron(
                    color: Colors.greenAccent[400],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.orbitron(
          color: Colors.greenAccent[400],
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: Colors.white.withOpacity(0.8),
          fontSize: 14,
        ),
      ),
    );
  }
}