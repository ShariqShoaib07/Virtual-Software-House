import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientsPage extends StatefulWidget {
  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";

  List<Map<String, dynamic>> clients = [
    {
      'firstName': 'Alice',
      'middleName': 'Q',
      'lastName': 'Robotics',
      'phone': '+92 300 1234567',
      'email': 'alice@robotics.com',
      'address': 'Sector G-9',
      'city': 'Islamabad',
      'country': 'Pakistan',
      'image': '',
      'isBlocked': false,
    },
    {
      'firstName': 'Bob',
      'middleName': 'Cyber',
      'lastName': 'Space',
      'phone': '+92 333 7654321',
      'email': 'bob@cyberspace.com',
      'address': 'Shahrah-e-Faisal',
      'city': 'Karachi',
      'country': 'Pakistan',
      'image': '',
      'isBlocked': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final primaryGreen = Colors.green;
    final accentGreen = Colors.greenAccent[400];
    final backgroundColor = Colors.white;
    final cardColor = Colors.grey[50];
    final textColor = Colors.grey[900];
    final subtitleColor = Colors.grey[600];

    List<Map<String, dynamic>> filteredClients = clients
        .where((client) =>
        ('${client['firstName']} ${client['lastName']} ${client['middleName']}')
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'CLIENTS',
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
      body: SafeArea(
        child: Column(
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
                  onChanged: (val) => setState(() => searchText = val),
                  style: GoogleFonts.roboto(
                    color: textColor,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search clients...',
                    hintStyle: GoogleFonts.roboto(
                      color: subtitleColor,
                    ),
                    prefixIcon: Icon(Icons.search, color: primaryGreen),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: filteredClients.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildClientCard(
                      filteredClients[index], primaryGreen!, accentGreen!, cardColor!, textColor!, subtitleColor!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientCard(Map<String, dynamic> client, Color primaryGreen, Color accentGreen, Color cardColor, Color textColor, Color subtitleColor) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
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
            color: client['isBlocked']
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
                      child: Icon(
                        Icons.person_outline,
                        color: primaryGreen,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${client['firstName']} ${client['middleName']} ${client['lastName']}",
                          style: GoogleFonts.roboto(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (client['isBlocked'])
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.red.withOpacity(0.6)),
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
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Contact Info
              _buildInfoRow(Icons.location_on_outlined,
                  "${client['address']}, ${client['city']}, ${client['country']}",
                  primaryGreen, textColor),
              _buildInfoRow(Icons.phone_outlined, client['phone'], primaryGreen, textColor),
              _buildInfoRow(Icons.email_outlined, client['email'], primaryGreen, textColor, isEmail: true),

              const SizedBox(height: 20),

              // Action Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: client['isBlocked']
                      ? accentGreen
                      : Colors.red[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 0),
                ),
                onPressed: () {
                  setState(() {
                    client['isBlocked'] = !client['isBlocked'];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      client['isBlocked'] ? Icons.lock_open : Icons.lock_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      client['isBlocked'] ? 'UNBLOCK CLIENT' : 'BLOCK CLIENT',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String? text, Color primaryGreen, Color textColor, {bool isEmail = false}) {
    if (text == null || text.isEmpty) return SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              size: 22,
              color: primaryGreen.withOpacity(0.8)),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onLongPress: isEmail
                  ? () {
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied email to clipboard'),
                    backgroundColor: primaryGreen,
                  ),
                );
              }
                  : null,
              onTap: isEmail ? () => launchUrl(Uri.parse('mailto:$text')) : null,
              child: Text(
                text,
                style: GoogleFonts.roboto(
                  color: isEmail
                      ? primaryGreen
                      : textColor,
                  fontSize: 16,
                  fontWeight: isEmail ? FontWeight.w600 : FontWeight.w500,
                  decoration: isEmail ? TextDecoration.underline : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}