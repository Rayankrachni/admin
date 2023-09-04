
import 'package:adminapplication/controller/user_provider.dart';
import 'package:adminapplication/helper/app_nav.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/screns/addUser.dart';
import 'package:adminapplication/screns/editUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UserProvider userProvider=UserProvider();

  @override
  void initState() {

    userProvider.getAllUsersStream();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    String Local=EasyLocalization.of(context)!.currentLocale.toString();
    Locale currentLocale = EasyLocalization.of(context)!.locale;
    print(Local);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: userProvider.getAllUsersStream(),
      builder: (context, snapshot) {
      if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
        final data = snapshot.data!.docs;
        // Convert Firestore data into a list of User objects
        final userList = snapshot.data!.docs.map((doc) {
          final userData = doc.data() as Map<String, dynamic>;
          return UserModel.fromJson(userData);
        }).toList();
        print("data $data ${userList[0].lastname}");
       // List<UserModel> users =data.map((key, value) => UserModel.fromJson(key))

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:  Text('Home'.tr()),
            actions: [
              IconButton(onPressed: (){userProvider.signOut(context);},icon: Icon(Icons.login),),

            ],
            leading: IconButton(onPressed: (){

              if(Local=="ar_DZ"){
                userProvider.isRTL=true;
                EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));}
              else{
                userProvider.isRTL=false;
                EasyLocalization.of(context)!.setLocale(const Locale('ar', 'DZ'));}
            }
              ,icon: Icon(Icons.language),),
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){
            push(context: context, screen: AddUser());
          },child:const Icon(Icons.add,color: Colors.white,),backgroundColor: Color(0xff701B45),),
          body:Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('user-list'.tr(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22),),
                ),

                Expanded(
                    child: ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (BuildContext context ,int index){

                          return Container(
                            height: 60,
                            decoration:const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey)
                                )
                            ),
                            child: ListTile(
                              subtitle: Text(" ${userList[index].lastname}",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,fontSize: 12),),

                              title: Text(" ${userList[index].firstname}",style: TextStyle(fontWeight: FontWeight.w500),),
                              leading: Icon(CupertinoIcons.person,color: Color(0xff701B45),),
                              trailing: IconButton(onPressed: (){
                                push(context: context, screen: EditUser(user:userList[index] ,));
                              },icon: Icon(Local=="ar_DZ"?Icons.arrow_circle_right_outlined:Icons.arrow_circle_left_outlined,size:25,),),
                            ),
                          );
                        }))


              ],
            ),
          )
      );}
      else if (snapshot.hasError) {
        return Container(
            color: Colors.white,
            child: Text('${''.tr()}: ${snapshot.error}'));
      } else {
        return  Container(
            color: Colors.white,
            child:const Center(child: const CircularProgressIndicator()));
      }

  },
);
  }
}