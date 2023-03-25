import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: 
        Column(
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
                            height: 80,
                          ),
                          // Text(
                          //   "MY STASH",
                          //   style: TextStyle(
                          //     fontSize: 35,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // )
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
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 35,
                                ),

                                Text(
                                  "MY STASH",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    ),
                                    )
                                // Text(
                                //   "Track Money",
                                //   style: TextStyle(
                                //     fontSize: 30,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.white,
                                //   ),
                                // )
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  height: 5,
                                ),
                                // Text(
                                //   "Save Money",
                                //   style: TextStyle(
                                //     fontSize: 30,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.white,
                                //   ),
                                // )
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
    );
  }
}
