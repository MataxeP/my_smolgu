import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ui/navigation/home_page.dart';
import 'ui/navigation/modules_page.dart';
import 'ui/navigation/navigation_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedItemIndex = 1;

  final List pages = [
    const NavigationPage(),
    const HomePage(),
    const ModulesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          selectedIconTheme: IconThemeData(
              color: Get.isDarkMode ? Colors.white : const Color(0XFF343E87)),
          currentIndex: _selectedItemIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _selectedItemIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(Icons.map_rounded),
              icon: Icon(Icons.map_outlined),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(Icons.people_alt_rounded),
              icon: Icon(Icons.people_alt_outlined),
            ),
          ],
        ),
        body: pages[_selectedItemIndex]);
  }
}
