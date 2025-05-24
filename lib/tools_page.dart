//tools_page.dart
import 'package:flutter/material.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDescController = TextEditingController();
  final TextEditingController _featuresController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'SRS Generator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(context).padding.bottom + 24, // Add bottom padding
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // Ensure minimum height
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Software Requirements Specification',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 32),

                  // Project Information Section
                  _buildSectionHeader('Project Information'),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _projectNameController,
                    label: 'Project Name',
                    hint: 'Enter project name',
                    icon: Icons.business_outlined,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _projectDescController,
                    label: 'Project Description',
                    hint: 'Brief description of the project',
                    icon: Icons.description_outlined,
                    maxLines: 4,
                  ),

                  // Features Section
                  SizedBox(height: 32),
                  _buildSectionHeader('Key Features'),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _featuresController,
                    label: 'Features (comma separated)',
                    hint: 'Feature 1, Feature 2, Feature 3',
                    icon: Icons.list_outlined,
                    maxLines: 3,
                  ),

                  // Requirements Section
                  SizedBox(height: 32),
                  _buildSectionHeader('Requirements'),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _requirementsController,
                    label: 'Functional Requirements',
                    hint: 'List each requirement on a new line',
                    icon: Icons.checklist_outlined,
                    maxLines: 6,
                  ),

                  // Generate Button
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _generateSRS,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF38E54D),
                      minimumSize: Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'GENERATE SRS DOCUMENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 20), // Extra bottom space
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Color(0xFF38E54D)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: maxLines > 1 ? 16 : 0,
        ),
      ),
    );
  }

  void _generateSRS() {
    if (_projectNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a project name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Here you would implement the actual SRS generation logic
    // For now, we'll just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('SRS Document Generated Successfully'),
        backgroundColor: Colors.green,
      ),
    );

    // You could also navigate to a preview screen here:
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => SrsPreviewScreen(
    //     projectName: _projectNameController.text,
    //     description: _projectDescController.text,
    //     features: _featuresController.text,
    //     requirements: _requirementsController.text,
    //   ),
    // ));
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _projectDescController.dispose();
    _featuresController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }
}