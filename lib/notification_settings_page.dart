// notification_settings_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Notification Settings',
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent[400],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.greenAccent[400]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(  // Wrap the content in SingleChildScrollView
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildNotificationSection(
              title: 'General Notifications',
              icon: Icons.notifications_none,
              switches: [
                _buildSwitchItem('App Updates', true),
                _buildSwitchItem('Maintenance Alerts', true),
                _buildSwitchItem('Promotional Offers', false),
              ],
            ),
            const SizedBox(height: 25),
            _buildNotificationSection(
              title: 'Email Notifications',
              icon: Icons.email_outlined,
              switches: [
                _buildSwitchItem('Weekly Digest', true),
                _buildSwitchItem('Account Activity', true),
                _buildSwitchItem('Product News', false),
              ],
            ),
            const SizedBox(height: 25),
            _buildNotificationSection(
              title: 'Sound & Vibration',
              icon: Icons.volume_up,
              switches: [
                _buildSwitchItem('Notification Sound', true),
                _buildSwitchItem('Vibration', false),
              ],
            ),
            const SizedBox(height: 30),  // Changed from Spacer to SizedBox
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
                // Save settings logic
              },
              child: Text(
                'Save Settings',
                style: GoogleFonts.orbitron(
                  color: Colors.greenAccent[400],
                ),
              ),
            ),
            const SizedBox(height: 20),  // Added extra padding at bottom
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection({
    required String title,
    required IconData icon,
    required List<Widget> switches,
  }) {
    return Card(
      color: const Color(0xFF0A261A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.greenAccent.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.greenAccent[400]),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.orbitron(
                    color: Colors.greenAccent[400],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 0.5,
            ),
            ...switches,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Switch(
            value: value,
            onChanged: (bool newValue) {
              // Switch logic
            },
            activeColor: Colors.greenAccent,
            activeTrackColor: Colors.greenAccent.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}