import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/about/about.dart';
import 'package:money_manager_db/reset/clear_all.dart';
import 'package:money_manager_db/statistics/statistics.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            // curve: Curves.easeOut,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 17, 163, 176),
            ),
            child: Text(
              'Wealth Manager',
              style: GoogleFonts.acme(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.auto_graph_sharp,
                color: Colors.black,
              ),
            ),
            title: const Text('Insights'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const Statics()));
            },
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.info_outline,
                color: Colors.black,
              ),
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.feedback_outlined,
                color: Colors.black,
              ),
            ),
            title: const Text('Feedback'),
            onTap: () async {
              const url =
                  'mailto:siddiquepanathur@gmail.com?subject=Review on Wealth Manager &body= need';
              try {
                Uri uri = Uri.parse(url);
                await launchUrl(uri);
                log("");
              } catch (e) {
                log("error");
              }
            },
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.share,
                color: Colors.black,
              ),
            ),
            title: const Text('Share'),
            onTap: () {
              share();
            },
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
            title: const Text('Clear all'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      icon: const Icon(Icons.dangerous),
                      title: const Text('Clear all data'),
                      content: const Text(
                        "Are you Sure to Clear all data?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            resetAllData(context);
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Clear",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
          Image.asset(
            'lib/assets/images/Lo_money-removebg-preview.png',
            width: 50,
            height: 40,
          )
        ],
      ),
    );
  }
}

Future share() async {
  await FlutterShare.share(
      title: ' Wealth Manager', text: 'Wealth Manager ', linkUrl: 'link');
}
