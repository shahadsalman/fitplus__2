import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitplus/firebase/fb_firestore.dart';
import 'package:fitplus/firebase/fb_httpNotification.dart';
import 'package:fitplus/src/controller/splash_screens_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailsGymScreen extends StatefulWidget {
  DetailsGymScreen({required this.data, this.subscribeUser = false});

  Map<String, dynamic>? paymentIntentData;

  int select = 1;
  late var data;
  late bool subscribeUser;
  int price = 0;
  int month = 0;

  @override
  State<DetailsGymScreen> createState() => _DetailsGymScreenState();
}

class _DetailsGymScreenState extends State<DetailsGymScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 20,
          backgroundColor: Color.fromARGB(255, 210, 199, 226),title: Text('Gym Description'),centerTitle: true,titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 210, 199, 226))),
                      child: widget.data['logo2'].isEmpty
                          ? Center(child: Image.asset('assets/white.png'))
                          : Center(
                              child: Image.network(
                                widget.data['logo2'],
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
                            ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Container(
                          height: 100,
                          width: 100,
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsetsDirectional.only(start: 15),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                              color: Colors.black),
                          child: Container(
                            height: 95,
                            width: 95,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 210, 199, 226)),
                            child: Image.network(
                              widget.data['logo'],
                              height: 100,
                              fit: BoxFit.fill,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Color(0xff48358e),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(widget.data['locationGym'])
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: Color(0xff48358e),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Discription'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (!widget.subscribeUser) {
                                  showSubscribe(
                                      context: context, dataGym: widget.data);
                                }
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: !widget.subscribeUser
                                      ? Color.fromARGB(255, 186, 173, 205)
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                    child: Text(
                                        !widget.subscribeUser
                                            ? 'Subscribe Now'
                                            : 'subscribed',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 210, 199, 226)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(widget.data['descriptionGym']),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.select = 1;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'About',
                                  style: TextStyle(
                                      fontWeight: widget.select == 1
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                      color: widget.select == 1
                                          ? Color(0xff48358e)
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.select = 2;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'offers',
                                  style: TextStyle(
                                      fontWeight: widget.select == 2
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                      color: widget.select == 2
                                          ? Color(0xff48358e)
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.select = 3;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Review',
                                  style: TextStyle(
                                      fontWeight: widget.select == 3
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                      color: widget.select == 3
                                          ? Color(0xff48358e)
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: widget.select == 1,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Photo GYM'),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 120,
                            width: double.infinity,
                            child: widget.data['images'].isEmpty
                                ? Container(
                                    height: 120,
                                    width: 120,
                                    child: Text('Not Any Image For GYM'),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.data['images'].length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 120,
                                        width: 120,
                                        margin:
                                            EdgeInsetsDirectional.only(end: 10),
                                        child: Image.network(
                                          widget.data['images'][index],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('Availabilities'),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: widget.data['availableWifi']
                                            ? Colors.green
                                            : Colors.red)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text('Wifi'),
                                    ),
                                    widget.data['availableWifi']
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.dangerous,
                                            color: Colors.red,
                                          ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: widget.data['availableBarking']
                                            ? Colors.green
                                            : Colors.red)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text('Barking'),
                                    ),
                                    widget.data['availableBarking']
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.dangerous,
                                            color: Colors.red,
                                          ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('Working Hours'),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.data['workingHours'].length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 40,
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff48358e)),
                                      borderRadius: BorderRadius.circular(20)),
                                  margin: EdgeInsetsDirectional.only(end: 10),
                                  child: Center(
                                      child: Text(
                                          '${widget.data['workingHours'][index]['name']} ${widget.data['workingHours'][index]['Time']}')),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.select == 2,
                      child: widget.data['offers'].isEmpty
                          ? Container(
                              height: 150,
                              child: Center(child: Text('No offers')),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.data['offers'].length,
                              itemBuilder: (context, index) {
                                return Container();
                              },
                            ),
                    ),
                    Visibility(
                      visible: widget.select == 3,
                      child: widget.data['reviews'].isEmpty
                          ? Container(
                              height: 150,
                              child: Center(child: Text('No Review')),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.data['reviews'].length,
                              itemBuilder: (context, index) {
                                return Container();
                              },
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSubscribe({required BuildContext context, required var dataGym}) {
    Map<String, dynamic> data = dataGym['price'];
    var sortedKeys = data.keys.toList()
      ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: sortedKeys.length,
                    itemBuilder: (context, index) {
                      var month = sortedKeys[index];
                      var price = data[month.toString()];
                      return GestureDetector(
                        onTap: () {
                          widget.price = int.parse(price.toString());
                          widget.month = int.parse(month.toString());
                          SVProgressHUD.show();
                          Get.back();
                          makePayment();
                        },
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Center(
                              child: Text(
                                  'Subscribe ${month.toString()} Month in ${price} SAR')),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> makePayment() async {
    try {
      widget.paymentIntentData =
          await createPaymentIntent('', 'SAR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  widget.paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'SA',
              merchantDisplayName: 'ANNIE'));

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    SVProgressHUD.dismiss();
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: widget.paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        saveSubscriberUser();
        setState(() {
          widget.subscribeUser = true;
        });

        // print('payment intent'+widget.paymentIntentData!['id'].toString());
        // print('payment intent'+widget.paymentIntentData!['client_secret'].toString());
        // print('payment intent'+widget.paymentIntentData!['amount'].toString());
        // print('payment intent'+widget.paymentIntentData.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully" ,
          style: TextStyle(color: Colors.white),),
          backgroundColor:Colors.green,),);
        

        widget.paymentIntentData = null;
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Payment process Incomplete",
          style: TextStyle(color: Colors.white),),
          backgroundColor:Colors.red,),);
        
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': '${widget.price.toString()}00',
        // 'amount': calculateAmount(widget.price.toString()),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KeFcDDG7u6dEAF5zPLPSwx75U5njpZxgeGdJoTzypzLMyISXaR0XIiCrPwNAyJjso39mYdyQTYGlMiQcrf3fsYF00BN2wmb7C',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount));
    return a.toString();
  }

  saveSubscriberUser() {
    // send Notification to gym
    List fcm = [];
    String fcmToken = widget.data['fcm'] ?? '';
    fcm.add(fcmToken);
    FbHttpNotificationRequest().sendNotification(
        'New Subscribe', 'You have New Subscriber', fcm);
    String uid = DateTime.now().microsecondsSinceEpoch.toString();
    // save Notification in FireStore
    var token = FirebaseAuth.instance.currentUser!.uid;
    FbFireStoreController().createDocument(data: {
      'userId': token,
      'gymId': widget.data.id,
      'userName':
          '${AppController.to.loginMap['FName']} ${AppController.to.loginMap['LName']}',
      'nameGym': widget.data['nameGym'],
      'userEmail': AppController.to.loginMap['email'],
      'gymEmail': widget.data['email'],
      'month': widget.month,
      'price': widget.price,
      'showNotification': false,
      'orderBy': uid,
      'dateStartSubscriber': DateTime.now().toString().split(' ')[0],
      'dateEndSubscriber': DateTime.now()
          .add(Duration(days: (30 * widget.month)))
          .toString()
          .split(' ')[0],
    }, uid: uid, nameCollection: 'subscribers');
    FbFireStoreController().updateArray(
        nameCollection: 'users',
        data: [widget.data.id],
        nameDoc: token,
        nameList: 'listSubscribe');
    FbFireStoreController().updateArray(
        nameCollection: 'users',
        data: [token],
        nameDoc: widget.data.id,
        nameList: 'listSubscribe');
  }
}
