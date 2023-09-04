

import 'dart:convert';

import 'package:adminapplication/helper/app_nav.dart';
import 'package:adminapplication/helper/app_shared.dart';
import 'package:adminapplication/helper/app_toast.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/screns/Login.dart';
import 'package:adminapplication/screns/OtpScreen.dart';
import 'package:adminapplication/screns/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  void storeData(UserModel model,BuildContext context) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('users').add({

        "id":"id",
        'firstname': model.firstname,
        'lastname': model.lastname,
        'email': model.email,
        'phone': model.phone,
        'amount': model.amount,
        'deviceToken': "0000",
      });
      await docRef.update({'id': docRef.id});

      pushAndRemove(context: context, screen: HomePage());
    } catch (e) {
      print('Error storing data: $e');
      ToastHelper.showToast(msg:'some-wrong'.tr(), backgroundColor: Colors.red);

      islogin=false;
      notifyListeners();
    }
  }

  void editUser(UserModel model,BuildContext context) async {
    try {

      FirebaseFirestore.instance
          .collection('users')
          .doc(model.id)
          .update({   'firstname': model.firstname,
        'lastname': model.lastname,
        'email': model.email,
        'phone': model.phone,
        'amount': model.amount,});

      ToastHelper.showToast(msg: 'dataSaved'.tr(), backgroundColor: Colors.green);
      sendNotificationToUser(model.deviceToken,"Amount Updated","Your amount has been Updated to ${model.amount}");

      pushAndRemove(context: context, screen: HomePage());
    } catch (e) {
      ToastHelper.showToast(msg: 'some-wrong'.tr(), backgroundColor: Colors.red);
      print('Error storing data: $e');
    }
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersStream() {
    // Reference to the "users" collection in Firestore
    CollectionReference<Map<String, dynamic>> usersCollection =
    FirebaseFirestore.instance.collection('users');

    // Create a stream that listens to changes in the "users" collection
    Stream<QuerySnapshot<Map<String, dynamic>>> usersStream =
    usersCollection.snapshots();

    return usersStream;
  }

  Future<List<UserModel>> fetchUsers() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

      List<UserModel> users = [];

      querySnapshot.docs.forEach((doc) {
        var data=doc.data();
        users.add(UserModel.fromJson(data as Map<String,dynamic>));
      });

      print("-------users ${users.map((e) => e.firstname)}");

      return users;
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<void> sendNotificationToUser(String userDeviceToken, String title, String body) async {
    final serverKey = 'AAAAw_cXJx4:APA91bH5W4n1zlcCbcI-W2M4_ZXhJkc2tNn9_S2ni2R7V5Iaw3yACxIgmOJVdFrFZ1a42a8UYfFsFaExcskuua86ob3Jd131HMEbE7DgcHdU-9j5BzK2KOTNS5p8T54q05El600defgz';
    final url = 'https://fcm.googleapis.com/fcm/send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final payload = {
      'notification': {
        'title': title,
        'body': body,
      },
      'to': userDeviceToken,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      ToastHelper.showToast(msg: 'notification'.tr(), backgroundColor: Colors.green);
      print('Notification sent successfully.');
    } else {
      print('Failed to send notification: ${response.statusCode}');
    }
  }

  Future<bool> isDataStored(UserModel model) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('firstname', isEqualTo: model.firstname)
          .where('lastname', isEqualTo: model.lastname)
          .where('email', isEqualTo: model.email)
          .where('phone', isEqualTo: model.phone)
          .where('amount', isEqualTo: model.amount)
          .where('deviceToken', isEqualTo: model.deviceToken)
          .get();



      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking data: $e');
      return false;
    }
  }


  Future<void> loginUser(String phone, BuildContext context) async {

    try{

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,

        timeout: Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);

          SharedPreferencesHelper.setBool("login", true);
          islogin=false;
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {

            islogin=false;
            notifyListeners();
            ToastHelper.showToast(msg: 'phone-n-valid'.tr(), backgroundColor: Colors.red);
          }
          else{
            islogin=false;
            notifyListeners();
            print("+++++++++${e.code}");}

          // Handle other errors
        },


        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          islogin=false;
          notifyListeners();
          push(context: context, screen: OtpScreen(verificationid: verificationId));

        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
          islogin=false;
          notifyListeners();
        },
      );}catch(e){
      islogin=false;
      notifyListeners();
      print("-----------------$e");
    }

  }


  bool _isRtl=false;
  set isRTL(bool val)
  {

    _isRtl=val;
    notifyListeners();
  }

  bool get  isRtl =>_isRtl;


  bool _islogin=false;
  set islogin(bool val)
  {

    _islogin=val;
    notifyListeners();
  }

  bool get  islogin =>_islogin;




  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferencesHelper.setBool("login", false);
      pushAndRemove(context: context, screen: LoginScreen());
      // Sign-out successful.
    } catch (e) {
      // An error occurred while signing out.
      print("Error signing out: $e");
    }
  }





}