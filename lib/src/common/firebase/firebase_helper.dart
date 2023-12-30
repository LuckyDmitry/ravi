import 'package:cloud_functions/cloud_functions.dart';

class FirebaseCloudFunctions {

  static Future<void> sendCode() async { 
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      "sendCode"
      );

      final response = await callable.call();
      print(response);
  }
}