import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
          'Privacy Policy',
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
              'Effective Date: January 1, 2023',
              style: GoogleFonts.roboto(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            _buildSection('1. Information We Collect', primaryGreen),
            _buildParagraph('We collect personal information you provide when you register or use our services.', textColor),
            _buildSection('2. How We Use Information', primaryGreen),
            _buildParagraph('We use the information to provide and improve our services.', textColor),
            _buildSection('3. Data Security', primaryGreen),
            _buildParagraph('We implement security measures to protect your information.', textColor),
            _buildSection('4. Third-Party Services', primaryGreen),
            _buildParagraph('We may use third-party services that collect information.', textColor),
            _buildSection('5. Your Rights', primaryGreen),
            _buildParagraph('You have the right to access and control your personal data.', textColor),
            const SizedBox(height: 30),
            _buildDataControlCard(
              icon: Icons.delete,
              title: 'Request Data Deletion',
              color: Colors.red[700]!,
              primaryGreen: primaryGreen,
            ),
            _buildDataControlCard(
              icon: Icons.download,
              title: 'Export My Data',
              color: primaryGreen,
              primaryGreen: primaryGreen,
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

  Widget _buildDataControlCard({
    required IconData icon,
    required String title,
    required Color color,
    required Color primaryGreen,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: color.withOpacity(0.6),
        ),
      ),
    );
  }
}