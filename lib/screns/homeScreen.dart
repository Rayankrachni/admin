
import 'package:adminapplication/controller/user_provider.dart';
import 'package:adminapplication/helper/app_nav.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/screns/addUser.dart';
import 'package:adminapplication/screns/editUser.dart';
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
  bool isLoading = true;

  List<UserModel> users=[];


  void getCurrentUser() async {
    users=await userProvider.fetchUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {

    getCurrentUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text('Home'.tr()),
          leading: IconButton(onPressed: (){EasyLocalization.of(context)!.setLocale(const Locale('ar', 'DZ'));},icon: Icon(Icons.language),),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          push(context: context, screen: AddUser());
        },child:const Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.teal),
        body:!isLoading ? Padding(
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
                      itemCount: users.length,
                      itemBuilder: (BuildContext context ,int index){

                        return Container(
                          height: 60,
                          decoration:const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey)
                              )
                          ),
                          child: ListTile(
                            subtitle: Text(" ${users[index].lastname}",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,fontSize: 12),),

                            title: Text(" ${users[index].firstname}",style: TextStyle(fontWeight: FontWeight.w500),),
                            leading: Icon(CupertinoIcons.person,color: Colors.teal,),
                            trailing: IconButton(onPressed: (){
                              push(context: context, screen: EditUser(user:users[index] ,));
                            },icon: Icon(Icons.arrow_circle_right_outlined,size:25,),),
                          ),
                        );
                      }))


            ],
          ),
        ):Center(child: CircleAvatar(backgroundColor: Colors.teal,))
    );
  }
}