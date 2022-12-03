import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shooter_app/screen/cameras.dart';
import 'package:shooter_app/screen/forgotpassword.dart';
import 'package:shooter_app/screen/signup_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _passwordVisible = true;
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

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
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.25),
                        child: Container(
                            height: size.height * 0.08,
                            child: Image.asset("assets/Rectangle.png")),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.15),
                        child: Container(
                          height: size.height * 0.07,
                          child: Text("Shutter App",
                              style: TextStyle(
                                  fontFamily: "Bold",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ),
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
                        child:   Column(
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
                                    controller: _username,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFFFFFFF),
                                        isDense: true,
                                        border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),),
                                        hintText: "UserName",
                                        hintStyle: TextStyle(
                                            fontFamily: 'Bold1')),
                                  ),
                                ),
                              )
                            ],
                          ), Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: size.width * 0.08,top: size.height*0.013),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: size.width * 0.85,
                                      height: size.height * 0.06),
                                  child: TextFormField(
                                    controller: _password,
                                    obscureText: _passwordVisible,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                    textCapitalization: TextCapitalization.words,
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
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width*0.48,top: size.height*0.02),
                            child: InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));},child: Text("Forgot Password ?",style: TextStyle(fontFamily: "Bold1"))),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: size.height*0.023),
                              child: InkWell(
                                onTap: () async{
                                  signIn(_username.text,_password.text);
                                 /* final cameras = await availableCameras();

                                  // Get a specific camera from the list of available cameras.
                                  final firstCamera = cameras.first;
                                  await availableCameras().then(
                                        (value) => Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (_) => Camerascreen(cameras: value))
                                    ),
                                  );*/
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Camerascreen(camera: firstCamera),));
                                },
                                child: Container(
                                  height: size.height*0.055,
                                  width: size.width*0.35,
                                  decoration: BoxDecoration(
                                      color: HexColor("FFE380"),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(child: Text("Login",style: TextStyle(fontFamily: "Bold",fontSize: 20))),
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
                                  padding: EdgeInsets.only(left: size.width*0.23,top: size.height*0.014),
                                  child: Text("Don’t Have any Account ?",style: TextStyle(fontFamily: "Bold",color: Colors.white)),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: size.height*0.014),
                                  child: Text("  Create",style: TextStyle(fontFamily: "Bold",color: Colors.black)),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void signIn(String email, String password) async {
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    if (_formKey.currentState!.validate()) {
      try{
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) async => {
          Fluttertoast.showToast(msg: "Login Successful"),

          await availableCameras().then(
                (value) => Navigator.push(
                context, MaterialPageRoute(
                builder: (_) => Camerascreen(cameras: value))
            ),
          )
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context){
          //       return DataList();
          //     })),
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
      }}}
}
