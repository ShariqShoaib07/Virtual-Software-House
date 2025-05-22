//home_page.dart
import 'package:flutter/material.dart';
import 'projects_page.dart';
import 'package:fl_chart/fl_chart.dart';

// Move MonthlyData class outside of _HomePageState
class MonthlyData {
  final num month;
  final int value;
  final Color color;

  MonthlyData(this.month, this.value, this.color);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  final List<Project> _ongoingProjects = [
    Project(
      title: "E-commerce App Development",
      jobType: "In-person",
      details: "Developing a complete e-commerce app with payment integration.",
      deliveryTime: "2 Weeks Left",
      requirements: ["Flutter", "Firebase", "Payment Gateway"],
      acceptedPrice: 1200.00,
      startDate: DateTime.now().subtract(const Duration(days: 14)),
      endDate: DateTime.now().add(const Duration(days: 14)),
    ),
    Project(
      title: "Portfolio Website Redesign",
      jobType: "Remote",
      details: "Redesigning an existing portfolio website with modern UI.",
      deliveryTime: "1 Week Left",
      requirements: ["HTML/CSS", "JavaScript", "UI Design"],
      acceptedPrice: 800.00,
      startDate: DateTime.now().subtract(const Duration(days: 7)),
      endDate: DateTime.now().add(const Duration(days: 7)),
    ),
  ];

  final List<Project> _completedProjects = [
    Project(
      title: "Restaurant Management System",
      jobType: "Hybrid",
      details: "Built a complete restaurant management solution.",
      deliveryTime: "Completed",
      requirements: ["Flutter", "Node.js", "MongoDB"],
      acceptedPrice: 1500.00,
      startDate: DateTime.now().subtract(const Duration(days: 60)),
      endDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
  ];

  Widget _buildProjectTypeTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildTabButton("Ongoing", 0)),
        const SizedBox(width: 8),
        Expanded(child: _buildTabButton("Completed", 1)),
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
                    color: Colors.black.withOpacity(0.3), // Optional overlay
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
                  _showNotifications(context);
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
                  _buildProjectsChart(),
                  const SizedBox(height: 30),
                  _buildEarningsChart(),
                  const SizedBox(height: 30),
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
          color: _selectedTab == index ? const Color(0xFF38E54D) : Colors.transparent,
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
    List<Project> projectsToShow = [];

    if (_selectedTab == 0) {
      projectsToShow = _ongoingProjects;
    } else if (_selectedTab == 1) {
      projectsToShow = _completedProjects;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedTab == 0 ? "Ongoing Projects" : "Completed Projects",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        ...projectsToShow.map((project) => _buildProjectCard(project)).toList(),
      ],
    );
  }

  Widget _buildProjectCard(Project project) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
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
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                ],
              ),
              const SizedBox(height: 8),
              Text(
                project.details,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailChip(
                    Icons.access_time,
                    project.deliveryTime,
                    Colors.blue,
                  ),
                  Text(
                    "\$${project.acceptedPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF38E54D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsChart() {
    final projectData = [
      MonthlyData(1, 3, const Color(0xFF38E54D)),
      MonthlyData(2, 5, const Color(0xFF38E54D)),
      MonthlyData(3, 7, const Color(0xFF38E54D)),
      MonthlyData(4, 6, const Color(0xFF38E54D)),
      MonthlyData(5, 8, const Color(0xFF38E54D)),
      MonthlyData(6, 4, const Color(0xFF38E54D)),
      MonthlyData(7, 5, const Color(0xFF38E54D)),
      MonthlyData(8, 7, const Color(0xFF38E54D)),
      MonthlyData(9, 6, const Color(0xFF38E54D)),
      MonthlyData(10, 8, const Color(0xFF38E54D)),
      MonthlyData(11, 9, const Color(0xFF38E54D)),
      MonthlyData(12, 10, const Color(0xFF38E54D)),
    ];

    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Projects This Year",
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
              gridData: FlGridData(show: false), // Hide grid lines
              borderData: FlBorderData(show: false),
              barGroups: projectData
                  .map((data) => BarChartGroupData(
                x: data.month.toInt(),
                barRods: [
                  BarChartRodData(
                    toY: data.value.toDouble(),
                    color: data.color,
                    width: 12,
                    borderRadius: BorderRadius.circular(4),
                  )
                ],
              ))
                  .toList(),
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
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsChart() {
    final earningsData = [
      MonthlyData(1, 2500, const Color(0xFF2196F3)),
      MonthlyData(2, 3800, const Color(0xFF2196F3)),
      MonthlyData(3, 4200, const Color(0xFF2196F3)),
      MonthlyData(4, 3900, const Color(0xFF2196F3)),
      MonthlyData(5, 4500, const Color(0xFF2196F3)),
      MonthlyData(6, 3200, const Color(0xFF2196F3)),
      MonthlyData(7, 4100, const Color(0xFF2196F3)),
      MonthlyData(8, 4800, const Color(0xFF2196F3)),
      MonthlyData(9, 5200, const Color(0xFF2196F3)),
      MonthlyData(10, 5800, const Color(0xFF2196F3)),
      MonthlyData(11, 6200, const Color(0xFF2196F3)),
      MonthlyData(12, 7000, const Color(0xFF2196F3)),
    ];

    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Earnings This Year",
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
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false), // Hide grid lines
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: earningsData
                      .map((e) => FlSpot(e.month.toDouble(), e.value.toDouble()))
                      .toList(),
                  isCurved: true,
                  color: const Color(0xFF2196F3),
                  belowBarData: BarAreaData(
                    show: true,
                    color: const Color(0xFF2196F3).withOpacity(0.3),
                  ),
                  dotData: FlDotData(show: false),
                ),
              ],
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
                    reservedSize: 28,
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
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ],
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

  void _showProjectDetails(BuildContext context, Project project) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.6,
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
              const SizedBox(height: 10),
              Text(
                project.jobType,
                style: TextStyle(
                  color: _getJobTypeColor(project.jobType),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                project.details,
                style: TextStyle(
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailCard(
                      "Time Left",
                      project.deliveryTime,
                      Icons.access_time,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDetailCard(
                      "Amount",
                      "\$${project.acceptedPrice.toStringAsFixed(2)}",
                      Icons.attach_money,
                      const Color(0xFF38E54D),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38E54D),
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

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.4,
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
                      "New project request",
                      "Client requested e-commerce app development",
                      Icons.notifications_active,
                      Colors.blue,
                    ),
                    _buildNotificationItem(
                      "Payment received",
                      "\$1200 received for Portfolio Website project",
                      Icons.payment,
                      Colors.green,
                    ),
                    _buildNotificationItem(
                      "Project update",
                      "Client requested changes to Restaurant System",
                      Icons.update,
                      Colors.orange,
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
      onTap: () {},
    );
  }
}

class ProjectChartData {
  final String month;
  final int value;

  ProjectChartData(this.month, this.value);
}

class EarningsChartData {
  final String month;
  final int value;

  EarningsChartData(this.month, this.value);
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
