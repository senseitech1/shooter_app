import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cameras.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference storageReference = FirebaseStorage.instance.ref();



  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _Password = TextEditingController();
  // string for displaying the error Message
  // String? errorMessage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.7,
                width: size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [HexColor("F19292"), HexColor("D9EB09")])),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:  EdgeInsets.only(top: size.height*0.06,left: size.width*0.06),
                        child: Container(
                          height: size.height*0.05,
                          width: size.height*0.05,
                          decoration: BoxDecoration(color: HexColor("FFD161"),borderRadius: BorderRadius.circular(25)),
                          child: Center(child: Icon(Icons.arrow_back_ios_new_outlined,color: HexColor("F06602"))),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding:  EdgeInsets.only(top: size.height*0.06,left: size.width*0.05),
                            child: Container(
                                height: size.height*0.085,
                                child: Image.asset("assets/Rectangle.png")),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.05),
                          child: Align(
                            child: Container(
                              height: size.height*0.07,
                              child: Text("Shutter App",style: TextStyle(fontFamily: "Bold",fontWeight: FontWeight.bold,fontSize: 17)),),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height*0.04),
                          child: Text("Welcome\nCreate to your Account" ,style: TextStyle(fontFamily: "Bold1",fontWeight: FontWeight.bold,fontSize: 22,)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: size.height*0.47),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: size.height*0.55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/Ellipse 3.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child:  Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: size.width * 0.08,top: size.height*0.16),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: size.width * 0.85,
                                      height: size.height * 0.06),
                                  child: TextFormField(
                                    controller: _name,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFFFFFFF),
                                        isDense: true,
                                        border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),),
                                        hintText: "Name",
                                        hintStyle: TextStyle(
                                            fontFamily: 'Bold1')),
                                    validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  ),
                                ),
                              )
                            ],
                          ),  Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: size.width * 0.08,top: size.height*0.01),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: size.width * 0.85,
                                      height: size.height * 0.06),
                                  child: TextFormField(
                                    controller: _email,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFFFFFFF),
                                        isDense: true,
                                        border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),),
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                            fontFamily: 'Bold1')),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please Enter Your Email");
                                      }
                                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(value)) {
                                        return ("Please Enter a valid email");
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              )
                            ],
                          ), Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: size.width * 0.08,top: size.height*0.01),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: size.width * 0.85,
                                      height: size.height * 0.06),
                                  child: TextFormField(
                                    controller: _Password,
                                    obscureText: _passwordVisible,

                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(_passwordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          },
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFFFFFFF),
                                        isDense: true,
                                        border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          fontFamily: 'Bold1',)),
                                    validator: (value) {
                                      RegExp regex = new RegExp(r'^.{6,}$');
                                      if (value!.isEmpty) {
                                        return ("Password is required for login");
                                      }
                                      if (!regex.hasMatch(value)) {
                                        return ("Enter Valid Password(Min. 6 Character)");
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: size.height*0.02),
                              child: InkWell(
                                onTap: (){
                                  if(_formKey.currentState!.validate()){
                                    signUp(_name.text,_email.text,_Password.text);

                                  }
                                },
                                child: Container(
                                  height: size.height*0.055,
                                  width: size.width*0.35,
                                  decoration: BoxDecoration(
                                      color: HexColor("FFE380"),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(child: Text("SignUp",style: TextStyle(fontFamily: "Bold",fontSize: 20))),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: size.width*0.33,top: size.height*0.01),
                                  child: Text(" Have Account",style: TextStyle(fontFamily: "Bold",color: Colors.white)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: size.height*0.01),
                                  child: Text(" Login",style: TextStyle(fontFamily: "Bold",color: Colors.black)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp( String name, String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore( value)})
            .catchError((e) async {
          Fluttertoast.showToast(msg: e!.message);
          await availableCameras().then(
                  (value) => Navigator.push(
                (context),
                MaterialPageRoute(builder: (context) => Camerascreen(cameras: value)),
                // (route) => false
              ));
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore(UserCredential user) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection("users").doc(user.user!.uid).set({
      "firstname": _name.text,
      "email": _email.text,
      "Password": _Password.text,
      "uid": FirebaseAuth.instance.currentUser!.uid,
    });
    Fluttertoast.showToast(msg: "Account created successfully:)");

  }
}
