// contact_support_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Contact Support',
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
            _buildInfoCard(
              icon: Icons.email,
              title: 'Email Us',
              value: 'support@softwaresuite.com',
              color: Colors.blueAccent,
            ),
            _buildInfoCard(
              icon: Icons.phone,
              title: 'Call Us',
              value: '+1 (555) 123-4567',
              color: Colors.greenAccent,
            ),
            _buildInfoCard(
              icon: Icons.chat,
              title: 'Live Chat',
              value: 'Available 9AM-5PM EST',
              color: Colors.purpleAccent,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0A261A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.greenAccent.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Send us a message',
                    style: GoogleFonts.orbitron(
                      color: Colors.greenAccent[400],
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      labelStyle: TextStyle(color: Colors.greenAccent[400]),
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
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      labelStyle: TextStyle(color: Colors.greenAccent[400]),
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
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.withOpacity(0.2),
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
                      // Send message logic
                    },
                    child: Text(
                      'Send Message',
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent[400],
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
        subtitle: Text(
          value,
          style: GoogleFonts.roboto(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}