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
        color: Color(0xFF0F3D2C),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.5),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.greenAccent, size: 40),
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
                    style: GoogleFonts.orbitron(
                      fontSize: 28,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              Text(
                label,
                style: TextStyle(color: Colors.white70),
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
      title: '', // no label
      titlePositionPercentageOffset: 0.0,
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 3,
        centerSpaceRadius: 40,
        sections: [
          _section(25, Colors.blueAccent),
          _section(48, Colors.greenAccent),
          _section(10, Colors.orangeAccent),
          _section(5, Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        SizedBox(width: 6),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 14)),
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
                        style: TextStyle(
                          color: Colors.greenAccent,
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
              color: Colors.greenAccent,
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
      backgroundColor: Color(0xFF011B10),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'DASHBOARD',
                  style: GoogleFonts.orbitron(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildAnimatedCounter("Profits (USD)", 120000, Icons.attach_money),
              _buildAnimatedCounter("Projects Completed", 48, Icons.task_alt),
              SizedBox(height: 28),

              // Pie Chart Section
              Text("📊 Project Status",
                  style: GoogleFonts.orbitron(
                      fontSize: 18, color: Colors.greenAccent)),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFF0F3D2C),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    )
                  ],
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
                          _buildLegend("Received", Colors.blueAccent),
                          SizedBox(width: 16),
                          _buildLegend("Completed", Colors.greenAccent),
                          SizedBox(width: 16),
                          _buildLegend("Ongoing", Colors.orangeAccent),
                          SizedBox(width: 16),
                          _buildLegend("Failed", Colors.redAccent),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28),
              Text("💹 Monthly Profits",
                  style: GoogleFonts.orbitron(
                      fontSize: 18, color: Colors.greenAccent)),
              SizedBox(height: 10),
              Container(
                height: 220,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF0F3D2C),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: _buildBarChart(profitsData, months),
              ),

              SizedBox(height: 28),
              Text("📈 Projects per Month",
                  style: GoogleFonts.orbitron(
                      fontSize: 18, color: Colors.greenAccent)),
              SizedBox(height: 10),
              Container(
                height: 220,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF0F3D2C),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: _buildBarChart(profitsData, months),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
