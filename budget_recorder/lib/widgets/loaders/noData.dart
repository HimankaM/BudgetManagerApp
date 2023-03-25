import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Image.asset("assets/images/noData.png"),
          const Text(
            "No Data",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      )),
    );
  }
}
