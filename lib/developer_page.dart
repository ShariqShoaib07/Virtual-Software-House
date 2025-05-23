import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
      _filterDevelopers(); // Refresh the filtered list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        title: Text(
          'DEVELOPERS',
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent[400],
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0A261A),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.roboto(
                  color: Colors.greenAccent[200],
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Search developers...',
                  hintStyle: GoogleFonts.roboto(
                    color: Colors.greenAccent[200]!.withOpacity(0.7),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.greenAccent[400]),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _filteredDevelopers.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildDeveloperCard(_filteredDevelopers[index], index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperCard(Map<String, dynamic> dev, int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A261A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: dev['isBlocked']
              ? Colors.red.withOpacity(0.4)
              : Colors.greenAccent.withOpacity(0.3),
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
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.greenAccent.withOpacity(0.3),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      dev['name'].substring(0, 1),
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
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
                          color: Colors.greenAccent[200],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dev['title'],
                        style: GoogleFonts.roboto(
                          color: Colors.greenAccent[400],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dev['experience'],
                        style: GoogleFonts.roboto(
                          color: Colors.greenAccent[200]!.withOpacity(0.8),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                if (dev['isBlocked'])
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.red.withOpacity(0.6)),
                    ),
                    child: Text(
                      'BLOCKED',
                      style: GoogleFonts.roboto(
                        color: Colors.redAccent[200],
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Contact Info
            _buildInfoRow(Icons.phone_outlined, dev['phone']),
            _buildInfoRow(Icons.email_outlined, dev['email']),
            _buildInfoRow(Icons.code_outlined, dev['github'], isLink: true),

            const SizedBox(height: 16),

            // Skills
            Text(
              'SKILLS',
              style: GoogleFonts.orbitron(
                color: Colors.greenAccent[400]!.withOpacity(0.9),
                fontSize: 13,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (dev['skills'] as List<String>).map((skill) => Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.greenAccent.withOpacity(0.4)),
                ),
                child: Text(
                  skill,
                  style: GoogleFonts.roboto(
                    color: Colors.greenAccent[200],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dev['isBlocked']
                          ? Colors.greenAccent[400]
                          : Colors.red.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => _toggleBlockStatus(index),
                    child: Text(
                      dev['isBlocked'] ? 'UNBLOCK' : 'BLOCK',
                      style: GoogleFonts.orbitron(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: Colors.greenAccent[400]!,
                          width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: Text(
                      'VIEW CV',
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent[400],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
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

  Widget _buildInfoRow(IconData icon, String text, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon,
              size: 20,
              color: Colors.greenAccent[400]!.withOpacity(0.9)),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: isLink ? () => launchUrl(Uri.parse('https://$text')) : null,
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: isLink
                    ? Colors.greenAccent[400]
                    : Colors.greenAccent[200],
                fontSize: 14,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}