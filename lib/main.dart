import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iadocare/home.dart';
import 'package:iadocare/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('userId');
//  Workmanager.initialize(
//
//    // The top level function, aka callbackDispatcher
//      callbackDispatcher,
//
//      // If enabled it will post a notification whenever
//      // the task is running. Handy for debugging tasks
//      isInDebugMode: true
//  );
  // Periodic task registration
//  Workmanager.registerPeriodicTask(
//    "2",
//
//    //This is the value that will be
//    // returned in the callbackDispatcher
//    "simplePeriodicTask",
//
//    // When no frequency is provided
//    // the default 15 minutes is set.
//    // Minimum frequency is 15 min.
//    // Android will automatically change
//    // your frequency to 15 min
//    // if you have configured a lower frequency.
//    frequency: Duration(seconds: 3),
//  );
  runApp(MaterialApp(home: userId == null?LogInPage(title: 'iAdoCare'):HomePage(userId)));
  //runApp(MyApp());
}
//
//void callbackDispatcher() {
//  Workmanager.executeTask((task, inputData) {
//
//    // initialise the plugin of flutterlocalnotifications.
//    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
//
//    // app_icon needs to be a added as a drawable
//    // resource to the Android head project.
//    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
//    var IOS = new IOSInitializationSettings();
//
//    // initialise settings for both Android and iOS device.
//    var settings = new InitializationSettings(android, IOS);
//    flip.initialize(settings);
//    _showNotificationWithDefaultSound(flip);
//    return Future.value(true);
//  });
//}
//Future _showNotificationWithDefaultSound(flip) async {
//
//  // Show a notification after every 15 minute with the first
//  // appearance happening a minute after invoking the method
//  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//      'your channel id',
//      'your channel name',
//      'your channel description',
//      importance: Importance.Max,
//      priority: Priority.High
//  );
//  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//
//  // initialise channel platform for both Android and iOS device.
//  var platformChannelSpecifics = new NotificationDetails(
//      androidPlatformChannelSpecifics,
//      iOSPlatformChannelSpecifics
//  );
//  await flip.show(0, 'GeeksforGeeks',
//      'Your are one step away to connect with GeeksforGeeks',
//      platformChannelSpecifics, payload: 'Default_Sound'
//  );
//}
DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("Nurse");
DatabaseReference bedRef = FirebaseDatabase.instance.reference().child("Beds");
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.green,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: LogInPage(title: 'Hydroponics'),
//    );
//  }
//}

