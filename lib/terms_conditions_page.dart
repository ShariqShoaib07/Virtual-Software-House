import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

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
          'Terms & Conditions',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Updated: January 1, 2023',
              style: GoogleFonts.roboto(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            _buildSection('1. Acceptance of Terms', primaryGreen),
            _buildParagraph('By accessing or using the Software Suite application, you agree to be bound by these Terms and Conditions.', textColor),
            _buildSection('2. User Responsibilities', primaryGreen),
            _buildParagraph('You are responsible for maintaining the confidentiality of your account and password.', textColor),
            _buildSection('3. Privacy Policy', primaryGreen),
            _buildParagraph('Your use of the app is subject to our Privacy Policy.', textColor),
            _buildSection('4. Intellectual Property', primaryGreen),
            _buildParagraph('All content included in the app is the property of Software Suite.', textColor),
            _buildSection('5. Limitation of Liability', primaryGreen),
            _buildParagraph('Software Suite shall not be liable for any indirect, incidental damages.', textColor),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Accept terms logic
                },
                child: Text(
                  'I Accept',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Color primaryGreen) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          color: primaryGreen,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: textColor.withOpacity(0.8),
          fontSize: 14,
        ),
      ),
    );
  }
}