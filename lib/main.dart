// Local Import
import 'utilities/notification_services.dart';
// Screens
import 'package:awesome_notifications/awesome_notifications.dart';
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

  AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  null,
  [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0x00BFD2BF),
        ledColor: Colors.white)
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group')
  ],
  debug: true
);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

    static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TO be named',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        // // primarySwatch: MaterialColor(0x003C91E6),
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   background: const  Color(0x00bfd2bf),
        //   primary: const Color(0x0056494E),
        //   secondary: const Color(0x003C91E6),
        //
        //   // secondary:,
        // ),
        // fontFamily: 'Roboto',
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
  final _notificationController = Get.put(NotificationController());

  @override
  void initState() {
       AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _notificationController.sendNotification();
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: navigationIndex,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.event_outlined, size: 30.0),
          Icon(Icons.map, size: 30),
          Icon(Icons.more, size: 30.0),
        ],

         color: const Color(0xFF088F6F),
        buttonBackgroundColor: const Color(0x00BFD2BF),
        backgroundColor: const Color(0x00D1B490),
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
        color: const Color(0x0056494E),
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
