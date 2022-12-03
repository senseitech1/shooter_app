import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shooter_app/screen/login_screen.dart';
import 'package:shooter_app/screen/signup_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * 0.7,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [HexColor("F19292"), HexColor("D9EB09")])),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:  EdgeInsets.only(bottom: size.height*0.3),
              child: Container(
                height: size.height*0.08,
                  child: Image.asset("assets/Rectangle.png")),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:  EdgeInsets.only(bottom: size.height*0.15),
              child: Container(
                height: size.height*0.07,
                  child: Text("Shutter App",style: TextStyle(fontFamily: "Bold",fontWeight: FontWeight.bold,fontSize: 16)),),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/Ellipse 3.png",
                fit: BoxFit.cover,
              )),
          Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: size.height*0.65),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
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
              ),Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: size.height*0.02),
                  child: InkWell(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));},
                    child: Container(
                      height: size.height*0.055,
                      width: size.width*0.35,
                      decoration: BoxDecoration(
                        color: HexColor("FFE380"),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(child: Text("Signup",style: TextStyle(fontFamily: "Bold",fontSize: 20))),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
