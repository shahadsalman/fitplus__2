import 'dart:io';

import 'package:fitplus/firebase/fb_auth_controller.dart';
import 'package:fitplus/firebase/fb_firestore.dart';
import 'package:fitplus/firebase/fb_notifications.dart';
import 'package:fitplus/notification/notification.dart';
import 'package:fitplus/screens/Subscriptions/subscriptions.dart';
import 'package:fitplus/src/controller/splash_screens_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePageGym extends StatefulWidget {
  late XFile? _pickedFile;
  late XFile? _pickedFile2;
  int select = 1;

  @override
  State<HomePageGym> createState() => _HomePageGymState();
}

class _HomePageGymState extends State<HomePageGym> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          elevation: 20,
          backgroundColor: Color.fromARGB(255, 210, 199, 226),title: Text('Gym Profile'),centerTitle: true,titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_active),
              onPressed: () async {
                print(await FbNotifications.getFcm());
                Get.to(() => NotificationScreen());
              },
            )
          ],
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
                      child: Stack(
                        children: [
                          // widget._pickedFile != null
                          //     ? Center(
                          //         child: Image.file(
                          //           File(widget._pickedFile!.path),
                          //           fit: BoxFit.fill,
                          //           width: double.infinity,
                          //         ),
                          //       ):
                          AppController.to.loginMap['logo2'].isEmpty
                              ? Center(child: Image.asset('assets/white.png'))
                              : Center(
                            child: Image.network(
                              AppController.to.loginMap['logo2'],
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Container(
                              height: 20,
                              width: 20,
                              margin: EdgeInsetsDirectional.only(
                                  end: 10, bottom: 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      pickImageAfterSelectForImage2(
                                          context: context);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 15,
                                    ),
                                  )),
                            ),
                          )
                        ],
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
                              AppController.to.loginMap['logo'],
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
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xff48358e),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(AppController.to.loginMap['locationGym'])
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
                      child: Text(AppController.to.loginMap['descriptionGym']),
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
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                              AppController.to.loginMap['images'].length +
                                  1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? GestureDetector(
                                  onTap: () {
                                    pickImageAfterSelectForAddImageGym(
                                        context: context);
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all()),
                                    margin: EdgeInsetsDirectional.only(
                                        end: 10),
                                    child: Center(
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                )
                                    : Container(
                                  height: 120,
                                  width: 120,
                                  margin:
                                  EdgeInsetsDirectional.only(end: 10),
                                  child: Image.network(
                                    AppController.to.loginMap['images']
                                    [index - 1],
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
                                        color: AppController
                                            .to.loginMap['availableWifi']
                                            ? Colors.green
                                            : Colors.red)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                      child: Text('Wifi'),
                                    ),
                                    AppController.to.loginMap['availableWifi']
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
                                        color: AppController
                                            .to.loginMap['availableBarking']
                                            ? Colors.green
                                            : Colors.red)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                      child: Text('Barking'),
                                    ),
                                    AppController
                                        .to.loginMap['availableBarking']
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
                              itemCount: AppController
                                  .to.loginMap['workingHours'].length,
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
                                          '${AppController.to
                                              .loginMap['workingHours'][index]['name']} ${AppController
                                              .to
                                              .loginMap['workingHours'][index]['Time']}')),
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
                      child: AppController.to.loginMap['offers'].isEmpty
                          ? Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle),
                            Text('Add offers'),
                          ],
                        ),
                      )
                          : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                        AppController.to.loginMap['offers'].length,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                    Visibility(
                      visible: widget.select == 3,
                      child: AppController.to.loginMap['reviews'].isEmpty
                          ? Container(
                        height: 150,
                        child: Center(child: Text('No Review')),
                      )
                          : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                        AppController.to.loginMap['reviews'].length,
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

  Future<void> pickImageAfterSelectForImage2(
      {required BuildContext context}) async {
    ImagePicker imagePicker = ImagePicker();

    widget._pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (widget._pickedFile != null) {
      setState(() {});

      /// here code upload image to firebase
      File file = File(widget._pickedFile!.path);
      String url = await FbFireStoreController()
          .uploadFile(imageFile: file, fileName: widget._pickedFile!.name);
      await FbFireStoreController().updateUser(data: {'logo2': url});
      setState(() {});
    }
  }

  Future<void> pickImageAfterSelectForAddImageGym(
      {required BuildContext context}) async {
    ImagePicker imagePicker = ImagePicker();

    widget._pickedFile2 = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (widget._pickedFile2 != null) {
      setState(() {});

      /// here code upload image to firebase
      File file = File(widget._pickedFile2!.path);
      String url = await FbFireStoreController()
          .uploadFile(imageFile: file, fileName: widget._pickedFile2!.name);
      List imageList = AppController.to.loginMap['images'];
      imageList.add(url);
      await FbFireStoreController().updateUser(data: {'images': imageList});
      setState(() {});
    }
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              builMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) =>
      Container(
        padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top,
        ),
      );

  Widget builMenuItems(BuildContext context) =>
      Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.list_alt,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: const Text(
              'Subscribers',
            ),
            textColor: Color.fromARGB(255, 0, 0, 0),
            onTap: () {
              Get.back();
              Get.to(() => subscriptions());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.supervised_user_circle,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: const Text(
              'Profile',
            ),
            textColor: Color.fromARGB(255, 0, 0, 0),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: const Text('Logout'),
            textColor: Color.fromARGB(255, 0, 0, 0),
            onTap: () {
              FbAuthController().signOut();
            },
          ),
        ],
      );
}
