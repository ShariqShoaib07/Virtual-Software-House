import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      body: CustomScrollView(
        slivers: [
          // Profile Header
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.greenAccent.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => _changeProfilePicture(context),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.greenAccent.withOpacity(0.2),
                        child: Stack(
                          children: [
                            Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.greenAccent,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F3D2C),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.greenAccent,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Admin User',
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'admin@softwaresuite.com',
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            pinned: true,
            automaticallyImplyLeading: false,
          ),

          // Settings Content
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // App Info Section
                    _buildSectionHeader('APP INFORMATION'),
                    _buildSettingCard(
                      icon: Icons.info_outline,
                      title: 'App Version',
                      value: 'v1.0.0',
                      hasArrow: false,
                    ),
                    _buildSettingCard(
                      icon: Icons.update,
                      title: 'Check for Updates',
                      value: 'You are up to date',
                      hasArrow: false,
                    ),

                    // Support Section
                    _buildSectionHeader('SUPPORT & LEGAL'),
                    _buildSettingCard(
                      icon: Icons.email_outlined,
                      title: 'Contact Support',
                    ),
                    _buildSettingCard(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                    ),
                    _buildSettingCard(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                    ),

                    // Account Section
                    _buildSectionHeader('ACCOUNT SETTINGS'),
                    _buildSettingCard(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                    ),
                    _buildSettingCard(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notification Settings',
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

  void _changeProfilePicture(BuildContext context) {
    // Implement image picker functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F3D2C),
        title: Text(
          'Change Profile Picture',
          style: GoogleFonts.orbitron(color: Colors.greenAccent),
        ),
        content: Text(
          'Select image source:',
          style: GoogleFonts.orbitron(color: Colors.greenAccent.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement camera functionality
              Navigator.pop(context);
            },
            child: Text(
              'Camera',
              style: GoogleFonts.orbitron(color: Colors.greenAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              // Implement gallery functionality
              Navigator.pop(context);
            },
            child: Text(
              'Gallery',
              style: GoogleFonts.orbitron(color: Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent.withOpacity(0.5),
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    String? value,
    bool hasArrow = true,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF0F3D2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.greenAccent.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.greenAccent.withOpacity(0.8),
        ),
        title: Text(
          title,
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent,
            fontSize: 14,
          ),
        ),
        trailing: value != null
            ? Text(
          value,
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent.withOpacity(0.7),
            fontSize: 12,
          ),
        )
            : hasArrow
            ? Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.greenAccent.withOpacity(0.5),
        )
            : null,
        onTap: () {
          // Add navigation/functionality
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.3),
            Colors.red.withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: Colors.red.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.redAccent,
        ),
        title: Text(
          'Log Out',
          style: GoogleFonts.orbitron(
            color: Colors.redAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          _showLogoutConfirmation(context);
        },
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F3D2C),
        title: Text(
          'Confirm Logout',
          style: GoogleFonts.orbitron(color: Colors.greenAccent),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: GoogleFonts.orbitron(color: Colors.greenAccent.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.orbitron(color: Colors.greenAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              // Implement logout functionality
              Navigator.pop(context);
              Navigator.pop(context); // Close settings page too
            },
            child: Text(
              'Log Out',
              style: GoogleFonts.orbitron(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}