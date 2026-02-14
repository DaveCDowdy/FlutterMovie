import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double radius;
  final double spacing;
  final double fontSize;
  final EdgeInsetsGeometry? padding;

  const AppLogo({
    super.key,
    this.radius = 40,
    this.spacing = 8,
    this.fontSize = 24,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 32,
        bottom: 0,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage('assets/images/dash.jpg'),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: spacing),
          Text(
            "MovieDash",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

