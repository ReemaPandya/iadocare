import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iadocare/main.dart';
import 'package:iadocare/sign_up.dart';
import 'package:iadocare/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LogInPage extends StatefulWidget {
  LogInPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage>
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('LogIn',style: TextStyle(
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

                ElevatedButton(

                  child: Text('LogIn',style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: Colors.green,
                    // letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),),
                  onPressed: () {
                    if(emailId.text.isEmpty || password.text.isEmpty ){
                      displayMessage("Please fill all the details!", context);
                    }
                    else if(password.text.length<6){
                      displayMessage("Password should of minimum 6 characters.", context);
                    }
                    else{
                      loginAndAuthenticateUser(context);
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
                InkWell(
                  onTap:(){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));},
                  child: Text('New User?',style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 20,
                    color: Colors.white,
                    letterSpacing: 0.84,
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context)async{
    final User firebaseUser =(await _firebaseAuth.signInWithEmailAndPassword(email:emailId.text,password:password.text).catchError((errMsg){
      displayMessage("Error: "+errMsg.toString(), context);
    })).user;
    if(firebaseUser!=null){
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
        if(snap.value!=null){
          print('hello');
          print(firebaseUser.uid);

//          SharedPreferences prefs = await SharedPreferences.getInstance();
//          prefs.setString('userId', firebaseUser.uid);
          final data = Data(id: firebaseUser.uid);
//          Navigator.push(context, new MaterialPageRoute(builder: (context)=> new HomePage( firebaseUser.uid))).then((value) async{
//            SharedPreferences prefs = await SharedPreferences.getInstance();
//            prefs.setString('userId', firebaseUser.uid);
//          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(firebaseUser.uid))).then((value) async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('userId', firebaseUser.uid);
          });
//          Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(builder: (context) => HomePage(firebaseUser.uid)),
//                (Route<dynamic> route) => false,
//          ).then((value) async{
//            SharedPreferences prefs = await SharedPreferences.getInstance();
//            prefs.setString('userId', firebaseUser.uid);
        //  });
//          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(
//           // data: data,
//              firebaseUser.uid
//          )
//          )
//          ).then((value) async{
//            SharedPreferences prefs = await SharedPreferences.getInstance();
//            prefs.setString('userId', firebaseUser.uid);
//          });
          //displayMessage("You are logged in!", context);
        }
        else{
          _firebaseAuth.signOut();
          displayMessage("No records exists for this user! Please create new account.", context);
        }
      });


    }
    else{
      displayMessage("Error Occured! Couldn't sign in.", context);
    }
  }
  displayMessage(String message, BuildContext context){
    Fluttertoast.showToast(msg: message);
  }
}
class Data {

  String id;
  Data({ this.id});
}