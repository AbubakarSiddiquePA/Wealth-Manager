import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/screens/home/screen_home.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenHome()),
            );
          },
          icon: Container(
            decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [Colors.white, Colors.grey]),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'About',
          style: GoogleFonts.acme(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/Lo_money-removebg-preview.png',
                width: 70,
                height: 70,
              ),
              Text(
                'Wealth Manager',
                style: GoogleFonts.acme(fontSize: 33.5),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Designed and Developed by \n Abubakar Siddique PA',
            style: GoogleFonts.acme(fontSize: 12.5, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'version 1.0.1',
            style: GoogleFonts.acme(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
