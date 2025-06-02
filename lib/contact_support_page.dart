import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.lightGreenAccent[700]!;
    final backgroundColor = Colors.white;
    final textColor = Colors.grey[900]!;
    final cardColor = Colors.grey[50]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Contact Support',
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
            _buildInfoCard(
              icon: Icons.email,
              title: 'Email Us',
              value: 'support@softwaresuite.com',
              color: Colors.blue[700]!,
              cardColor: cardColor,
              textColor: textColor,
            ),
            _buildInfoCard(
              icon: Icons.phone,
              title: 'Call Us',
              value: '+1 (555) 123-4567',
              color: primaryGreen,
              cardColor: cardColor,
              textColor: textColor,
            ),
            _buildInfoCard(
              icon: Icons.chat,
              title: 'Live Chat',
              value: 'Available 9AM-5PM EST',
              color: Colors.purple[700]!,
              cardColor: cardColor,
              textColor: textColor,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: primaryGreen.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Send us a message',
                    style: GoogleFonts.roboto(
                      color: primaryGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      labelStyle: TextStyle(color: primaryGreen),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryGreen.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryGreen.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    style: TextStyle(color: textColor),
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      labelStyle: TextStyle(color: primaryGreen),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryGreen.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryGreen.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Send message logic
                    },
                    child: Text(
                      'Send Message',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color cardColor,
    required Color textColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: cardColor,
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
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          value,
          style: GoogleFonts.roboto(
            color: textColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}