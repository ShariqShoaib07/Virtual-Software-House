//projects_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Project> projects = [
    Project(
      title: "E-commerce App Development",
      jobType: "In-person",
      details: "Develop a complete e-commerce app...",
      deliveryTime: "1 Month",
      requirements: ["Flutter", "Firebase", "Payment Gateway", "UI/UX Design"],
      acceptedPrice: 1500.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
    ),
    Project(
      title: "Portfolio Website",
      jobType: "Remote",
      details: "Create a modern portfolio website...",
      deliveryTime: "2 Weeks",
      requirements: ["HTML/CSS", "JavaScript", "Responsive Design", "Animation"],
      acceptedPrice: 800.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 14)),
    ),
  ];
  List<Project> filteredProjects = [];
  String _filterJobType = "all";

  @override
  void initState() {
    super.initState();
    filteredProjects = projects;
    _searchController.addListener(_filterProjects);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProjects() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredProjects = projects.where((project) {
        final matchesSearch = project.title.toLowerCase().contains(query) ||
            project.details.toLowerCase().contains(query);
        final matchesFilter = _filterJobType == "all" ||
            project.jobType.toLowerCase() == _filterJobType;
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Projects", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search projects...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip("All", _filterJobType == "all"),
                      const SizedBox(width: 8),
                      _buildFilterChip("In-person", _filterJobType == "in-person"),
                      const SizedBox(width: 8),
                      _buildFilterChip("Remote", _filterJobType == "remote"),
                      const SizedBox(width: 8),
                      _buildFilterChip("Hybrid", _filterJobType == "hybrid"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Projects Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = filteredProjects[index];
                  return _buildProjectCard(project);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (isSelected) {
        setState(() {
          _filterJobType = label.toLowerCase();
          _filterProjects();
        });
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF38E54D),
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.grey[700],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: selected ? 2 : 0,
    );
  }

  Widget _buildProjectCard(Project project) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectDetailsPage(project: project),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Type Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getJobTypeColor(project.jobType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  project.jobType,
                  style: TextStyle(
                    color: _getJobTypeColor(project.jobType),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Project Title
              Text(
                project.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Requirements Chips
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.requirements
                    .take(3)
                    .map((req) => _buildRequirementChip(req))
                    .toList(),
              ),
              const Spacer(),

              // Footer with Time
              Text(
                project.deliveryTime,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getJobTypeColor(String jobType) {
    switch (jobType.toLowerCase()) {
      case "in-person":
        return Colors.blue;
      case "remote":
        return Colors.green;
      case "hybrid":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class ProjectDetailsPage extends StatefulWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Project Details"),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: _isDownloading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.download),
            onPressed: _isDownloading ? null : () => _downloadSRS(context),
            tooltip: 'Download SRS Document',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getJobTypeColor(widget.project.jobType).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.project.jobType,
                      style: TextStyle(
                        color: _getJobTypeColor(widget.project.jobType),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Project Title
                  Text(
                    widget.project.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Time
                  _buildDetailPill(
                    Icons.access_time,
                    widget.project.deliveryTime,
                    Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About Project Section
            const Text(
              "About the Project",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.project.details,
                style: TextStyle(
                  height: 1.5,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Requirements Section
            const Text(
              "Requirements",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: widget.project.requirements
                    .map((req) => _buildRequirementItem(req))
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Decline",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmitProposalPage(project: widget.project),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF38E54D),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Apply Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailPill(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 20, color: Colors.green[400]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getJobTypeColor(String jobType) {
    switch (jobType.toLowerCase()) {
      case "in-person":
        return Colors.blue;
      case "remote":
        return Colors.green;
      case "hybrid":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Future<void> _downloadSRS(BuildContext context) async {
    setState(() {
      _isDownloading = true;
    });

    try {
      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${widget.project.title.replaceAll(' ', '_')}_SRS.pdf');

      // Simulate downloading by copying from assets
      // In a real app, you would download from a server
      final data = await rootBundle.load('assets/sample_srs.pdf');
      await file.writeAsBytes(data.buffer.asUint8List());

      // Open the downloaded file
      await OpenFile.open(file.path);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("SRS document downloaded successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to download SRS: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }
}

class SubmitProposalPage extends StatefulWidget {
  final Project project;

  const SubmitProposalPage({super.key, required this.project});

  @override
  State<SubmitProposalPage> createState() => _SubmitProposalPageState();
}

class _SubmitProposalPageState extends State<SubmitProposalPage> {
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _timeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Submit Proposal"),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.details,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Form Title
              const Text(
                "Your Proposal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Time Required Field
              const Text(
                "Estimated Time",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  hintText: "e.g. 2 weeks, 1 month",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter estimated time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Price Field
              const Text(
                "Your Price (\$)",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your price in USD",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitProposal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38E54D),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Submit Proposal",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Duration _parseDuration(String text) {
    if (text.contains('month')) {
      return Duration(days: 30);
    } else if (text.contains('week')) {
      return Duration(days: 7);
    } else {
      return Duration(days: int.tryParse(text) ?? 14);
    }
  }

  void _submitProposal() {
    if (_formKey.currentState!.validate()) {
      final newProject = Project(
        title: widget.project.title,
        jobType: widget.project.jobType,
        details: widget.project.details,
        deliveryTime: _timeController.text,
        requirements: widget.project.requirements,
        acceptedPrice: double.parse(_priceController.text),
        startDate: DateTime.now(),
        endDate: DateTime.now().add(_parseDuration(_timeController.text)),
      );
      Navigator.pop(context);
    }
  }
}

class Project {
  final String title;
  final String jobType;
  final String details;
  final String deliveryTime;
  final List<String> requirements;
  final double acceptedPrice;
  final DateTime startDate;
  final DateTime endDate;

  Project({
    required this.title,
    required this.jobType,
    required this.details,
    required this.deliveryTime,
    required this.requirements,
    this.acceptedPrice = 0.0,
    required this.startDate,
    required this.endDate,
  });
}