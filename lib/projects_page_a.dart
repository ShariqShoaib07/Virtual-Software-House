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
      'color': const Color(0xFF38E54D), // Green
      'iconColor': const Color(0xFF38E54D),
    },
    {
      'title': 'Client Requests',
      'icon': Icons.groups_outlined,
      'page': ClientRequestsPage(),
      'count': ProjectData.pendingProjects.length,
      'color': const Color(0xFF38E54D), // Green
      'iconColor': const Color(0xFF38E54D),
    },
    {
      'title': 'Developer Requests',
      'icon': Icons.engineering,
      'page': DeveloperRequestsPage(),
      'count': ProjectData.developerRequestedProjects.length,
      'color': const Color(0xFF38E54D), // Green
      'iconColor': const Color(0xFF38E54D),
    },
    {
      'title': 'Ongoing Projects',
      'icon': Icons.autorenew,
      'page': OngoingProjectsPage(),
      'count': ProjectData.ongoingProjects.length,
      'color': const Color(0xFF38E54D), // Green
      'iconColor': const Color(0xFF38E54D),
    },
    {
      'title': 'Completed Projects',
      'icon': Icons.verified_outlined,
      'page': CompletedProjectsPage(),
      'count': ProjectData.completedProjects.length,
      'color': const Color(0xFF38E54D), // Green
      'iconColor': const Color(0xFF38E54D),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF38E54D).withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              'PROJECT DASHBOARD',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Color(0xFF38E54D)),
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
    final Color cardColor = section['color'] ?? const Color(0xFF38E54D);
    final Color iconColor = section['iconColor'] ?? const Color(0xFF38E54D);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => section['page']),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: cardColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: cardColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  section['icon'] ?? Icons.help_outline,
                  color: iconColor,
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
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${section['count'] ?? 0} Projects',
                      style: GoogleFonts.roboto(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: cardColor.withOpacity(0.7),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}