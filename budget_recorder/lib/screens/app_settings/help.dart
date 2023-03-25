import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const AppBarTitleText(title: 'Help'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/welcome_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "MY STASH",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        "Track Money",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Save Money",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.black54,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "How to use MY STASH",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  Text(
                    "MY STASH makes managing personal finances as easy as pie! "+
                    "Now easily record your personal and business financial transactions, "+
                    "generate spending reports, review your daily, weekly and monthly financial "+
                    "data and manage your assets with MY STASH's spending tracker and budget planner.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "\n* Transfer, direct debit and recurrence function Transfer between assets"+
                    " is possible, which makes your personal and business asset management more "+
                    " efficient. In addition, you can manage you a salary, insurance, term deposit"+
                    " and loan more easily by setting automatic transfer and recurrence.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
