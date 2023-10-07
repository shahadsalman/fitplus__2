import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitplus/firebase/fb_auth_controller.dart';
import 'package:fitplus/firebase/fb_firestore.dart';
import 'package:fitplus/screens/Subscriptions/subscriptions.dart';
import 'package:fitplus/screens/details_gym/details_gym_screen.dart';
import 'package:fitplus/src/controller/splash_screens_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:gap/gap.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 210, 199, 226),
          elevation: 20,
          centerTitle: true,
          title: Text('Notification'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FbFireStoreController().read(
              nameCollection: 'subscribers',
              descending: true,
              orderBy: 'orderBy'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              List<QueryDocumentSnapshot> listSubscriptions = [];
              if (AppController.to.loginMap['typeAccount'] == 2) {
                /// list subscribers gym
                for (var item in data) {
                  if (item['gymEmail'] == AppController.to.loginMap['email'])
                    listSubscriptions.add(item);
                }
              } else {
                /// list subscribers user
                for (var item in data) {
                  if (item['userEmail'] == AppController.to.loginMap['email'])
                    listSubscriptions.add(item);
                }
              }
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>subscriptions());
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.notifications_active ,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('You have New Subscriber'),
                            SizedBox(width: 5,),
                            Text('( ${listSubscriptions[index]['userName']} )' , style: TextStyle(fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 2,
                      color: Color(0xff48358e),
                    );
                  },
                  itemCount: listSubscriptions.length);
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                    Text(
                      'Empty',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TimesNewRoman',
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      );
}
