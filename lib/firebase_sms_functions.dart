import 'package:cloud_functions/cloud_functions.dart';

class FirebaseSMSFunctions {
  static void sms(String number, String code) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    HttpsCallable callable = functions.httpsCallable('sms');
    await callable.call(<String, dynamic>{
      'number': number,
      'code': code,
    });
  }
}
