import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iadocare/home.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iadocare/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddPatientPage extends StatefulWidget {
  AddPatientPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage>
{
  TextEditingController drName = new TextEditingController();
  //TextEditingController date = new TextEditingController();
  TextEditingController disease = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController bedNo = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController stand = new TextEditingController();

  @override
  void initState(){
//    getData();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      backgroundColor: Colors.green,
      body:
      Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Add Patient',style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 28,
                  color: Colors.white,
                  letterSpacing: 0.84,
                  fontWeight: FontWeight.w700,
                ),),
                SizedBox(height: 8,),
                TextField(
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    //fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),
                  controller: name,

                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Patient\'s Name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                   // hintText: 'abc@gmail.com',
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                TextField(
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    //fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),
                  controller: age,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Patient\'s age',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                TextField(
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    //fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),
                  controller: bedNo,
                  //obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Bed Number',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                TextField(
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    //fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),
                  controller: stand,

                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Stand No',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                    hintText: '10',
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                TextField(
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    //fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),
                  controller: disease,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Patient\'s disease',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                TextField(
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    //fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),
                  controller: drName,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Doctor Name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                ElevatedButton(

                  child: Text('Add',style: TextStyle(
                    fontFamily: 'SF Pro Display',
//                fontSize: 28,
                    color: Colors.green,
                    // letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),),
                  onPressed: () async{
                    if(drName.text.isEmpty || name.text.isEmpty || bedNo.text.isEmpty || stand.text.isEmpty || age.text.isEmpty || disease.text.isEmpty){
                      displayMessage("Please fill all the details!", context);
                    }
                    else{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var userId = prefs.getString('userId');
                        print(userId);
                        usersRef.child(userId).child("patient");
//                        var myRef = usersRef.child(userId).child("patient").push();
//                        var key = bedNo.text;
    var userDataMap={
                          "age":age.text.trim(),
                          "bottlesFed":0,
                          "disease":disease.text.trim(),
                          "drName":drName.text.trim(),
                          "flag":"false",
                          "patientName":name.text.trim(),
                          "stand":stand.text,
                          "remainingTime": "3000",

                        };
    var map2={
      "remainingTime": "3000",
      "flag": "false",
      "nurseName": userId

    };
                      //  myRef.push(userDataMap);
//                        Map userDataMap={"${bedNo.text.trim().toString()}":{
//                          "age":age.text.trim(),
//                          "bottlesFed":0,
//                          "disease":disease.text.trim(),
//                          "drName":drName.text.trim(),
//                          "flag":false,
//                          "patientName":name.text.trim(),
//                          "stand":stand.text,
//                          "remainingTime": DateTime.now().toIso8601String(),
//                        }
//                        };
                      //usersRef.child(userId).child("patient").set(bedNo.text);
                        usersRef.child(userId).child("patient").child(bedNo.text).set(userDataMap);
                        bedRef.child(bedNo.text).set(map2);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(userId)));
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
//  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//  registerNewUser(BuildContext context)async{
//    DateTime dateTime= DateTime.now();
//    final User firebaseUser =(await _firebaseAuth.createUserWithEmailAndPassword(email:emailId.text,password:password.text).catchError((errMsg){
//      displayMessage("Error: "+errMsg.toString(), context);
//    })).user;
//    if(firebaseUser!=null){
//      usersRef.child(firebaseUser.uid);
//      Map userDataMap={
//        "name":name.text,
//        "email":emailId.text,
//        "contactNo":contactNo.text,
//        "address":address.text,
//        "patient":{
//
//        }
////        "TDS": "0",
////        "flame": "false",
////        "frequencyFlag":{
////          "insects":"0",
////          "mosquito":"0"
////        },
////        "humidity":"0",
////        "light":"0",
////        "pH":"0",
////        "relay": "OFF",
////        "relay2": "OFF",
////        "pesticideSprayer":dateTime.toIso8601String(),
////        "temperature":"0",
////        "waterLevel":"0",
////        "waterSprinkler":dateTime.toIso8601String(),
////        "waterTemperature":"0",
//      };
//      usersRef.child(firebaseUser.uid).set(userDataMap);
//      displayMessage("Congratulations! Your Account has been created successfully!", context);
//      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInPage()));
//    }
//    else{
//      displayMessage("Account could not be created. Please try Again!", context);
//    }
//  }
  displayMessage(String message, BuildContext context){
    Fluttertoast.showToast(msg: message);
  }
}