import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientsPage extends StatefulWidget {
  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final TextEditingController _searchController = TextEditingController();

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

  String searchText = "";

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
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => searchText = val),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '🔍 Search Clients',
                  hintStyle: TextStyle(color: Colors.greenAccent.shade100),
                  prefixIcon: Icon(Icons.search, color: Colors.greenAccent),
                  filled: true,
                  fillColor: Color(0xFF0F3D2C),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  final client = filteredClients[index];
                  return _buildClientCard(client);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientCard(Map<String, dynamic> client) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0F3D2C),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF38E54D).withOpacity(0.4),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                child: Icon(Icons.account_circle, color: Colors.greenAccent, size: 32),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  "${client['firstName']} ${client['middleName']} ${client['lastName']}",
                  style: GoogleFonts.orbitron(
                    color: Colors.greenAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildInfo("📍 Address", client['address']),
          Row(
            children: [
              Expanded(child: _buildInfo("🌆 City", client['city'])),
              SizedBox(width: 12),
              Expanded(child: _buildInfo("🌍 Country", client['country'])),
            ],
          ),
          SizedBox(height: 10),
          _buildInfo("📞 Phone", client['phone']),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    client['isBlocked'] ? Colors.redAccent : Color(0xFF38E54D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  icon: Icon(
                      client['isBlocked'] ? Icons.lock : Icons.lock_open,
                      color: Colors.black),
                  label: Text(
                    client['isBlocked'] ? 'UNBLOCK CLIENT' : 'BLOCK CLIENT',
                    style: GoogleFonts.orbitron(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      client['isBlocked'] = !client['isBlocked'];
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String? value) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xFF0F3D2C),
            title: Text(
              title,
              style: GoogleFonts.orbitron(color: Colors.greenAccent),
            ),
            content: SelectableText(
              value ?? 'N/A',
              style: GoogleFonts.vt323(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            actions: [
              TextButton(
                child: Text('CLOSE', style: TextStyle(color: Colors.greenAccent)),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFF011B10),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.greenAccent, width: 0.7),
        ),
        child: Row(
          children: [
            Text(
              "$title: ",
              style: GoogleFonts.vt323(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: SelectableText(
                value ?? '',
                style: GoogleFonts.vt323(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3D2C),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.greenAccent, width: 0.8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$label: ",
              style: GoogleFonts.vt323(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.vt323(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildClientInfo(String title, String? value) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF011B10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.greenAccent, width: 0.7),
      ),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: GoogleFonts.vt323(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Text(
              value ?? '',
              style: GoogleFonts.vt323(
                color: Colors.white,
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
