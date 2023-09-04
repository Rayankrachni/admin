

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

        "id":"12",
        'firstname': model.firstname,
        'lastname': model.lastname,
        'email': model.email,
        'phone': model.phone,
        'amount': model.amount,
        'deviceToken': "0000",
      });
      await docRef.update({'id': docRef.id});
      print('Data stored successfully.');

      pushAndRemove(context: context, screen: HomePage());
    } catch (e) {
      print('Error storing data: $e');
      ToastHelper.showToast(msg: "Some thing went wrong, try again", backgroundColor: Colors.red);

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

      print('Data stored successfully.');
      ToastHelper.showToast(msg: "Data Saved", backgroundColor: Colors.green);
      sendNotificationToUser(model.deviceToken,"Amount Updated","Your amount has been Updated to ${model.amount}");

      pushAndRemove(context: context, screen: HomePage());
    } catch (e) {
      ToastHelper.showToast(msg: "Some thing went wrong, try again", backgroundColor: Colors.red);
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
    final serverKey = 'AAAAKvXxIUQ:APA91bFR5sp9c9a7-mylQIbPVor9ld9Ibln_NiRnCg1yHQILtQpwMKJiI29PsJCgVUfVoa8foH-ug8nt-UU-GxXefl7GmxQZ4YBMJgA6QES_6dmqgsi2IA5vmzLg9xti3q-bK6UPtD28';
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


      print("-----data------${querySnapshot.docs.isNotEmpty}");

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
          print("-----sms completed out -----");
          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);

          SharedPreferencesHelper.setBool("login", true);
          islogin=false;
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {

            print('The provided phone number is not valid.');
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
          print("-----time out -----");
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