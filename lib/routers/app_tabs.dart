import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroll/features/bonfire/ui/screens/bonfire_screen.dart';
import 'package:stroll/features/chat/ui/screens/chat_screen.dart';
import 'package:stroll/features/match/ui/screens/match_screen.dart';
import 'package:stroll/features/profile/ui/screens/profile_screen.dart';

class AppTabs extends StatefulWidget {
  const AppTabs({super.key});

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> {
  int _selectedIndex = 1;

  final List<Widget> _screens = [
    MatchScreen(),
    BonfireScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        indicatorColor: Color.fromRGBO(15, 17, 21, 1),
        onDestinationSelected: _onTabSelected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Color.fromRGBO(15, 17, 21, 1),
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/match.svg',
              width: 33.0,
              height: 33.0,
            ),
            label: "Match",
          ),
          NavigationDestination(
            icon: Badge(
              label: Text(
                '10',
                style: TextStyle(
                  color: Color.fromRGBO(181, 178, 255, 1),
                  fontSize: 2.0,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              backgroundColor: Color.fromRGBO(181, 178, 255, 1),
              largeSize: 12.0,
              child: SvgPicture.asset(
                'assets/icons/bonfire.svg',
                width: 33.0,
                height: 33.0,
              ),
            ),
            label: "Bonfire",
          ),
          NavigationDestination(
            icon: Badge(
              label: Text(
                '10',
                style: TextStyle(
                  color: Color.fromRGBO(15, 17, 21, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 7.0,
                ),
              ),
              largeSize: 14.0,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              backgroundColor: Color.fromRGBO(181, 178, 255, 1),
              child: SvgPicture.asset(
                'assets/icons/chat.svg',
                width: 33.0,
                height: 33.0,
              ),
            ),
            label: "chat",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/user.svg',
              width: 50.0,
              height: 50.0,
            ),
            label: "User",
          ),
        ],
      ),
    );
  }
}
