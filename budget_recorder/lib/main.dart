import 'package:budget_recorder/models/SharedPreference.dart';
import 'package:budget_recorder/providers/ThemeProvider.dart';
import 'package:budget_recorder/screens/accounts/account_summary.dart';
import 'package:budget_recorder/screens/accounts/manage_accounts.dart';
import 'package:budget_recorder/screens/app_settings/feedback.dart';
import 'package:budget_recorder/screens/app_settings/help.dart';
import 'package:budget_recorder/screens/categories/manage_category.dart';
import 'package:budget_recorder/screens/home.dart';
import 'package:budget_recorder/screens/transactions/manage_transactions.dart';
import 'package:budget_recorder/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final AppSharedPreferences _appSharedPreference;
  const MyApp({Key? key})
      : _appSharedPreference = const AppSharedPreferences(),
        super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  void getSavedAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await widget._appSharedPreference.getAppTheme();
  }

  void getSavedAppCurrency() async {
    themeChangeProvider.setAppCurrency =
        await widget._appSharedPreference.getAppCurrency();
  }

  @override
  initState() {
    super.initState();
    //get app theme data
    getSavedAppTheme();
    //get app currency
    getSavedAppCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MY STASH",
          theme: ThemeData(
            //Default brightness and colors.
            brightness: themeChangeProvider.darkTheme
                ? Brightness.dark
                : Brightness.light,
            primaryColor: Colors.amber[800], //use -> Theme.of(context).primaryColor

            //Default font family.
            fontFamily: 'Sen',
            //dark theme
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => Welcome(),
            '/home': (context) => const Home(),
            '/account/manage': (context) => const ManageAccounts(),
            '/account/summary': (context) => const AccountSummary(),
            '/category/manage': (context) => const MangeCategoryData(),
            '/transaction/manage': (context) => const ManageTransactions(),
            '/help': (context) => const Help(),
            '/feedback': (context) => const AppFeedback(),
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
          ],
        ),
      ),
    );
  }
}
