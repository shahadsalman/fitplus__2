import 'package:firebase_core/firebase_core.dart';
import 'package:fitplus/firebase/fb_notifications.dart';
import 'package:fitplus/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/route_manager.dart';

// ignore: unused_import
import 'screens/home/mainGym.dart';
import 'screens/splash_screens/splash_screens.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FbNotifications.initNotifications();
  Stripe.publishableKey = 'pk_test_51KeFcDDG7u6dEAF5uEVLgT3kkVZOobiEMhaLel7c9i3zGqfESV3wCAZhF8FAvW7LyAZcTx9A5nc90KsbbE6baknq00f1CSz81Q';

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen ()
    
  ),);
}