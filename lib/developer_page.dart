import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class DeveloperPage extends StatefulWidget {
  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  final List<Map<String, dynamic>> _allDevelopers = [
    {
      'name': 'John Smith',
      'title': 'Mobile Developer',
      'phone': '+1 555 1234567',
      'email': 'john@example.com',
      'skills': ['Flutter', 'Dart', 'Firebase', 'UI/UX'],
      'github': 'github.com/johnsmith',
      'experience': '5 years experience',
      'isBlocked': false,
    },
    {
      'name': 'Sarah Johnson',
      'title': 'Android Developer',
      'phone': '+1 555 7654321',
      'email': 'sarah@example.com',
      'skills': ['Android', 'Kotlin', 'Java'],
      'github': 'github.com/sarahj',
      'experience': '3 years experience',
      'isBlocked': true,
    },
  ];

  List<Map<String, dynamic>> _filteredDevelopers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _filteredDevelopers = _allDevelopers;
    _searchController.addListener(_filterDevelopers);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterDevelopers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDevelopers = _allDevelopers.where((dev) {
        final name = dev['name'].toLowerCase();
        final title = dev['title'].toLowerCase();
        final skills = dev['skills'].join(' ').toLowerCase();
        return name.contains(query) ||
            title.contains(query) ||
            skills.contains(query);
      }).toList();
    });
  }

  void _toggleBlockStatus(int index) {
    setState(() {
      _allDevelopers[index]['isBlocked'] = !_allDevelopers[index]['isBlocked'];
      _filterDevelopers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.green;
    final accentGreen = Color(0xFF38E54D);
    final backgroundColor = Colors.white;
    final cardColor = Colors.grey[50];
    final textColor = Colors.grey[900];
    final subtitleColor = Colors.grey[600];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'DEVELOPERS',
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: primaryGreen),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: primaryGreen!.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.roboto(
                  color: textColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Search developers...',
                  hintStyle: GoogleFonts.roboto(
                    color: subtitleColor,
                  ),
                  prefixIcon: Icon(Icons.search, color: primaryGreen),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _filteredDevelopers.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildDeveloperCard(_filteredDevelopers[index], index, primaryGreen!, accentGreen!, cardColor!, textColor!, subtitleColor!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperCard(Map<String, dynamic> dev, int index, Color primaryGreen, Color accentGreen, Color cardColor, Color textColor, Color subtitleColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: dev['isBlocked']
              ? Colors.red.withOpacity(0.4)
              : primaryGreen.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: accentGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: accentGreen.withOpacity(0.4),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      dev['name'].substring(0, 1),
                      style: GoogleFonts.roboto(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dev['name'],
                        style: GoogleFonts.roboto(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dev['title'],
                        style: GoogleFonts.roboto(
                          color: primaryGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dev['experience'],
                        style: GoogleFonts.roboto(
                          color: subtitleColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                if (dev['isBlocked'])
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withOpacity(0.6)),
                    ),
                    child: Text(
                      'BLOCKED',
                      style: GoogleFonts.roboto(
                        color: Colors.red[800],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Contact Info
            _buildInfoRow(Icons.phone_outlined, dev['phone'], primaryGreen, textColor),
            _buildInfoRow(Icons.email_outlined, dev['email'], primaryGreen, textColor),
            _buildInfoRow(Icons.code_outlined, dev['github'], primaryGreen, textColor, isLink: true),

            const SizedBox(height: 20),

            // Skills
            Text(
              'SKILLS',
              style: GoogleFonts.roboto(
                color: primaryGreen.withOpacity(0.9),
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: (dev['skills'] as List<String>).map((skill) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: accentGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accentGreen.withOpacity(0.5)),
                ),
                child: Text(
                  skill,
                  style: GoogleFonts.roboto(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dev['isBlocked'] ? accentGreen : Colors.red[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => _toggleBlockStatus(index),
                    child: Text(
                      dev['isBlocked'] ? 'UNBLOCK' : 'BLOCK',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryGreen, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                    child: Text(
                      'VIEW CV',
                      style: GoogleFonts.roboto(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color primaryGreen, Color textColor, {bool isLink = false}) {
    bool isEmail = !isLink && text.contains('@');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 22, color: primaryGreen.withOpacity(0.8)),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: isLink ? () => launchUrl(Uri.parse('https://$text')) : null,
            onLongPress: isEmail ? () {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Copied email to clipboard'),
                  backgroundColor: primaryGreen,
                ),
              );
            } : null,
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: isLink || isEmail ? primaryGreen : textColor,
                fontSize: 16,
                fontWeight: isLink || isEmail ? FontWeight.w600 : FontWeight.w500,
                decoration: isLink || isEmail ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}