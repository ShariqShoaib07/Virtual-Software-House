import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

class DeveloperHomePage extends StatefulWidget {
  @override
  _DeveloperHomePageState createState() => _DeveloperHomePageState();
}

class _DeveloperHomePageState extends State<DeveloperHomePage> {
  int profits = 0;
  int completedProjects = 0;
  final primaryGreen = Colors.lightGreenAccent[700]!;
  final backgroundColor = Colors.white;
  final cardColor = Colors.grey[50]!;
  final textColor = Colors.grey[900]!;

  @override
  void initState() {
    super.initState();
    _animateCounts();
  }

  void _animateCounts() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        if (profits < 120000) profits += 2000;
        if (completedProjects < 48) completedProjects += 1;
      });
      if (profits >= 120000 && completedProjects >= 48) timer.cancel();
    });
  }

  Widget _buildAnimatedCounter(String label, int targetValue, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryGreen!.withOpacity(0.1),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: primaryGreen.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen, size: 40),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: targetValue.toDouble()),
                duration: Duration(seconds: 3),
                curve: Curves.easeOutExpo,
                builder: (context, value, child) {
                  return Text(
                    value.toInt().toString(),
                    style: GoogleFonts.roboto(
                      fontSize: 28,
                      color: primaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              Text(
                label,
                style: GoogleFonts.roboto(
                  color: textColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PieChartSectionData _section(double value, Color color) {
    return PieChartSectionData(
      value: value,
      color: color,
      radius: 42,
      title: '',
      titlePositionPercentageOffset: 0.0,
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 3,
        centerSpaceRadius: 40,
        sections: [
          _section(25, Colors.blue[700]!),
          _section(48, primaryGreen!),
          _section(10, Colors.orange[700]!),
          _section(5, Colors.red[700]!),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        SizedBox(width: 6),
        Text(
            label,
            style: GoogleFonts.roboto(
                color: textColor,
                fontSize: 14
            )
        ),
      ],
    );
  }

  Widget _buildBarChart(List<double> values, List<String> labels) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                return Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: SizedBox(
                    width: 24,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        labels[value.toInt()],
                        style: GoogleFonts.roboto(
                          color: primaryGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(values.length, (i) {
          return BarChartGroupData(x: i, barRods: [
            BarChartRodData(
              toY: values[i],
              width: 10,
              color: primaryGreen!,
              borderRadius: BorderRadius.circular(4),
            )
          ]);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<double> profitsData = [10, 20, 40, 60, 80, 50, 30, 70, 90, 120, 100, 110];
    final List<double> projectsData = [1, 3, 2, 5, 4, 6, 3, 7, 8, 5, 6, 9];
    final months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'DASHBOARD',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildAnimatedCounter("Profits (USD)", 120000, Icons.attach_money),
              _buildAnimatedCounter("Projects Completed", 48, Icons.task_alt),
              SizedBox(height: 28),

              // Pie Chart Section
              Text(
                "Project Status",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: primaryGreen,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen!.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    )
                  ],
                  border: Border.all(
                    color: primaryGreen.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 180, child: _buildPieChart()),
                    SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegend("Received", Colors.blue[700]!),
                          SizedBox(width: 16),
                          _buildLegend("Completed", primaryGreen!),
                          SizedBox(width: 16),
                          _buildLegend("Ongoing", Colors.orange[700]!),
                          SizedBox(width: 16),
                          _buildLegend("Failed", Colors.red[700]!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28),
              Text(
                "Monthly Profits",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: primaryGreen,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen!.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    )
                  ],
                  border: Border.all(
                    color: primaryGreen.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: _buildBarChart(profitsData, months),
              ),

              SizedBox(height: 28),
              Text(
                "Projects per Month",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: primaryGreen,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen!.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    )
                  ],
                  border: Border.all(
                    color: primaryGreen.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: _buildBarChart(projectsData, months),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}