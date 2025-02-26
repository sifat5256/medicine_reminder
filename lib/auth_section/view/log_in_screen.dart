

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:medicine_reminder/auth_section/view/sign_up.dart';
import 'package:medicine_reminder/main_layout.dart';

import '../../component/button.dart';
import '../../component/text_field.dart';
import '../widget/terms_and_condtion.dart';
import 'forgot_password_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0, // Add elevation if you want a shadow effect
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),

            CustomTextField(
              title: "Email",
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              title: "Password",
              prefixIcon: Icons.lock_outline,
            ),
            const SizedBox(
              height: 70,
            ),

            CustomButton(
              text: 'Log In',

              textColor: Colors.white,
              onTap: () {
                Get.to( BottomNavBar());
              },
              buttonColor: Colors.blueAccent,
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Or with",style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16
            ),),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(15),


                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("asstes/social_icon/googleicon.png",height: 30,),
                        SizedBox(width: 30,),
                        const Text(
                          "Sign In with Goggle",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 30,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: (){
                  Get.to(ForgotPasswordScreen());
                },
                child: Text("Forgot password?",style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                 Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: (){
                      Get.to(SignUp());
                    },
                    child: Text("Sign Up",style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),))
              ],
            ),


          ],
        ),
      ),
    );
  }
}
