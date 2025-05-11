//profile_page.dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';// For FilePicker and FilePickerResult
import 'package:image_picker/image_picker.dart';
import 'dart:io';                                // For File class
import 'package:path/path.dart' as path;         // For path.basename

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _introController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();

  String? _profileImagePath;
  String? _cvPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF38E54D),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                children: [
                  Image.asset(
                    'assets/header_image.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3), // Optional overlay
                  ),
                ],
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "PROFILE",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black45,
                        offset: Offset(1, 1),
                      )],
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 20, // Add bottom padding
            ),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Picture Section
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: _profileImagePath != null
                              ? FileImage(File(_profileImagePath!))
                              : null,
                          child: _profileImagePath == null
                              ? Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey.shade400,
                          )
                              : null,
                        ),
                        GestureDetector(
                          onTap: _pickProfileImage,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF38E54D),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Personal Information Section
                    _buildSectionHeader('Personal Information'),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _firstNameController,
                            label: 'First Name',
                            hint: 'Enter first name',
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _middleNameController,
                            label: 'Middle Name',
                            hint: 'Enter middle name',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      hint: 'Enter last name',
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _introController,
                      label: 'Introduction',
                      hint: 'Tell us about yourself',
                      maxLines: 4,
                    ),
                    SizedBox(height: 24),

                    // Contact Information Section
                    _buildSectionHeader('Contact Information'),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hint: 'Enter phone number',
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _addressController,
                      label: 'Address',
                      hint: 'Enter your address',
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _cityController,
                            label: 'City',
                            hint: 'Enter city',
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _countryController,
                            label: 'Country',
                            hint: 'Enter country',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Skills Section
                    _buildSectionHeader('Skills'),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _skillsController,
                      label: 'Your Skills',
                      hint: 'Separate skills with commas',
                      maxLines: 3,
                    ),
                    SizedBox(height: 24),

                    // Experience Section
                    _buildSectionHeader('Experiences'),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _expController,
                      label: 'Your Experiences',
                      hint: 'Describe your work experiences',
                      maxLines: 5,
                    ),
                    SizedBox(height: 24),

                    // Documents Section
                    _buildSectionHeader('Documents'),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFileUploadButton(
                            label: 'Upload CV',
                            icon: Icons.upload_file,
                            filePath: _cvPath,
                            onPressed: _pickCVFile,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _githubController,
                            label: 'Github',
                            hint: 'github.com/username',
                            prefixIcon: Icons.code,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),

                    // Save Button
                    ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF38E54D),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'SAVE PROFILE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom), // Extra bottom space
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    IconData? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Color(0xFF38E54D))
            : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 0,
        ),
      ),
    );
  }

  Widget _buildFileUploadButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    String? filePath,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Color(0xFF38E54D),
              size: 28,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (filePath != null) ...[
              SizedBox(height: 4),
              Text(
                path.basename(filePath), // Changed from basename to path.basename
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _pickCVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _cvPath = result.files.single.path;
      });
    }
  }

  void _saveProfile() {
    // Implement save logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile saved successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _introController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _skillsController.dispose();
    _expController.dispose();
    _githubController.dispose();
    super.dispose();
  }
}