import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      'address': 'Shahrah-e-Faisal',
      'city': 'Karachi',
      'country': 'Pakistan',
      'image': '',
      'isBlocked': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredClients = clients
        .where((client) =>
        ('${client['firstName']} ${client['lastName']} ${client['middleName']}')
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        title: Text(
          'CLIENTS',
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
      body: SafeArea(
        child: Column(
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
                  onChanged: (val) => setState(() => searchText = val),
                  style: GoogleFonts.roboto(
                    color: Colors.greenAccent[200],
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search clients...',
                    hintStyle: GoogleFonts.roboto(
                        color: Colors.greenAccent[200]!.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.greenAccent[400]),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: filteredClients.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildClientCard(filteredClients[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientCard(Map<String, dynamic> client) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: const Color(0xFF0A261A),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(client['isBlocked'] ? 0.1 : 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: client['isBlocked']
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
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.greenAccent[400],
                        size: 28,
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
                            color: Colors.greenAccent[200],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (client['isBlocked'])
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
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
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Contact Info
              _buildInfoRow(Icons.location_on_outlined,
                  "${client['address']}, ${client['city']}, ${client['country']}"),
              _buildInfoRow(Icons.phone_outlined, client['phone']),

              const SizedBox(height: 20),

              // Action Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: client['isBlocked']
                      ? Colors.greenAccent[400]
                      : Colors.red.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
                      color: Colors.black,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      client['isBlocked'] ? 'UNBLOCK CLIENT' : 'BLOCK CLIENT',
                      style: GoogleFonts.orbitron(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              size: 20,
              color: Colors.greenAccent[400]!.withOpacity(0.9)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: Colors.greenAccent[200],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}