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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Client Project Requests",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF38E54D)),
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
          color: const Color(0xFF38E54D).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Name
            Row(
              children: [
                Icon(Icons.business,
                    color: const Color(0xFF38E54D),
                    size: 16),
                const SizedBox(width: 6),
                Text(
                  clientName,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.grey[700],
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
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                    style: GoogleFonts.roboto(
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
              style: GoogleFonts.roboto(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Requirements
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.requirements
                  .take(3)
                  .map((req) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF38E54D).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF38E54D).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  req,
                  style: GoogleFonts.roboto(
                    color: const Color(0xFF38E54D),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Budget and Timeline
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '\$${project.acceptedPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: const Color(0xFF38E54D),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Time",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      project.deliveryTime,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Completion Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Requested on: ${_formatDate(DateTime.now())}",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Icon(
                  Icons.pending_actions,
                  color: const Color(0xFF38E54D),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Color _getStatusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.pending:
        return Colors.orange;
      case ProjectStatus.notStarted:
        return const Color(0xFF38E54D);
      case ProjectStatus.ongoing:
        return Colors.blue;
      case ProjectStatus.completed:
        return Colors.green;
      case ProjectStatus.rejected:
        return Colors.red;
      default:
        return const Color(0xFF38E54D);
    }
  }

  String _getStatusText(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.pending:
        return "Pending";
      case ProjectStatus.notStarted:
        return "Approved";
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