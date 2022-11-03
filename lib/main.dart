// Local Import

// Screens
import 'package:my_meds/screens/reminders.dart';
import 'package:my_meds/utilities/db_helper.dart';
import 'package:my_meds/widgets/themes.dart';

import 'screens/home.dart';
import 'screens/pharmContact/pharm_contact.dart';

// Library Import
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_meds/screens/more.dart';


 Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TO be named',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: NavigationBar(),
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int navigationIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: navigationIndex,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.punch_clock, size: 30.0),
          Icon(Icons.map, size: 30),
          Icon(Icons.more, size: 30.0),
        ],
        color: MyTheme.bColor,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInSine,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            navigationIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: Colors.indigo,
        height: double.infinity,
        width: double.infinity,
        child: primaryFeature(index: navigationIndex),
      ),
    );
  }

  Widget primaryFeature({required int index}) {
    switch (index) {
      case 1:
        return Reminder(); // Ashmit

      case 2:
        return const PharmContactScreen(); //Rujal

      case 3:
        return  const More();

      default:
         return const HomeScreen();
    }
  }
}
