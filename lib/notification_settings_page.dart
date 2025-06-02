import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.lightGreenAccent[700]!;
    final backgroundColor = Colors.white;
    final cardColor = Colors.grey[50]!;
    final textColor = Colors.grey[900]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Notification Settings',
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
          children: [
            _buildNotificationSection(
              title: 'General Notifications',
              icon: Icons.notifications_none,
              primaryGreen: primaryGreen,
              cardColor: cardColor,
              textColor: textColor,
              switches: [
                _buildSwitchItem('App Updates', true, primaryGreen),
                _buildSwitchItem('Maintenance Alerts', true, primaryGreen),
                _buildSwitchItem('Promotional Offers', false, primaryGreen),
              ],
            ),
            const SizedBox(height: 25),
            _buildNotificationSection(
              title: 'Email Notifications',
              icon: Icons.email_outlined,
              primaryGreen: primaryGreen,
              cardColor: cardColor,
              textColor: textColor,
              switches: [
                _buildSwitchItem('Weekly Digest', true, primaryGreen),
                _buildSwitchItem('Account Activity', true, primaryGreen),
                _buildSwitchItem('Product News', false, primaryGreen),
              ],
            ),
            const SizedBox(height: 25),
            _buildNotificationSection(
              title: 'Sound & Vibration',
              icon: Icons.volume_up,
              primaryGreen: primaryGreen,
              cardColor: cardColor,
              textColor: textColor,
              switches: [
                _buildSwitchItem('Notification Sound', true, primaryGreen),
                _buildSwitchItem('Vibration', false, primaryGreen),
              ],
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
                // Save settings logic
              },
              child: Text(
                'Save Settings',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection({
    required String title,
    required IconData icon,
    required Color primaryGreen,
    required Color cardColor,
    required Color textColor,
    required List<Widget> switches,
  }) {
    return Card(
      color: cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: primaryGreen.withOpacity(0.2),
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
                Icon(icon, color: primaryGreen),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

  Widget _buildSwitchItem(String label, bool value, Color primaryGreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Colors.grey[800],
              fontSize: 14,
            ),
          ),
          Switch(
            value: value,
            onChanged: (bool newValue) {
              // Switch logic
            },
            activeColor: primaryGreen,
            activeTrackColor: primaryGreen.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}