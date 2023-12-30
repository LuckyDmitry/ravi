import 'package:flutter/material.dart';
import 'package:ravi/src/service_locator.dart';
import 'src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await servicesInit();
  runApp(const MyApp());
}
