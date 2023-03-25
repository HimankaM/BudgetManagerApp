import 'package:budget_recorder/widgets/text/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppFeedback extends StatelessWidget {
  const AppFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const AppBarTitleText(title: 'Feedback'),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //====================================================================
                // section 1
                const Text(
                  "MY STASH",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                const Text(
                  "MY STASH makes managing personal finances as easy as pie! " +
                      "Now easily record your personal and business financial transactions, " +
                      "generate spending reports, review your daily, weekly and monthly financial " +
                      "data and manage your assets with MY STASH's spending tracker and budget planner.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                //====================================================================
                // section 2
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Feedback",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GFIconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                      type: GFButtonType.solid,
                      shape: GFIconButtonShape.pills,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GFIconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.abc_outlined,
                      ),
                      type: GFButtonType.solid,
                      color: GFColors.SUCCESS,
                      shape: GFIconButtonShape.pills,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GFIconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.alternate_email_sharp,
                      ),
                      type: GFButtonType.solid,
                      color: GFColors.DANGER,
                      shape: GFIconButtonShape.pills,
                    ),
                  ],
                ),
                //====================================================================
                // section 3
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Web",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                Text(
                  "mystash@feedback.com",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
