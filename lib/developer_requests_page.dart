import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeveloperRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011B10),
      body: Center(
        child: Text(
          'Developer Project Requests',
          style: GoogleFonts.orbitron(color: Colors.greenAccent, fontSize: 18),
        ),
      ),
    );
  }
}
