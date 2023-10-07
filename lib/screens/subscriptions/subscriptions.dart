import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitplus/firebase/fb_firestore.dart';
import 'package:fitplus/src/controller/splash_screens_controller.dart';
import 'package:flutter/material.dart';
//import 'package:gap/gap.dart';

class subscriptions extends StatefulWidget {
  @override
  State<subscriptions> createState() => _subscriptionsState();
}

class _subscriptionsState extends State<subscriptions> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 210, 199, 226),
          elevation: 20,
          centerTitle: true,
          title: Text('Subscribtions'),
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
                    return Container(
                      height: 100,
                      width: double.infinity,
                      margin: EdgeInsetsDirectional.only(top: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                         // Container(
                          //  height: 70,
                           // width: 70,
                           // decoration: BoxDecoration(
                              //  border: Border.all(color: Colors.black),
                              //  shape: BoxShape.circle),
                           // child: Center(
                            
                          
                           // ),
                         // ),
                        //  SizedBox(
                           // width: 10,
                         // ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      AppController
                                                  .to.loginMap['typeAccount'] ==
                                              2
                                          ? Icons.nest_cam_wired_stand
                                          : Icons.ac_unit,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      AppController
                                                  .to.loginMap['typeAccount'] ==
                                              2
                                          ? listSubscriptions[index]['userName']
                                          : listSubscriptions[index]['nameGym'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Flexible(
                                    child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Start : ${listSubscriptions[index]['dateStartSubscriber']}',
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  height: 5,
                                ),
                                Flexible(
                                    child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'End : ${listSubscriptions[index]['dateEndSubscriber']}',
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.monetization_on,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        listSubscriptions[index]['price']
                                            .toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
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
