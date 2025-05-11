import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  final List<Map<String, dynamic>> settings = [
    {'icon': Icons.dark_mode, 'title': 'Dark Mode'},
    {'icon': Icons.notifications, 'title': 'Notifications'},
    {'icon': Icons.language, 'title': 'Language'},
    {'icon': Icons.security, 'title': 'Security'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011B10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⚙ SETTINGS',
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
              SizedBox(height: 20),
              ...settings.map((item) => _buildSettingTile(item)).toList(),
              Spacer(),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shadowColor: Colors.redAccent.withOpacity(0.4),
                    elevation: 6,
                  ),
                  icon: Icon(Icons.logout, color: Colors.black),
                  label: Text(
                    'LOG OUT',
                    style: GoogleFonts.orbitron(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  onPressed: () {
                    // Your logout logic here
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xFF0F3D2C),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF38E54D).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(item['icon'], color: Colors.greenAccent),
          SizedBox(width: 16),
          Text(
            item['title'],
            style: GoogleFonts.vt323(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.greenAccent, size: 16),
        ],
      ),
    );
  }
}
