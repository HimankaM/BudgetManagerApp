import 'package:flutter/material.dart';

//
// Loading indicator for async and other operations
//

class OperationLoader extends StatelessWidget {
  const OperationLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
            ),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}
