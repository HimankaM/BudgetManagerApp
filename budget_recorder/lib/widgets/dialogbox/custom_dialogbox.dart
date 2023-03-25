import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text, route, btnColor;
  final Object arguments;

  const CustomDialogBox({
    Key? key,
    required this.title,
    required this.descriptions,
    required this.text,
    required this.route,
    required this.btnColor,
    required this.arguments,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final double padding = 20;
  final double avatarRadius = 45;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: padding,
            top: avatarRadius + padding,
            right: padding,
            bottom: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //progress bar

              //end progress bar-------
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                // ignore: deprecated_member_use
                child: TextButton(
                  onPressed: () {
                    widget.route == ""
                        ? Navigator.pop(context, false) //close dialog box
                        :
                        Navigator.of(context).popUntil(ModalRoute.withName(widget.route));
                        // : Navigator.of(context).pushNamedAndRemoveUntil(
                        //     widget.route,
                        //     (Route<dynamic> route) => false,
                        //     arguments: widget.arguments
                        //   );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.purpleAccent,
                    backgroundColor: widget.btnColor == ""
                      ? Colors.green[900]
                      : Colors.red[900], // Background Color
                      foregroundColor: Colors.amberAccent,),
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
                child: Image.asset("assets/images/splash_logo.png")),
          ),
        ),
      ],
    );
  }
}
