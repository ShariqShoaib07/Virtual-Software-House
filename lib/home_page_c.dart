import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'projects_page_c.dart' as projectsPage;
import 'project_data.dart' as projectData;

class HomePageC extends StatefulWidget {
  const HomePageC({super.key});

  @override
  State<HomePageC> createState() => _HomePageCState();
}

class _HomePageCState extends State<HomePageC> {
  int _selectedTab = 0; // 0 = Not Started, 1 = Active, 2 = Completed
  final Color primaryColor = const Color(0xFF38E54D); // Green color

 final List<projectData.Project> _notStartedProjects = [
   projectData.Project(
     title: "Fitness App Development",
     details: "Develop a fitness tracking app with workout plans and progress tracking.",
     deliveryTime: "1 month",
     requirements: ["Flutter", "Firebase", "Health API"],
     acceptedPrice: 1800.00,
     startDate: DateTime.now().add(const Duration(days: 7)),
     endDate: DateTime.now().add(const Duration(days: 37)),
     jobType: "Development",
     status: projectData.ProjectStatus.notStarted,
   ),
 ];

 final List<projectData.Project> _activeProjects = [
   projectData.Project(
     title: "E-commerce App Development",
     details: "Developing a complete e-commerce app with payment integration.",
     deliveryTime: "2 Weeks Left",
     requirements: ["Flutter", "Firebase", "Payment Gateway"],
     acceptedPrice: 1200.00,
     startDate: DateTime.now().subtract(const Duration(days: 14)),
     endDate: DateTime.now().add(const Duration(days: 14)),
     jobType: "Development",
     status: projectData.ProjectStatus.notStarted,
   ),
 ];

 final List<projectData.Project> _completedProjects = [
   projectData.Project(
     title: "Restaurant Management System",
     details: "Built a complete restaurant management solution.",
     deliveryTime: "Completed",
     requirements: ["Flutter", "Node.js", "MongoDB"],
     acceptedPrice: 1500.00,
     startDate: DateTime.now().subtract(const Duration(days: 60)),
     endDate: DateTime.now().subtract(const Duration(days: 30)),
     jobType: "Development",
     status: projectData.ProjectStatus.notStarted,
   ),
 ];

  Widget _buildProjectTypeTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildTabButton("Not Started", 0)),
        const SizedBox(width: 8),
        Expanded(child: _buildTabButton("Active", 1)),
        const SizedBox(width: 8),
        Expanded(child: _buildTabButton("Completed", 2)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
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
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "DASHBOARD",
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
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white, size: 28),
                onPressed: () {
                  _showClientNotifications(context);
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProjectTypeTabs(),
                  const SizedBox(height: 20),
                  _buildProjectsList(),
                  const SizedBox(height: 30),
                  _buildProjectsStatusChart(),
                  const SizedBox(height: 30),
                  _buildPaymentsChart(),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _selectedTab == index ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: _selectedTab == index ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsList() {
    List<projectData.Project> projectsToShow;
    String title;

    switch (_selectedTab) {
      case 0:
        projectsToShow = [..._notStartedProjects, ...projectData.ProjectData.notStartedProjects];
        title = "Not Started Projects";
        break;
      case 1:
        projectsToShow = _activeProjects;
        title = "Active Projects";
        break;
      case 2:
        projectsToShow = _completedProjects;
        title = "Completed Projects";
        break;
      default:
        projectsToShow = [];
        title = "Projects";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        if (projectsToShow.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "No projects found",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...projectsToShow.map((project) => _buildProjectCard(project)).toList(),
      ],
    );
  }

  Widget _buildProjectCard(projectData.Project project) {
    final progress = _calculateProjectProgress(project);
    final isCompleted = _selectedTab == 2;
    final isNotStarted = _selectedTab == 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      color: Colors.white, // Explicitly set card color to white
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showProjectDetails(context, project);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (!isNotStarted)
                LinearProgressIndicator(
                  value: isCompleted ? 1.0 : progress,
                  backgroundColor: Colors.grey[200],
                  color: primaryColor,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              if (!isNotStarted) const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isNotStarted
                        ? "Starting soon"
                        : isCompleted
                        ? "100% Complete"
                        : "${(progress * 100).toStringAsFixed(0)}% Complete",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    project.deliveryTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "\$${project.acceptedPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateProjectProgress(projectData.Project project) {
    final totalDuration = project.endDate.difference(project.startDate).inDays;
    final daysPassed = DateTime.now().difference(project.startDate).inDays;
    return (daysPassed / totalDuration).clamp(0.0, 1.0);
  }

  Widget _buildProjectsStatusChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Projects Status",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
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
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 25,
                  color: const Color(0xFF2196F3),
                  title: '25%',
                  radius: 50,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  value: 35,
                  color: const Color(0xFF4CAF50),
                  title: '35%',
                  radius: 50,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  value: 40,
                  color: const Color(0xFFFFC107),
                  title: '40%',
                  radius: 50,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildChartLegend("In Progress", const Color(0xFF2196F3)),
            _buildChartLegend("Completed", const Color(0xFF4CAF50)),
            _buildChartLegend("Not Started", const Color(0xFFFFC107)),
          ],
        ),
      ],
    );
  }

  Widget _buildChartLegend(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPaymentsChart() {
    final paymentsData = [
      MonthlyData(1, 1200, primaryColor),
      MonthlyData(2, 1800, primaryColor),
      MonthlyData(3, 2200, primaryColor),
      MonthlyData(4, 1500, primaryColor),
      MonthlyData(5, 3000, primaryColor),
      MonthlyData(6, 2500, primaryColor),
      MonthlyData(7, 2800, primaryColor),
      MonthlyData(8, 3200, primaryColor),
      MonthlyData(9, 4000, primaryColor),
      MonthlyData(10, 3500, primaryColor),
      MonthlyData(11, 3800, primaryColor),
      MonthlyData(12, 4500, primaryColor),
    ];

    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payments This Year",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
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
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.blueGrey,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '\$${rod.toY.toStringAsFixed(0)}',
                      const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt() - 1;
                      if (index >= 0 && index < monthNames.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            monthNames[index],
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      return const Text('');
                    },
                    reservedSize: 20,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '\$${value.toInt()}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: paymentsData
                  .map((data) => BarChartGroupData(
                x: data.month.toInt(),
                barRods: [
                  BarChartRodData(
                    toY: data.value.toDouble(),
                    color: data.color,
                    width: 16,
                    borderRadius: BorderRadius.circular(4),
                  )
                ],
              ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _showProjectDetails(BuildContext context, projectData.Project project) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                project.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                project.details,
                style: TextStyle(
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailCard(
                      "Status",
                      project.deliveryTime,
                      Icons.access_time,
                      primaryColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDetailCard(
                      "Amount",
                      "\$${project.acceptedPrice.toStringAsFixed(2)}",
                      Icons.attach_money,
                      primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Requirements",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.requirements
                    .map((req) => _buildRequirementChip(req))
                    .toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
        ),
      ),
    );
  }

  void _showClientNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildNotificationItem(
                      "Project Update",
                      "Developer submitted progress for E-commerce App",
                      Icons.update,
                      primaryColor,
                    ),
                    _buildNotificationItem(
                      "Payment Received",
                      "Invoice #1234 has been paid",
                      Icons.payment,
                      Colors.green,
                    ),
                    _buildNotificationItem(
                      "Project Completed",
                      "Restaurant Management System is ready for review",
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(String title, String message, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class MonthlyData {
  final num month;
  final int value;
  final Color color;

  MonthlyData(this.month, this.value, this.color);
}