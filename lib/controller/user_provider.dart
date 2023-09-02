

import 'dart:convert';

import 'package:adminapplication/helper/app_nav.dart';
import 'package:adminapplication/helper/app_toast.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/screns/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{


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
      ToastHelper.showToast(msg: "Data stored successfully", backgroundColor: Colors.green);

      pushAndRemove(context: context, screen: HomePage());
    } catch (e) {
      print('Error storing data: $e');
      ToastHelper.showToast(msg: "Some thing went wrong, try again", backgroundColor: Colors.red);
    }
  }


  void editUser(UserModel model,BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(model.id).set(
          {

            "id":model.id,
            'firstname': model.firstname,
            'lastname': model.lastname,
            'email': model.email,
            'phone': model.phone,
            'amount': model.amount,
            'deviceToken': model.deviceToken,
          }
      );
      print('Data stored successfully.');
      ToastHelper.showToast(msg: "Data Saved", backgroundColor: Colors.green);
      sendNotificationToUser(model.deviceToken,"titele","send to");

      pushAndRemove(context: context, screen: HomePage());
    } catch (e) {
      ToastHelper.showToast(msg: "Some thing went wrong, try again", backgroundColor: Colors.red);
      print('Error storing data: $e');
    }
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
      ToastHelper.showToast(msg: "Notification has been sent", backgroundColor: Colors.green);
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












}