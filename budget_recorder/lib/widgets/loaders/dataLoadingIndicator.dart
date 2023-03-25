import 'package:flutter/material.dart';

class DataLoadingIndicator extends StatelessWidget {
  const DataLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.infinity,
        ),
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
