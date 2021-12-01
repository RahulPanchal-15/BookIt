import 'package:assignment_practice/screens/notifications.dart';
import 'package:flutter/material.dart';

import './home.dart';
import './profile.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return
        // bool? isDone = auth.isDone;
        // print(isDone);
        WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState!.maybePop();

        print(
            'isFirstRouteInCurrentTab: ' + isFirstRouteInCurrentTab.toString());

        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple[900],
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.location_on),
            //   label: 'Venue',
            // ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Stack(children: [
          _buildOffstageNavigator(0),
          _buildOffstageNavigator(1),
          _buildOffstageNavigator(2),
        ]),
      ),
    );
  }

  // void _next() {
  //   Navigator.pushNamed(context, '/owner');
  // }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _goToTab(int tabNo) {
    setState(() {
      _selectedIndex = tabNo;
    });
  }

  void _goToOwnerRegister() {
    Navigator.pushReplacementNamed(context, '/owner');
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          HomePage(
              changeBottomTab: () => _goToTab(2),
              goToLogin: _goToLogin,
              goToProfile: () => _goToTab(1)),
          ProfilePage(
            changeBottomTab: () => _goToTab(0),
            onClick: _goToLogin,
          ),
          Notifications(redirect: _goToOwnerRegister, goToLogin: _goToLogin),
          // VenueDetailPage(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}
