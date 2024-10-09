import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iadocare/add_patient.dart';
import 'package:iadocare/login.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'build_row.dart';
class PatientInfoPage extends StatefulWidget {
  // final Data data;
  final String recordName;
  final String bedNo;
  const PatientInfoPage(this.recordName, this.bedNo);
  // HomePage({Key key, this.data}) : super(key: key);

  // final String title;
  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage>
{
  bool isLoading=false;
  void initState(){
    super.initState();
    getData();
  }
  void getData() async{
    setState(() {
      isLoading=true;
      print(isLoading);
    });

    await databaseReference.child('Nurse').child(widget.recordName).child('patient').child(widget.bedNo.toString()).once().then((DataSnapshot snapshot) {
      Map message = snapshot.value;
      //print(message);
      // listLength=message.length;
      print('Length is ${message.length}');
      keys = message.keys.toList();
      values = message.values.toList();
      print(keys);
      print(values);
      print(values[1]);
    });
    setState(() {
      isLoading=false;
      print(isLoading);
    });
  }
  final databaseReference =FirebaseDatabase.instance.reference();
  List keys=[],values=[];
  @override
  Widget build(BuildContext context) {
    print("info");
    print(widget.bedNo.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Info'),
        backgroundColor: Colors.green,

      ),
      body: //isLoading?CircularProgressIndicator:
      SingleChildScrollView(
        child: Container(

          child: isLoading==false?Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BuildRow("Bed Number",widget.bedNo.toString()),
                SizedBox(height: 10,),
                BuildRow("Patient Name",values[0].toString()),
                SizedBox(height: 10,),
                BuildRow("Patient's age",values[5].toString()),
                SizedBox(height: 10,),
                        BuildRow("Patient's disease",values[1].toString()),
                SizedBox(height: 10,),
                      // Text(values[2].toString()),
                       // Text(values[3]),
                        BuildRow("Total number of bottles given to patient",values[4].toString()),
                SizedBox(height: 10,),

              ],
            ),
          ):CircularProgressIndicator(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
//          return ListView.builder
//            (
//              itemCount: 1,
//              itemBuilder: (BuildContext context, int index) {
//              //  print('inside ${keys[index]}');
//
//                return Container(child:
//                Row(
//                    children:  <Widget>[Column(children: <Widget>[
//                      Text(keys[index].toString()),
//                      //Text(values[index].),
//                      Text(values[index]['patientName']),
//                      Text(values[index]['remainingTime']),
//                      Text(values[index]['bottlesFed']),
//                      Text(values[index]['disease']),
//                      Text(values[index]['drName']),
//                      Text(values[index]['stand'])
//                    ],
//                    ),
////                      IconButton(
////                        icon: Icon(Icons.view_agenda),
////                        color: Colors.black,
////                        onPressed: () async{
//////                                    SharedPreferences prefs = await SharedPreferences.getInstance();
//////                                    var userId = prefs.getString('userId');
////                          var bedNo=keys[index].toString();
////                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllPatientsPage(bedNo)));
//////                                    prefs.remove('userId');
//////                                    _signOut(context);
//////              Navigator.pushNamed(context, AddVillage.routeName);
////                        },
////                      ),
//                    ]
//                ));
//              }
//          );

  }

}
