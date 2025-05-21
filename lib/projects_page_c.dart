import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'project_data.dart';


class ProjectsPageC extends StatefulWidget {
  const ProjectsPageC({super.key});

  @override
  State<ProjectsPageC> createState() => _ProjectsPageCState();
}

class _ProjectsPageCState extends State<ProjectsPageC> {
  List<Project> projects = [
    Project(
      title: "E-commerce App Development",
      details: "Develop a complete e-commerce app with product listings, cart functionality, and secure payment processing.",
      deliveryTime: "1 Month",
      requirements: ["Flutter", "Firebase", "Payment Gateway", "UI/UX Design"],
      acceptedPrice: 1500.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      srsFile: 'sample_srs1.pdf',
      jobType: "Full-time",
      status: ProjectStatus.notStarted,
    ),
    Project(
      title: "Portfolio Website",
      details: "Create a modern portfolio website with responsive design, animations, and contact form functionality.",
      deliveryTime: "2 Weeks",
      requirements: ["HTML/CSS", "JavaScript", "Responsive Design", "Animation"],
      acceptedPrice: 800.00,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 14)),
      srsFile: 'sample_srs2.pdf',
      jobType: "Part-time",
      status: ProjectStatus.notStarted,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Projects", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newProject = await showAddProjectDialog(context);
              if (newProject != null) {
                setState(() {
                  projects.add(newProject);
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return buildProjectCard(project);
          },
        ),
      ),
    );
  }

  Future<Project?> showAddProjectDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final detailsController = TextEditingController();
    final priceController = TextEditingController();
    final deliveryTimeController = TextEditingController();
    final requirementsController = TextEditingController();
    PlatformFile? srsFile;

    return await showDialog<Project>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add New Project", style: TextStyle(fontWeight: FontWeight.bold)),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildTextFieldWithCheckbox(
                        controller: titleController,
                        label: "Project Title",
                        validator: (value) => value?.isEmpty ?? true ? "Required" : null,
                      ),
                      const SizedBox(height: 12),
                      buildTextFieldWithCheckbox(
                        controller: detailsController,
                        label: "Project Details",
                        maxLines: 1,
                        validator: (value) => value?.isEmpty ?? true ? "Required" : null,
                      ),
                      const SizedBox(height: 12),
                      buildTextFieldWithCheckbox(
                        controller: priceController,
                        label: "Project Price (\$)",
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true ? "Required" : null,
                      ),
                      const SizedBox(height: 12),
                      buildTextFieldWithCheckbox(
                        controller: deliveryTimeController,
                        label: "Delivery Time",
                        validator: (value) => value?.isEmpty ?? true ? "Required" : null,
                      ),
                      const SizedBox(height: 12),
                      buildTextFieldWithCheckbox(
                        controller: requirementsController,
                        label: "Requirements (comma separated)",
                        hintText: "Flutter, Firebase, UI/UX",
                        validator: (value) => value?.isEmpty ?? true ? "Required" : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Upload SRS Document",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'doc', 'docx'],
                          );
                          if (result != null) {
                            setState(() {
                              srsFile = result.files.first;
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          srsFile == null ? "Choose File" : srsFile!.name,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                  ),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newProject = Project(
                        title: titleController.text,
                        details: detailsController.text,
                        deliveryTime: deliveryTimeController.text,
                        requirements: requirementsController.text
                            .split(',')
                            .map((e) => e.trim())
                            .where((e) => e.isNotEmpty)
                            .toList(),
                        acceptedPrice: double.parse(priceController.text),
                        startDate: DateTime.now(),
                        endDate: DateTime.now().add(const Duration(days: 30)),
                        srsFile: srsFile?.name,
                        jobType: "Freelance",
                        status: ProjectStatus.pending,
                      );
                      ProjectData.addProject(newProject);
                      Navigator.pop(context, newProject);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Add Project", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildTextFieldWithCheckbox({
    required TextEditingController controller,
    required String label,
    String? hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, right: 8),
          child: Icon(Icons.check_box_outline_blank, size: 24, color: Colors.grey[400]),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              hintText: hintText,
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget buildProjectCard(Project project) {
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
              Text(
                "\$${project.acceptedPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.requirements
                    .take(3)
                    .map((req) => buildRequirementChip(req))
                    .toList(),
              ),
              const Spacer(),
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

  Widget buildRequirementChip(String text) {
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
          if (widget.project.srsFile != null)
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildDetailPill(
                        Icons.attach_money,
                        "\$${widget.project.acceptedPrice.toStringAsFixed(2)}",
                        Colors.green,
                      ),
                      const SizedBox(width: 8),
                      _buildDetailPill(
                        Icons.access_time,
                        widget.project.deliveryTime,
                        Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
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
          ],
        ),
      ),
    );
  }

  Future<void> _downloadSRS(BuildContext context) async {
    setState(() {
      _isDownloading = true;
    });

    try {
      // For demo purposes, we'll simulate downloading the SRS
      // In a real app, you would download from a server or access the actual file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${widget.project.srsFile}');

      // Create a dummy file for demo
      await file.writeAsString('This is a sample SRS document for ${widget.project.title}');

      // Open the file
      await OpenFile.open(file.path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("SRS document downloaded: ${widget.project.srsFile}"),
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
}
