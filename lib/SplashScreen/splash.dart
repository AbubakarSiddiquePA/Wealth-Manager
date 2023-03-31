import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/models/category/category_model.dart';

import '../Onboarding/on_board.dart';
import '../screens/home/screen_home.dart';

class SplashOne extends StatefulWidget {
  const SplashOne({super.key});

  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {
  @override
  void initState() {
    Splashscreens.getdata().values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
        backgroundColor: const Color.fromARGB(255, 17, 163, 176),
        duration: 4000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: Splashscreens.getdata().values.isEmpty
            ? const OnBoard()
            : ScreenHome(),
        splash: Scaffold(
          backgroundColor: const Color.fromARGB(255, 17, 163, 176),
          body: Wrap(
            children: [
              Center(
                child: Text(
                  'Wealth Manager',
                  style: GoogleFonts.acme(fontSize: 40, color: Colors.white),
                ),
              ),
              const Center(
                child: Text(
                  'version 1.0.1',
                  style: TextStyle(color: Color.fromARGB(255, 225, 214, 214)),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                  child: Image.asset(
                'lib/assets/images/output-onlinegiftools (9).gif',
                width: 50,
                height: 100,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
