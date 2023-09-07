import 'dart:async';

import 'package:adminapplication/controller/user_provider.dart';
import 'package:adminapplication/helper/app_nav.dart';
import 'package:adminapplication/helper/app_size.dart';
import 'package:adminapplication/screns/addUser.dart';
import 'package:adminapplication/screns/editUser.dart';
import 'package:adminapplication/widget/delete_diag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with TickerProviderStateMixin {

  bool isConnected = true;
  UserProvider userProvider = UserProvider();
  UserModel? userModel;

  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  late final AnimationController _controller;



  @override
  void initState() {
    userProvider.getAllUsersStream();
    super.initState();

    // Start listening for connectivity changes
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
          setState(() {
            isConnected = result != ConnectivityResult.none;
          });
        });
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    connectivitySubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  // Add your checkConnectivity method here, if needed

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    Locale currentLocale = EasyLocalization.of(context)!.locale;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff701B45),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          if (currentLocale.toString() == "ar_DZ") {
            provider.isRTL = true;
            EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
          }
          else {
            provider.isRTL = false;
            EasyLocalization.of(context)!.setLocale(const Locale('ar', 'DZ'));
          }
        }
          , icon: Icon(Icons.language,color: Colors.white,),),

        title: Text('Home'.tr(),style: TextStyle(color: Colors.white),),
      ),
      body:  StreamBuilder<bool>(
            initialData: isConnected,
            stream: Stream.periodic(Duration(seconds: 5)).asyncMap(
                  (_) async {
                final connectivityResult = await Connectivity().checkConnectivity();
                return connectivityResult != ConnectivityResult.none;
              },
            ),
            builder: (context, snapshot) {
              bool isConnected = snapshot.data ?? false;

              if (isConnected) {
                // Display user data when connected
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: userProvider.getAllUsersStream(),
                builder: (context, snapshot) {
                  if(snapshot.hasData ){
                    final data = snapshot.data!.docs;
                    // Convert Firestore data into a list of User objects
                    final userList = snapshot.data!.docs.map((doc) {
                      final userData = doc.data() as Map<String, dynamic>;
                      return UserModel.fromJson(userData);
                    }).toList();
                    // List<UserModel> users =data.map((key, value) => UserModel.fromJson(key))

                  return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('add-title'.tr(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,fontFamily: "Montserrat"),),
                                ),
                                IconButton(onPressed: (){push(context: context, screen: AddUser());}, icon:Icon(Icons.add,size: 30,))
                              ],
                            ),

                            Divider(
                                indent: 10,
                                endIndent: 10,
                                thickness: 2,
                                color: Color(0xff701B45)
                            ),

                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('user-list'.tr(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,fontFamily: "Montserrat"),),
                            ),
                            !userList.isEmpty?
                            Expanded(
                                child: ListView.builder(
                                    itemCount: userList.length,
                                    itemBuilder: (BuildContext context ,int index){

                                      return GestureDetector(

                                        onLongPress: (){
                                          print("delete ");
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return WrongDialog(onPressed: (){
                                                userProvider.deleteItem(userList[index].id,userList[index].authid,context);
                                                //userProvider.deleteUserByUID(userList[index].authid);
                                              },);



                                              //
                                            },
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            height: 70,
                                            decoration:const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(color: Colors.grey)
                                                )
                                            ),
                                            child: ListTile(
                                              subtitle: Text(" ${userList[index].phone } ",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,fontSize: 12,fontFamily: "Montserrat"),),

                                              title: Text(" ${userList[index].firstname}",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Montserrat"),),
                                              leading: Icon(CupertinoIcons.person,color: Color(0xff701B45),),
                                              trailing: IconButton(onPressed: (){
                                                push(context: context, screen: EditUser(user:userList[index] ,));
                                              },icon: Icon(Icons.edit,color: Color(0xff701B45),size: 20,),),
                                            ),
                                          ),
                                        ),
                                      );
                                    })):SizedBox(
                                height: AppSize.height*0.5,
                                child: Center(child: Text('no-user'.tr())))


                          ],
                        ),
                      );
                      }
                else if (snapshot.hasError) {
                  return Container(
                      color: Colors.white,
                      child: Text('${''.tr()}: ${snapshot.error}'));
                } else{

                  return  Center(child: CircularProgressIndicator());
                }



              },
            );
              }
              else {
                // Display a message when not connected
                return Center(
                  child: SizedBox(
                    width: AppSize.width*0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/images/animation.json',
                          width: AppSize.width*0.4,

                          controller: _controller,


                          onLoaded: (composition) {
                            // Configure the AnimationController with the duration of the
                            // Lottie file and start the animation.
                            _controller
                              ..duration = composition.duration
                              ..forward()..repeat();
                          },
                        ),
                        Text(
                          'no-internet'.tr(),
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.normal,

                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
      ),
    );
  }
}




