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
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      body: CustomScrollView(
        slivers: [
          // Profile Header with Gradient
          SliverAppBar(
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.greenAccent.withOpacity(0.2),
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
                          gradient: LinearGradient(
                            colors: [
                              Colors.greenAccent.withOpacity(0.3),
                              Colors.blueAccent.withOpacity(0.3),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.greenAccent.withOpacity(0.6),
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.greenAccent[400],
                              ),
                            ),
                            Positioned(
                              bottom: 6,
                              right: 6,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F3D2C),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.greenAccent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Colors.greenAccent,
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
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent[400],
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'admin@softwaresuite.com',
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent[400]!.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            pinned: true,
            automaticallyImplyLeading: false,
          ),

          // Settings Content with Colorful Sections
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // App Info Section with Gradient
                    _buildSectionHeader(
                      'APP INFORMATION',
                      icon: Icons.apps,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.3),
                          Colors.greenAccent.withOpacity(0.3),
                        ],
                      ),
                    ),
                    _buildSettingCard(
                      icon: Icons.info_outline,
                      title: 'App Version',
                      value: 'v1.0.0',
                      iconColor: Colors.blueAccent,
                      hasArrow: false,
                    ),
                    _buildSettingCard(
                      icon: Icons.update,
                      title: 'Check for Updates',
                      value: 'You are up to date',
                      iconColor: Colors.tealAccent,
                      hasArrow: false,
                    ),

                    // Support Section with Gradient
                    _buildSectionHeader(
                      'SUPPORT & LEGAL',
                      icon: Icons.support,
                      gradient: LinearGradient(
                        colors: [
                          Colors.purpleAccent.withOpacity(0.3),
                          Colors.blueAccent.withOpacity(0.3),
                        ],
                      ),
                    ),
                    _buildSettingCard(
                      icon: Icons.email_outlined,
                      title: 'Contact Support',
                      iconColor: Colors.purpleAccent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContactSupportPage()),
                      ),
                    ),

                    _buildSettingCard(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                      iconColor: Colors.indigoAccent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TermsConditionsPage()),
                      ),
                    ),

                    _buildSettingCard(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      iconColor: Colors.blueAccent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                      ),
                    ),

                    // Account Section with Gradient
                    _buildSectionHeader(
                      'ACCOUNT SETTINGS',
                      icon: Icons.settings,
                      gradient: LinearGradient(
                        colors: [
                          Colors.greenAccent.withOpacity(0.3),
                          Colors.tealAccent.withOpacity(0.3),
                        ],
                      ),
                    ),
                    _buildSettingCard(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      iconColor: Colors.greenAccent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                      ),
                    ),

                    _buildSettingCard(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notification Settings',
                      iconColor: Colors.tealAccent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationSettingsPage()),
                      ),
                    ),

                    // Log Out Button
                    const SizedBox(height: 30),
                    _buildLogoutButton(context),
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

  Widget _buildSectionHeader(String title, {IconData? icon, Gradient? gradient}) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: gradient ?? LinearGradient(
          colors: [
            Colors.greenAccent.withOpacity(0.2),
            Colors.transparent,
          ],
        ),
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
              color: Colors.greenAccent[400],
            ),
            const SizedBox(width: 10),
          ],
          Text(
            title,
            style: GoogleFonts.orbitron(
              color: Colors.greenAccent[400],
              fontSize: 14,
              letterSpacing: 1.5,
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
    VoidCallback? onTap,  // Add this parameter
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF0A261A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.greenAccent.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                (iconColor ?? Colors.greenAccent).withOpacity(0.2),
                Colors.transparent,
              ],
            ),
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.greenAccent[400],
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: value != null
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.greenAccent.withOpacity(0.3),
            ),
          ),
          child: Text(
            value,
            style: GoogleFonts.orbitron(
              color: Colors.greenAccent[400]!.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        )
            : hasArrow
            ? Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.greenAccent.withOpacity(0.6),
        )
            : null,
        onTap: onTap,  // Use the onTap parameter here
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.4),
            Colors.orange.withOpacity(0.2),
          ],
        ),
        border: Border.all(
          color: Colors.red.withOpacity(0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.logout,
            color: Colors.redAccent[200],
          ),
        ),
        title: Text(
          'Log Out',
          style: GoogleFonts.orbitron(
            color: Colors.redAccent[200],
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.redAccent.withOpacity(0.6),
        ),
        onTap: () {
          _showLogoutConfirmation(context);
        },
      ),
    );
  }

  void _changeProfilePicture(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F3D2C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.greenAccent.withOpacity(0.3),
            width: 1,
          ),
        ),
        title: Text(
          'Change Profile Picture',
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent[400],
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Select image source:',
          style: GoogleFonts.roboto(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.blueAccent.withOpacity(0.5),
                ),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context);
              final XFile? image = await picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                // Handle the captured image
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profile picture updated from camera'),
                    backgroundColor: Colors.greenAccent[400],
                  ),
                );
              }
            },
            child: Text(
              'Camera',
              style: GoogleFonts.orbitron(
                color: Colors.blueAccent[200],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.purpleAccent.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.purpleAccent.withOpacity(0.5),
                ),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context);
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                // Handle the selected image
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profile picture updated from gallery'),
                    backgroundColor: Colors.greenAccent[400],
                  ),
                );
              }
            },
            child: Text(
              'Gallery',
              style: GoogleFonts.orbitron(
                color: Colors.purpleAccent[200],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF0F3D2C),
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
                color: Colors.orangeAccent,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Confirm Logout',
                style: GoogleFonts.orbitron(
                  color: Colors.redAccent[200],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Are you sure you want to log out?',
                style: GoogleFonts.roboto(
                  color: Colors.white.withOpacity(0.8),
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
                          color: Colors.greenAccent.withOpacity(0.5),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.orbitron(
                          color: Colors.greenAccent[400],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withOpacity(0.3),
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
                        style: GoogleFonts.orbitron(
                          color: Colors.redAccent[200],
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