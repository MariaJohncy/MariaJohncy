import 'package:amazon_clone/Utils/data.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          stops: [0.0,1.0],
          tileMode: TileMode.clamp,
          ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(12.0),
          child: Image.asset(amazonLogo),
          ),
          const Center(
          child: SizedBox(
            height: 10,
            child: Text("Work hard, Have fun, Make History",
            style: TextStyle(
              fontSize: 30,
              letterSpacing: 2.5,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}