import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'contact_support_page.dart';
import 'terms_conditions_page.dart';
import 'privacy_policy_page.dart';
import 'change_password_page.dart';
import 'notification_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.lightGreenAccent[700];
    final accentGreen = Colors.greenAccent[400];
    final backgroundColor = Colors.white;
    final cardColor = Colors.grey[50]!;
    final textColor = Colors.grey[900]!;
    final subtitleColor = Colors.grey[600];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Profile Header
          SliverAppBar(
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryGreen!.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => _changeProfilePicture(context),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentGreen!.withOpacity(0.1),
                          border: Border.all(
                            color: primaryGreen.withOpacity(0.6),
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: primaryGreen,
                              ),
                            ),
                            Positioned(
                              bottom: 6,
                              right: 6,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: primaryGreen,
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: primaryGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Admin User',
                      style: GoogleFonts.roboto(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'admin@softwaresuite.com',
                      style: GoogleFonts.roboto(
                        color: subtitleColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: backgroundColor,
            elevation: 0,
          ),

          // Settings Content
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // App Info Section
                    _buildSectionHeader(
                      'APP INFORMATION',
                      icon: Icons.apps,
                      primaryGreen: primaryGreen,
                    ),
                    _buildSettingCard(
                      icon: Icons.info_outline,
                      title: 'App Version',
                      value: 'v1.0.0',
                      iconColor: Colors.blue[700],
                      hasArrow: false,
                      primaryGreen: primaryGreen,
                      cardColor: cardColor,
                      textColor: textColor,
                    ),
                    _buildSettingCard(
                      icon: Icons.update,
                      title: 'Check for Updates',
                      value: 'You are up to date',
                      iconColor: Colors.teal[700],
                      hasArrow: false,
                      primaryGreen: primaryGreen,
                      cardColor: cardColor,
                      textColor: textColor,
                    ),

                    // Support Section
                    _buildSectionHeader(
                      'SUPPORT & LEGAL',
                      icon: Icons.support,
                      primaryGreen: primaryGreen,
                    ),
                    _buildSettingCard(
                      icon: Icons.email_outlined,
                      title: 'Contact Support',
                      iconColor: Colors.purple[700],
                      primaryGreen: primaryGreen,
                      cardColor: cardColor,
                      textColor: textColor,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContactSupportPage()),
                      ),
                    ),

                    _buildSettingCard(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                      iconColor: Colors.indigo[700],
                      primaryGreen: primaryGreen,
                      cardColor: cardColor,
                      textColor: textColor,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TermsConditionsPage()),
                      ),
                    ),

                    _buildSettingCard(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      iconColor: Colors.blue[700],
                      primaryGreen: primaryGreen,
                      cardColor: cardColor,
                      textColor: textColor,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                      ),
                    ),

                    // Account Section
                    _buildSectionHeader(
                      'ACCOUNT SETTINGS',
                      icon: Icons.settings,
                      primaryGreen: primaryGreen,
                    ),
                    _buildSettingCard(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      iconColor: primaryGreen,
                      primaryGreen: primaryGreen,
                      cardColor: cardColor,
                      textColor: textColor,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                      ),
                    ),

                    _buildSettingCard(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notification Settings',
                      iconColor: Colors.teal[700],
                      primaryGreen: primaryGreen,
                      cardColor: cardColor,
                      textColor: textColor,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationSettingsPage()),
                      ),
                    ),

                    // Log Out Button
                    const SizedBox(height: 30),
                    _buildLogoutButton(context, primaryGreen, backgroundColor, textColor),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {IconData? icon, required Color primaryGreen}) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: primaryGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
              color: primaryGreen,
            ),
            const SizedBox(width: 10),
          ],
          Text(
            title,
            style: GoogleFonts.roboto(
              color: primaryGreen,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    String? value,
    Color? iconColor,
    bool hasArrow = true,
    VoidCallback? onTap,
    required Color primaryGreen,
    required Color cardColor,
    required Color textColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: primaryGreen.withOpacity(0.1),
          width: 1,
        ),
      ),
      elevation: 0,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (iconColor ?? primaryGreen).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor ?? primaryGreen,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: value != null
            ? Text(
          value,
          style: GoogleFonts.roboto(
            color: textColor.withOpacity(0.7),
            fontSize: 14,
          ),
        )
            : hasArrow
            ? Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: primaryGreen.withOpacity(0.6),
        )
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, Color primaryGreen, Color backgroundColor, Color textColor) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.red[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.red.withOpacity(0.3),
          width: 1,
        ),
      ),
      elevation: 0,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.logout,
            color: Colors.red[700],
          ),
        ),
        title: Text(
          'Log Out',
          style: GoogleFonts.roboto(
            color: Colors.red[700],
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.red.withOpacity(0.6),
        ),
        onTap: () {
          _showLogoutConfirmation(context, primaryGreen, backgroundColor, textColor);
        },
      ),
    );
  }

  void _changeProfilePicture(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final primaryGreen = Colors.green[700];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: primaryGreen!.withOpacity(0.3),
            width: 1,
          ),
        ),
        title: Text(
          'Change Profile Picture',
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Select image source:',
          style: GoogleFonts.roboto(
            color: Colors.grey[700],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.blue.withOpacity(0.5),
                ),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context);
              final XFile? image = await picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profile picture updated from camera'),
                    backgroundColor: primaryGreen,
                  ),
                );
              }
            },
            child: Text(
              'Camera',
              style: GoogleFonts.roboto(
                color: Colors.blue[700],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.purple.withOpacity(0.5),
                ),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context);
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profile picture updated from gallery'),
                    backgroundColor: primaryGreen,
                  ),
                );
              }
            },
            child: Text(
              'Gallery',
              style: GoogleFonts.roboto(
                color: Colors.purple[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, Color primaryGreen, Color backgroundColor, Color textColor) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.red.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange[700],
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Confirm Logout',
                style: GoogleFonts.roboto(
                  color: Colors.red[700],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Are you sure you want to log out?',
                style: GoogleFonts.roboto(
                  color: textColor.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                          color: primaryGreen.withOpacity(0.5),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.roboto(
                          color: primaryGreen,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[50],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.red.withOpacity(0.6),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Log Out',
                        style: GoogleFonts.roboto(
                          color: Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}