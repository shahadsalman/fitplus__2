import 'package:fitplus/screens/login&register/creategym.dart';

import '../home/mainGym.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import  'package:get/route_manager.dart';
class Signup extends StatefulWidget {
  

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<Signup> {

  bool isLoading = false;
  TextEditingController NameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CommercialController = TextEditingController();
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(email);
  }
  void signUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       
        email: emailController.text,
        password: passwordController.text,
        

      ).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePageGym(),), (route) => false);
      });

    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak."), backgroundColor: Colors.redAccent,));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email."), backgroundColor: Colors.redAccent,));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: Colors.redAccent,));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Scaffold(
        appBar: AppBar(elevation:20,backgroundColor: Color.fromARGB(255, 210, 199, 226),),
        backgroundColor: Color.fromARGB(255, 255, 251, 251),
        
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 120),
              child: Text(
                'Create Account',
                style: TextStyle(color: const Color.fromARGB(255, 77, 72, 72), fontSize: 33),
              ),
              
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.grey),
                            controller: NameController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 210, 202, 221),
                                filled: true,
                                
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 123, 108, 108),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 199, 194, 194),
                                  ),
                                ),
                                hintText: "Gym Name",
                                hintStyle: TextStyle(color: Color.fromARGB(255, 16, 16, 16)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                            TextField(
                            style: TextStyle(color: Color.fromARGB(255, 16, 16, 16)),
                            controller: emailController,
                            decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 210, 202, 221),
                                filled: true,
                                hintText: "Email",

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            style: TextStyle(color:  Colors.grey),
                             controller:passwordController ,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 210, 202, 221),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 123, 108, 108),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 103, 94, 94),
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(color: const Color.fromARGB(255, 16, 16, 16)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.grey),
                            controller: CommercialController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 210, 202, 221),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 123, 108, 108),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 199, 194, 194),
                                  ),
                                ),
                                hintText: "commercial record",
                                hintStyle: TextStyle(color: Color.fromARGB(255, 16, 16, 16)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                     onPressed: () {
                                       if(NameController.text.trim().isEmpty){
                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a Name"), backgroundColor: Colors.redAccent,));
                                       }
                                     else  if(CommercialController.text.trim().isEmpty){
                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a commercial Number"), backgroundColor: Colors.redAccent,));
                                       }

                                     else if(emailController.text.trim().isEmpty){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a email"), backgroundColor: Colors.redAccent,));
                                      }else if(passwordController.text.trim().length < 6){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password length is short (minimum : 6)"), backgroundColor: Colors.redAccent,));
                                      } else if(!isValidEmail(emailController.text.toString())){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid email"), backgroundColor: Colors.redAccent,));
                                      } else{
                                        Get.off(()=>CreateAccountManagerGym());
                                          
                                      }

                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                
                                child: Text(
                                  'If already have an account Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: const Color.fromARGB(255, 78, 69, 69),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
             if(isLoading)
            
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4)
              ),
              child: Center(
                child: CircularProgressIndicator(color: Colors.deepPurpleAccent,),
              ),
            )
          
          ],
        ),
      ),
    );
  }
}