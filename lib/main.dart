import 'package:flutter/material.dart';
import 'package:ravi/src/service_locator.dart';
import 'src/app.dart';

void main() async {
  await servicesInit();
  runApp(const MyApp());
}
