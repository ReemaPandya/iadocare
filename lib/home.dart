import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iadocare/add_patient.dart';
import 'package:iadocare/all_patients.dart';
import 'package:iadocare/login.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'build_row.dart';
import 'patient_info.dart';
class HomePage extends StatefulWidget {
 // final Data data;
  final String recordName;
  const HomePage(this.recordName);
 // HomePage({Key key, this.data}) : super(key: key);

 // final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', widget.recordName);
//    databaseReference.child('Nurse').child(widget.recordName).child('name').onValue.listen((event) {
//      var snapshot = event.snapshot;
//      setState(() {
//         value= snapshot.value;
//        print('name is $value');
//      });
//    });
//    databaseReference.child('Nurse').child(widget.recordName).child('patient').onValue.listen((event) {
//print("helllllllllllllllllllloooooooo");
//      var snapshot = event.snapshot;
//      print('snapshot${snapshot}');
//      setState(() {
//
//        Map message = snapshot.value;
//        //print(message);
//        listLength=message.length;
//        print('Length is ${message.length}');
//        keys = message.keys.toList();
//        values = message.values.toList();
//        print(keys);
//        print(values);
//      });
//    });
//    databaseReference.child('Nurse').child(widget.recordName).child('patient').once().then((DataSnapshot snapshot) {
//      Map message = snapshot.value;
//      //print(message);
//      listLength=message.length;
//      print('Length is ${message.length}');
//      keys = message.keys.toList();
//      values = message.values.toList();
//      print(keys);
//      print(values);
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
//    databaseReference.child('Nurse').child(widget.recordName).child('patient').once().then((DataSnapshot snapshot) {
//      Map message = snapshot.value;
//      listLength=message.length;
//      print('Length is ${message.length}');
//    });

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
        title: Text('iAdoCare'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.all_inbox_outlined  ),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllPatientsPage(widget.recordName)));
            },
          ),
          IconButton(
            icon: Icon(Icons.add_box),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPatientPage()));
            },
          ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(
//              height: 1000,
//              width: 400,
              //color: Colors.green,
              child:
              StreamBuilder(
                  stream: databaseReference.child('Nurse').child(widget.recordName).child('patient').onChildAdded,
                  builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {

                    databaseReference.child('Nurse').child(widget.recordName).child('patient').once().then((DataSnapshot snapshot) {
                      Map message = snapshot.value;
                      //print(message);
                      listLength=message.length;
                      print('Length is ${message.length}');
                       keys = message.keys.toList();
                       values = message.values.toList();
                      print(keys);
                      print(values);
                    });
                    databaseReference.child('Nurse').child(widget.recordName).child('patient').onChildChanged.listen((event) {
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
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: listLength,
                        itemBuilder: (BuildContext context, int index) {
                         // print('inside ${keys[index]}');
//                            return Container(child: Column(children: <Widget>[
//                            Text(keys[index].toString()),
//                              //Text(values[index].),
//                              Text(values[index]['remainingTime'])
//                            ],));
                        if(int.parse(values[index]['remainingTime'])<=300 && (values[index]['flag']=='true')){
                          print(values[index]['flag']);
                          print("notification");
                          _showNotificationWithDefaultSound("Patient at bed number${keys[index].toString()} requires immediate attention!",keys[index].toString());

                        }
                          return Container(child:
                          Row(
                              children:  <Widget>[Expanded(
                                child: Column(children: <Widget>[
                                  BuildRow("Bed No",keys[index].toString()),
                                  //Text(values[index].),
                                  BuildRow("Remaining Time","${((int.parse(values[index]['remainingTime']))% (24 * 3600) / 3600).floor().toString()}:${(((int.parse(values[index]['remainingTime']))% (24 * 3600 * 3600)) / 60).floor().toString()}" )
//                                  Row(children:[
//                                    Text("Bed No"),
//                                    Text(keys[index].toString())
//                          ] ),
//                                  Row(children:[
//                                    Text("Remaining Time"),
//                                    Text("${((int.parse(values[index]['remainingTime']))% (24 * 3600) / 3600).floor().toString()}:${(((int.parse(values[index]['remainingTime']))% (24 * 3600 * 3600)) / 60).floor().toString()}" )
//                                  ] ),

                                ],),
                              ),
                                IconButton(
                                  icon: Icon(Icons.view_agenda),
                                  color: Colors.black,
                                  onPressed: () async{
//                                    SharedPreferences prefs = await SharedPreferences.getInstance();
//                                    var userId = prefs.getString('userId');
                                    //var nurse=values[index]['nurseName'].toString();
                                    var bedNo=keys[index].toString();
                                    print(bedNo.runtimeType);
                                    print("bed$bedNo");
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientInfoPage(widget.recordName,bedNo)));
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<void> _signOut(BuildContext context) async{
    await _firebaseAuth.signOut().then((_){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> new LogInPage(title: 'iAdoCare')));
    });

  }
}