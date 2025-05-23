import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'client_requests_page.dart';
import 'developer_requests_page.dart';
import 'ongoing_projects_page.dart';
import 'completed_projects_page.dart';
import 'available_projects_page.dart';
import 'project_data.dart';

class ProjectsPage extends StatelessWidget {
  final List<Map<String, dynamic>> projectSections = [
    {
      'title': 'Available Projects',
      'icon': Icons.work_outline,
      'page': AvailableProjectsPage(),
      'count': ProjectData.notStartedProjects.length,
      'color': Colors.tealAccent,
      'gradientColor': const Color(0xFF0F3D2C),
    },
    {
      'title': 'Client Requests',
      'icon': Icons.groups_outlined,
      'page': ClientRequestsPage(),
      'count': ProjectData.pendingProjects.length,
      'color': Colors.orangeAccent,
      'gradientColor': const Color(0xFF0F3D2C),
    },
    {
      'title': 'Developer Requests',
      'icon': Icons.engineering,
      'page': DeveloperRequestsPage(),
      'count': ProjectData.developerRequestedProjects.length,
      'color': Colors.blueAccent,
      'gradientColor': const Color(0xFF0F3D2C),
    },
    {
      'title': 'Ongoing Projects',
      'icon': Icons.autorenew,
      'page': OngoingProjectsPage(),
      'count': ProjectData.ongoingProjects.length,
      'color': Colors.yellowAccent,
      'gradientColor': const Color(0xFF0F3D2C),
    },
    {
      'title': 'Completed Projects',
      'icon': Icons.verified_outlined,
      'page': CompletedProjectsPage(),
      'count': ProjectData.completedProjects.length,
      'color': Colors.greenAccent,
      'gradientColor': const Color(0xFF0F3D2C),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
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
              ),
            ),
            pinned: true,
            backgroundColor: const Color(0xFF011B10),
            automaticallyImplyLeading: false,
            title: Text(
              'PROJECT DASHBOARD',
              style: GoogleFonts.orbitron(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildProjectCard(context, projectSections[index]),
                ),
                childCount: projectSections.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> section) {
    final Color accentColor = section['color'] ?? Colors.greenAccent;
    final Color baseColor = section['gradientColor'] ?? const Color(0xFF0F3D2C);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => section['page'],
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        height: 100, // Fixed height for rectangular cards
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              baseColor,
              accentColor.withOpacity(0.2),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: accentColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  section['icon'] ?? Icons.help_outline,
                  color: accentColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section['title'] ?? 'Projects',
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${section['count'] ?? 0} Projects',
                      style: GoogleFonts.orbitron(
                        color: Colors.greenAccent.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: accentColor.withOpacity(0.7),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}