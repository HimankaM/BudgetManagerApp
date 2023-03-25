import 'dart:convert';

import 'package:budget_recorder/screens/accounts/all_accounts.dart';
import 'package:budget_recorder/screens/app_settings/settings.dart';
import 'package:budget_recorder/screens/categories/all_categories.dart';
import 'package:budget_recorder/screens/transactions/transactions_tab_manager.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    // manage all transactions tabs
    TransactionTabsManager(),

    // Categories
    AllCategories(),

    // Accounts
    AllAccounts(),

    // Settings
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    RouteSettings? rs = ModalRoute.of(context)?.settings;

    if (rs!.arguments != null) {
      final Map arguments = rs.arguments as Map;
      int tabIndex = 0;
      // print(arguments["tabIndex"]);
      tabIndex = arguments["tabIndex"];
      _selectedIndex = tabIndex;
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 40,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        //selected menu item color
        selectedItemColor: Theme.of(context).primaryColor,
        //menu items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_sharp),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
