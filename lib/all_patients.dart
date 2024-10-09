import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:googleapis/content/v2_1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iadocare/add_patient.dart';
import 'package:iadocare/login.dart';
import 'main.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' as api;
import 'package:iadocare/patient_info.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'build_row.dart';

class AllPatientsPage extends StatefulWidget {
  // final Data data;
  final String recordName;
  const AllPatientsPage(this.recordName);
  // HomePage({Key key, this.data}) : super(key: key);

  // final String title;
  @override
  _AllPatientsPageState createState() => _AllPatientsPageState();
}

class _AllPatientsPageState extends State<AllPatientsPage>
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FlutterLocalNotificationsPlugin fltrNotification;
  // String _selectedParam;
  String task;
  int val;
  List keys=[],values=[];
  final databaseReference =FirebaseDatabase.instance.reference();
  final fb = FirebaseDatabase.instance;
  bool isLoading = false;
  double d=0;
  int listLength=0;
  String sliderValue;
  String value,humidity,temperature,waterTemperature,pH,tds,waterLevel,fire,relay,mosquitoes,insects,relay2,water,pesticide;
  String temp;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  Future getData()async{
    setState(() {
      isLoading = true;
    });

//    databaseReference.child('Nurse').child(widget.recordName).child('name').onValue.listen((event) {
//      var snapshot = event.snapshot;
//      setState(() {
//         value= snapshot.value;
//        print('name is $value');
//      });
//    });
//    databaseReference.child('Users').child(widget.recordName).child('humidity').onValue.listen((event) {
//      var snapshot = event.snapshot;
//      setState(() {
//        humidity= snapshot.value.toString();
//        print('humidity is ${humidity.toString()}');
//      });
//    });

    setState(() {
      isLoading=false;
    });
  }

  Future _showNotificationWithDefaultSound(String  message,String bedNo) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Alert!',
      message,
      platformChannelSpecifics,
      payload: bedNo,
    );
  }

  @override
  void initState(){
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: onSelectNotification);
    getData();
    firebaseMessaging.configure(
      onLaunch: (Map<String,dynamic> msg){
        print("onLaunch called");
      },
      onResume: (Map<String,dynamic> msg){
        print("onResume called");
      },
      onMessage: (Map<String,dynamic> msg){
        print("onMessage called");
      },
    );

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true,
            alert: true,
            badge: true
        )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings) {
      print('IOS setting Registered');
    });
    firebaseMessaging.getToken().then((token){
      update(token);
    });

    super.initState();
    databaseReference.child('Nurse').child(widget.recordName).child('patient').once().then((DataSnapshot snapshot) {
      Map message = snapshot.value;
      listLength=message.length;
      print('Length is ${message.length}');
    });

  }
  update(String token){
    print(token);
  }

  Future onSelectNotification(String payload) async {


    // set up the buttons
    Widget remindButton = FlatButton(
      child: Text("Remind me later"),
      onPressed:  () {Navigator.of(context).pop();},
    );

    Widget attendButton = FlatButton(
      child: Text("Attend"),
      onPressed:  () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.getString('userId');
        usersRef.child(userId).child("patient").child(payload).child('flag').set("false");
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert!"),
      content: Text("Attend patient at bed no $payload?"),
      actions: [
        remindButton,
        //cancelButton,
        attendButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

//    showDialog(
//      context: context,
//      builder: (_) {
//        return new AlertDialog(
//          title: Text("Alert"),
//          content: Text("Attend : $payload"),
//
//        );
//      },
//    );
  }
  @override
  Widget build(BuildContext context) {
//    final ref = fb.reference().child("logs");
    final ref = fb.reference().child('Nurse').child(widget.recordName);
    String message1,message;
    //int h;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Patients'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('userId');
              _signOut(context);
//              Navigator.pushNamed(context, AddVillage.routeName);
            },
          ),
        ],
      ),
      body: //isLoading?CircularProgressIndicator:
      SingleChildScrollView(
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                height: 1000,
                width: 400,
                //color: Colors.green,
                child:
                StreamBuilder(
                    stream: databaseReference.child('Beds').onChildAdded,
                    builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {

                      databaseReference.child('Beds').once().then((DataSnapshot snapshot) {
                        Map message = snapshot.value;
                        //print(message);
                        listLength=message.length;
                        print('Length is ${message.length}');
                        keys = message.keys.toList();
                        values = message.values.toList();
                        print(keys);
                        print(values);
                      });
                      databaseReference.child('Beds').onChildChanged.listen((event) {
                        //var snapshot = event.snapshot;

//                              print("this${snapshot.value}");
//
//                              keys = snapshot.value.keys.toList();
//                              print(keys);
//                              values = snapshot.value.values.toList();
//                              print(values);

                        setState(() {
//                                 value= snapshot.value;
//                                print('change is $value');
                        });
                      });

                      return ListView.builder
                        (
                          itemCount: listLength,
                          itemBuilder: (BuildContext context, int index) {
                            if(int.parse(values[index]['remainingTime'])<=300){
                              print(values[index]['flag']);
                              print("notification");
                              _showNotificationWithDefaultSound("Patient at bed number${keys[index].toString()} requires immediate attention!",keys[index].toString());
                              
//                            insertEvent(event);
                              const _scopes = const [api.CalendarApi.calendarScope];
                              void prompt(String url) async {
                                print("Please go to the following URL and grant access:");
                                print("  => $url");
                                print("");

                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
//                              insert(title, startTime, endTime) {
                                var _clientID = new ClientId("YOUR_CLIENT_ID", "");
                                clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
                                  var calendar = api.CalendarApi(client);
                                  calendar.calendarList.list().then((value) => print("VAL________$value"));

                                  String calendarId = "primary";
                                  api.Event event; // Create object of event

                                  event.summary = title;

                                  api.EventDateTime start = new api.EventDateTime();
                                  start.dateTime = DateTime();
                                  start.timeZone = "GMT+05:00";
                                  event.start = start;

                                  api.EventDateTime end = new api.EventDateTime();
                                  end.timeZone = "GMT+05:00";
                                  end.dateTime = endTime;
                                  event.end = end;
                                  try {
                                    calendar.events.insert(event, calendarId).then((value) {
                                      print("ADDEDDD_________________${value.status}");
                                      if (value.status == "confirmed") {
                                        print('Event added in google calendar');
                                      } else {
                                        print("Unable to add event in google calendar");
                                      }
                                    });
                                  } catch (e) {
                                    print('Error creating event $e');
                                  }
                                });
//                              }


                            }
                            return Container(child:
                            Row(
                              children:  <Widget>[Expanded(
                                child: Column(children: <Widget>[
                                  BuildRow("Bed No",keys[index].toString()),
                                  //Text(values[index].),
                                  BuildRow("Remaining Time","${((int.parse(values[index]['remainingTime']))% (24 * 3600) / 3600).floor().toString()}:${(((int.parse(values[index]['remainingTime']))% (24 * 3600 * 3600)) / 60).floor().toString()}" )
                                ],),
                              ),
                                IconButton(
                                  icon: Icon(Icons.view_agenda),
                                  color: Colors.black,
                                  onPressed: () async{
//                                    SharedPreferences prefs = await SharedPreferences.getInstance();
//                                    var userId = prefs.getString('userId');
                                  var nurse=values[index]['nurseName'].toString();
                                  var bedNo=keys[index].toString();
                                  print(bedNo.runtimeType);
                                  print("bed$bedNo");
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientInfoPage(nurse,bedNo)));
//                                    prefs.remove('userId');
//                                    _signOut(context);
//              Navigator.pushNamed(context, AddVillage.routeName);
                                  },
                                ),]
                            ));
                          }
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<void> _signOut(BuildContext context) async{
    await _firebaseAuth.signOut().then((_){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> new LogInPage(title: 'Hydroponics')));
    });

  }
}