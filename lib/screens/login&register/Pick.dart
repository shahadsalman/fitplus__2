import 'package:fitplus/screens/login&register/creategym.dart';
import 'package:fitplus/screens/login&register/signupuser.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'signup.dart';

class SignupPick extends StatelessWidget {
  const SignupPick({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Color.fromARGB(255, 210, 199, 226),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logo.png',
                width: 250,
                height: 250,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Sign Up As?',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () async {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => User_Signup(),));
                    Get.to(() => User_Signup());
                  },
                  child: const Text(
                    'New User',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 210, 202, 221),
                    minimumSize: Size(double.infinity, 70),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () async {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));
                    Get.to(() => CreateAccountManagerGym());
                  },
                  child: const Text(
                    'Gym Manager',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 210, 202, 221),
                    minimumSize: Size(double.infinity, 70),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
