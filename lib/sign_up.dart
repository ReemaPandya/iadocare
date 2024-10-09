import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iadocare/login.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iadocare/main.dart';
class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
{
  TextEditingController emailId = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController contactNo = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();

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
                Text('Sign Up',style: TextStyle(
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
                  controller: emailId,

                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Email Id',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                    hintText: 'abc@gmail.com',
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
                  controller: name,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Name',
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
                  controller: password,
                  obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'password',
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
                  controller: contactNo,

                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                    hintText: '9877798777',
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
                  controller: address,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: 'Address',
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

                  child: Text('Register',style: TextStyle(
                    fontFamily: 'SF Pro Display',
//                fontSize: 28,
                    color: Colors.green,
                   // letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),),
                  onPressed: () {
                    if(emailId.text.isEmpty || name.text.isEmpty || address.text.isEmpty || password.text.isEmpty || contactNo.text.isEmpty){
                      displayMessage("Please fill all the details!", context);
                    }
                    else if(password.text.length<6){
                      displayMessage("Password should of minimum 6 characters.", context);
                    }
                    else{
                      registerNewUser(context);
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   registerNewUser(BuildContext context)async{
     DateTime dateTime= DateTime.now();
    final User firebaseUser =(await _firebaseAuth.createUserWithEmailAndPassword(email:emailId.text,password:password.text).catchError((errMsg){
      displayMessage("Error: "+errMsg.toString(), context);
    })).user;
    if(firebaseUser!=null){
      usersRef.child(firebaseUser.uid);
      Map userDataMap={
        "name":name.text,
        "email":emailId.text,
        "contactNo":contactNo.text,
        "address":address.text,
        "patient":{

        }
//        "TDS": "0",
//        "flame": "false",
//        "frequencyFlag":{
//          "insects":"0",
//          "mosquito":"0"
//        },
//        "humidity":"0",
//        "light":"0",
//        "pH":"0",
//        "relay": "OFF",
//        "relay2": "OFF",
//        "pesticideSprayer":dateTime.toIso8601String(),
//        "temperature":"0",
//        "waterLevel":"0",
//        "waterSprinkler":dateTime.toIso8601String(),
//        "waterTemperature":"0",
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayMessage("Congratulations! Your Account has been created successfully!", context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInPage()));
    }
    else{
      displayMessage("Account could not be created. Please try Again!", context);
    }
  }
  displayMessage(String message, BuildContext context){
     Fluttertoast.showToast(msg: message);
  }
}