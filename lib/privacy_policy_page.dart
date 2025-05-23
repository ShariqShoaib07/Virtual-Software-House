// privacy_policy_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Privacy Policy',
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
              'Effective Date: January 1, 2023',
              style: GoogleFonts.roboto(
                color: Colors.greenAccent[400]!.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            _buildSection('1. Information We Collect'),
            _buildParagraph(
                'We collect personal information you provide when you register or use our services.'),
            _buildSection('2. How We Use Information'),
            _buildParagraph(
                'We use the information to provide and improve our services.'),
            _buildSection('3. Data Security'),
            _buildParagraph(
                'We implement security measures to protect your information.'),
            _buildSection('4. Third-Party Services'),
            _buildParagraph(
                'We may use third-party services that collect information.'),
            _buildSection('5. Your Rights'),
            _buildParagraph(
                'You have the right to access and control your personal data.'),
            const SizedBox(height: 30),
            _buildDataControlCard(
              icon: Icons.delete,
              title: 'Request Data Deletion',
              color: Colors.redAccent,
            ),
            _buildDataControlCard(
              icon: Icons.download,
              title: 'Export My Data',
              color: Colors.greenAccent,
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

  Widget _buildDataControlCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: const Color(0xFF0A261A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: color.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.white,
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