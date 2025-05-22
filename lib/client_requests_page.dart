import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

class ClientRequestsPage extends StatefulWidget {
  @override
  _ClientRequestsPageState createState() => _ClientRequestsPageState();
}

class _ClientRequestsPageState extends State<ClientRequestsPage> {
  List<ClientProject> pendingProjects = [
    ClientProject(
      title: "E-commerce Mobile App",
      details: "Build a Flutter e-commerce app with product listings, cart functionality, and payment integration.",
      requirements: ["Flutter", "Firebase", "Stripe API", "UI/UX"],
      acceptedPrice: 2500.00,
      deliveryTime: "6 weeks",
    ),
    ClientProject(
      title: "Company Website Redesign",
      details: "Modern redesign of our corporate website with improved navigation and mobile responsiveness.",
      requirements: ["React", "Tailwind CSS", "Figma"],
      acceptedPrice: 1800.00,
      deliveryTime: "4 weeks",
    ),
    ClientProject(
      title: "Inventory Management System",
      details: "Develop a desktop application for inventory tracking with barcode scanning capabilities.",
      requirements: ["Java", "MySQL", "Barcode API"],
      acceptedPrice: 3200.00,
      deliveryTime: "8 weeks",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10),
      appBar: AppBar(
        title: Text(
          "Client Project Requests",
          style: GoogleFonts.orbitron(
            color: Colors.greenAccent,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF011B10),
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pendingProjects.length,
        itemBuilder: (context, index) {
          final project = pendingProjects[index];
          return _buildProjectCard(context, project, index);
        },
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, ClientProject project, int index) {
    final clientNames = ['TechSolutions Inc.', 'Digital Ventures', 'CodeCraft LLC'];
    final clientName = clientNames[index % clientNames.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3D2C),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Name
            Row(
              children: [
                Icon(Icons.person_outline,
                    color: Colors.greenAccent.withOpacity(0.7),
                    size: 16),
                const SizedBox(width: 6),
                Text(
                  clientName,
                  style: GoogleFonts.orbitron(
                    fontSize: 14,
                    color: Colors.greenAccent.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Project Title and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    project.title,
                    style: GoogleFonts.orbitron(
                      fontSize: 16,  // Reduced from 18 to prevent overflow
                      fontWeight: FontWeight.w600,
                      color: Colors.greenAccent,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(project.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(project.status).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    _getStatusText(project.status),
                    style: GoogleFonts.orbitron(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _getStatusColor(project.status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Project Details
            Text(
              project.details,
              style: GoogleFonts.orbitron(
                color: Colors.greenAccent.withOpacity(0.7),
                fontSize: 14,
              ),
              maxLines: 2,  // Reduced from 3 to prevent overflow
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Requirements Chips (limited to 3)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: project.requirements
                  .take(3)  // Limit to 3 requirements to prevent overflow
                  .map((req) => _buildRequirementChip(req))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Budget and Delivery Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget",
                      style: GoogleFonts.orbitron(
                        fontSize: 12,
                        color: Colors.greenAccent.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      "\$${project.acceptedPrice.toStringAsFixed(2)}",
                      style: GoogleFonts.orbitron(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Time",
                      style: GoogleFonts.orbitron(
                        fontSize: 12,
                        color: Colors.greenAccent.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      project.deliveryTime,
                      style: GoogleFonts.orbitron(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action Buttons (only show if pending)
            if (project.status == ProjectStatus.pending)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red.withOpacity(0.5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: Text(
                      "Reject",
                      style: GoogleFonts.orbitron(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        pendingProjects[index].status = ProjectStatus.rejected;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Project rejected",
                            style: GoogleFonts.orbitron(),
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: Text(
                      "Approve",
                      style: GoogleFonts.orbitron(
                        color: const Color(0xFF011B10),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        pendingProjects[index].status = ProjectStatus.notStarted;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Project approved",
                            style: GoogleFonts.orbitron(),
                          ),
                          backgroundColor: Colors.greenAccent,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.3),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.orbitron(
          color: Colors.greenAccent,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getStatusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.pending:
        return Colors.orange;
      case ProjectStatus.notStarted:
        return Colors.blue;
      case ProjectStatus.ongoing:
        return Colors.yellow;
      case ProjectStatus.completed:
        return Colors.green;
      case ProjectStatus.rejected:
        return Colors.red;
      default:
        return Colors.greenAccent;
    }
  }

  String _getStatusText(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.pending:
        return "Pending";
      case ProjectStatus.notStarted:
        return "Not Started";
      case ProjectStatus.ongoing:
        return "Ongoing";
      case ProjectStatus.completed:
        return "Completed";
      case ProjectStatus.rejected:
        return "Rejected";
      default:
        return "Pending";
    }
  }
}