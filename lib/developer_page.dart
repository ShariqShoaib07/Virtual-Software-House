import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadCV(String url, String fileName, BuildContext context) async {
  final status = await Permission.storage.request();

  if (status.isGranted) {
    final dir = await getExternalStorageDirectory();
    final filePath = "${dir!.path}/$fileName.pdf";

    try {
      await Dio().download(url, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("CV downloaded to $filePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Download failed: $e")),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Storage permission denied")),
    );
  }
}

class DeveloperPage extends StatefulWidget {
  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> developers = [
    {
      'firstName': 'John',
      'middleName': 'D',
      'lastName': 'Smith',
      'phone': '+1 555 1234567',
      'address': '123 Developer Street',
      'city': 'San Francisco',
      'country': 'USA',
      'image': '',
      'skills': ['Flutter', 'Dart', 'Firebase', 'UI/UX Design'],
      'experience': '5 years of mobile development experience',
      'github': 'https://github.com/johnsmith',
      'cvAvailable': true,
      'isBlocked': false,
    },
    {
      'firstName': 'Sarah',
      'middleName': 'M',
      'lastName': 'Johnson',
      'phone': '+1 555 7654321',
      'address': '456 Code Avenue',
      'city': 'New York',
      'country': 'USA',
      'image': '',
      'skills': ['Android', 'Kotlin', 'Java', 'REST APIs'],
      'experience': '3 years of Android development',
      'github': 'https://github.com/sarahjohnson',
      'cvAvailable': false,
      'isBlocked': true,
    },
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = developers
        .where((dev) =>
        '${dev['firstName']} ${dev['middleName']} ${dev['lastName']}'
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Color(0xFF011B10),
      appBar: AppBar(
        title: Text(
          'DEVELOPERS',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => searchText = val),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '🔍 Search Developers',
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
              padding: EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, index) =>
                  _buildDeveloperCard(filtered[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperCard(Map<String, dynamic> dev) {
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
                child: Icon(Icons.android, color: Colors.greenAccent, size: 32),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  "${dev['firstName']} ${dev['middleName']} ${dev['lastName']}",
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
          _buildInfo("📞 Phone", dev['phone']),
          _buildInfo("📍 Address", dev['address']),
          Row(
            children: [
              Expanded(child: _buildInfo("🌆 City", dev['city'])),
              SizedBox(width: 12),
              Expanded(child: _buildInfo("🌍 Country", dev['country'])),
            ],
          ),
          SizedBox(height: 10),
          _buildInfo("💼 Experience", dev['experience']),
          SizedBox(height: 12),
          Text(
            "🧠 Skills",
            style: GoogleFonts.vt323(color: Colors.greenAccent, fontSize: 18),
          ),
          SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: (dev['skills'] as List<String>).map((skill) {
              return Chip(
                backgroundColor: Color(0xFF011B10),
                label: Text(skill,
                    style: TextStyle(color: Colors.greenAccent, fontSize: 14)),
                shape: StadiumBorder(
                    side: BorderSide(color: Colors.greenAccent, width: 0.5)),
              );
            }).toList(),
          ),
          SizedBox(height: 12),
          _buildInfo("🔗 GitHub", dev['github'], isLink: true),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 8),
              dev['cvAvailable']
                  ? ElevatedButton.icon(
                onPressed: () {
                  final url = dev['cvUrl'];
                  final name = "${dev['firstName']}_${dev['lastName']}_CV";
                  downloadCV(url, name, context);
                },
                icon: Icon(Icons.download, color: Colors.black),
                label: Text(
                  'Download CV',
                  style: GoogleFonts.orbitron(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              )
                  : Row(
                children: [
                  Icon(Icons.cancel, color: Colors.red),
                  SizedBox(width: 8),
                  Text("CV Not Available",
                      style: GoogleFonts.vt323(color: Colors.white70, fontSize: 18)),
                ],
              )
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    dev['isBlocked'] ? Colors.redAccent : Color(0xFF38E54D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  icon: Icon(dev['isBlocked'] ? Icons.lock : Icons.lock_open,
                      color: Colors.black),
                  label: Text(
                    dev['isBlocked'] ? 'UNBLOCK DEVELOPER' : 'BLOCK DEVELOPER',
                    style: GoogleFonts.orbitron(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      dev['isBlocked'] = !dev['isBlocked'];
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

  Widget _buildInfo(String title, String? value, {bool isLink = false}) {
    return InkWell(
      onTap: () async {
        if (isLink && value != null && await canLaunch(value)) {
          await launch(value);
        } else {
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
        }
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
                onTap: () {}, // prevents text overflow from being ignored
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
