import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:money_manager_db/screens/home/screen_home.dart';

import '../models/category/splash functions/splash_functions.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Image.asset('lib/assets/images/output-onlinegiftools (2).gif'),
        title: 'Save your Money Orderly',
        body:
            'this app helps you save your money orderly to achieve financial stability and reach your long-term goals',
        // footer: const Text('wealth manager'),
      ),
      PageViewModel(
        image: Image.asset('lib/assets/images/onboarding2image.gif'),
        title: 'Its all about your Financial Management',
        body:
            'hear comes your resource for a well planned financial management needs',
        // footer: const Text('wealth manager'),
      ),
      PageViewModel(
        image: Image.asset(
          'lib/assets/images/onboarding3 gif.gif',
          alignment: Alignment.center,
        ),
        title: 'Now Get Started to arrange your Money Conveniently',
        body: '',
        // footer: const Text('wealth manager'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showNextButton: true,
        next: const Text('Next'),
        showSkipButton: true,
        skip: const Text('Skip'),
        done: const Text(
          'Get Started',
          style: TextStyle(color: Colors.white),
        ),
        onDone: () {
          oneTimeScreen();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ScreenHome()),
          );
        },
        baseBtnStyle: TextButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        skipStyle: TextButton.styleFrom(
            foregroundColor: Colors.white, alignment: Alignment.center),
        nextStyle: TextButton.styleFrom(
          foregroundColor: Colors.green,
        ),
        pages: getPages(),
        globalBackgroundColor: const Color.fromARGB(255, 17, 163, 176),
      ),
    );
  }
}
