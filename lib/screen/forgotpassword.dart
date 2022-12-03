import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPassword extends StatefulWidget {

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [HexColor("F19292"), HexColor("D9EB09")]
              )
            ),
            child: Column(
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
                Padding(
                  padding: EdgeInsets.only(top: size.height*0.09),
                  child: Text("Forgot Password",style: TextStyle(fontSize: 20,fontFamily: "Bold1",color: Colors.black,),),
                ),Padding(
                  padding: EdgeInsets.only(top: size.height*0.15),
                  child: Text("Enter Email Address",style: TextStyle(fontSize: 15,fontFamily: "Bold1",color: Colors.black,),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.08,top: size.height*0.02),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: size.width * 0.85,
                        height: size.height * 0.06),
                    child: TextFormField(
                      // controller: _name,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          isDense: true,
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),),
                          hintText: "example@gmail.com",
                          hintStyle: TextStyle(
                              fontFamily: 'Bold1',fontSize: 13)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height*0.015),
                  child: Text("Back to Sign in",style: TextStyle(fontSize: 13,fontFamily: "Bold1",color: Colors.white,),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height*0.015),
                  child: Container(
                    height: size.height*0.045,
                    width: size.width*0.45,
                    decoration: BoxDecoration(
                      color: HexColor("F06602"),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text("Send",style: TextStyle(fontSize: 15,fontFamily: "Bold1",color: Colors.white,),)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height*0.03),
                  child: Text("Or",style: TextStyle(fontSize: 17,fontFamily: "Bold",color: Colors.black,),),
                ),
                Row(
                   children: [
                     SvgPicture.asset("assets/Google.svg"),
                     SvgPicture.asset("assets/Facebook.svg"),
                     SvgPicture.asset("assets/Apple Logo.svg"),
                   ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
