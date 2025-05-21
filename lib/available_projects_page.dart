import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_data.dart';

class AvailableProjectsPage extends StatefulWidget {
  @override
  _AvailableProjectsPageState createState() => _AvailableProjectsPageState();
}

class _AvailableProjectsPageState extends State<AvailableProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Available Projects"),
      ),
      body: Column(
        children: [
          // Your search and filter widgets...
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: ListView.builder(
                itemCount: ProjectData.notStartedProjects.length,
                itemBuilder: (context, index) {
                  final project = ProjectData.notStartedProjects[index];
                  return _buildProjectCard(context, project);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project.details,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: project.requirements
                  .take(3)
                  .map((req) => Chip(label: Text(req)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$${project.acceptedPrice.toStringAsFixed(2)}'),
                    Text('Delivery: ${project.deliveryTime}'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      project.status = ProjectStatus.developerRequested;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Application submitted to admin')),
                    );
                  },
                  child: Text('Apply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}