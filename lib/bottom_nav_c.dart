//bottom_nav_c.dart
import 'package:flutter/material.dart';
import 'home_page_c.dart';
import 'home_page.dart';
import 'profile_page_c.dart';
import 'projects_page_c.dart';
import 'projects_page.dart';
import 'tools_page.dart';
import 'settings_page.dart';

class BottomNav_c extends StatefulWidget {
  const BottomNav_c({Key? key}) : super(key: key);

  @override
  State<BottomNav_c> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav_c> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePageC(),
    ProfilePageC(),
    ProjectsPageC(),
    ToolsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, -5)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF38E54D),
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontSize: 10),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 0
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.home_outlined, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.home, size: 24),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 1
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.person_outline, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.person, size: 24),
                ),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 2
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.work_outline, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.work, size: 24),
                ),
                label: 'Projects',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 3
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.build_outlined, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.build, size: 24),
                ),
                label: 'Tools',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 4
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.settings_outlined, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.settings, size: 24),
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}