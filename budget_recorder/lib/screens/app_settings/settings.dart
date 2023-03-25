import 'package:budget_recorder/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:budget_recorder/data/currency_data.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const AppBarTitleText(title: 'Settings'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/help");
              },
              child: const Icon(
                Icons.info_outline,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                // Currency ======================================================
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Currency Settings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Icon(
                        Icons.currency_exchange_rounded,
                        size: 30,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
                //======================================================
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  hint: const Text("Currency"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value: themeChange.appCurrency,
                  onChanged: (String? newValue) {
                    print("newValue:${newValue}");
                    themeChange.setAppCurrency = newValue.toString();
                  },
                  items: currenciesList
                      .map<DropdownMenuItem<String>>((Currency currency) {
                    return DropdownMenuItem<String>(
                      value: currency.name,
                      child: Text(currency.name),
                    );
                  }).toList(),
                  // onChanged: (String? obj) {
                  //   if (obj != null) {
                  //     themeChange.setAppCurrency = obj;
                  //   }
                  //   // setState(() {
                  //   //   _selectedCurrency = newValue!;
                  //   // });
                  //   // print("newValue:${newValue}");
                  //   // //save app currency
                  //   // saveAppCurrency(newValue);
                  // },

                  //==============================================
                  // items: <String>['LKR', 'AUD', 'USD']
                  //     .map<DropdownMenuItem<String>>((String value) {
                  //   return DropdownMenuItem<String>(
                  //     value: value,
                  //     child: Text(value),
                  //   );
                  // }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Theme ======================================================
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Theme Settings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Icon(
                        Icons.color_lens,
                        size: 30,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dark Theme",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Switch(
                          value: themeChange
                              .darkTheme, //false - Light Theme | True - Dark Theme
                          activeTrackColor: Colors.black54,
                          activeColor: Colors.black,
                          onChanged: (bool value) {
                            themeChange.setDarkTheme = value;
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Feedback ======================================================
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Feedback",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Icon(
                        Icons.feedback_rounded,
                        size: 30,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/feedback");
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.blue[900],
                          ),
                        ),
                        child: const Text(
                          "Provide Feedback",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
