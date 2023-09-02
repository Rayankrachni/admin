
import 'package:adminapplication/controller/user_provider.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/widget/button_widget.dart';
import 'package:adminapplication/widget/textFormField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EditUser extends StatefulWidget {
  EditUser({super.key,required this.user});

  UserModel user;

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController email=TextEditingController();
  TextEditingController firstname=TextEditingController();
  TextEditingController lastname=TextEditingController();
  TextEditingController telephone=TextEditingController();
  TextEditingController deviceId=TextEditingController();
  TextEditingController amount=TextEditingController();
  @override
  Widget build(BuildContext context) {
    firstname.text=widget.user.firstname;
    lastname.text=widget.user.lastname;
    email.text=widget.user.email;
    telephone.text=widget.user.phone;
    deviceId.text=widget.user.deviceToken;
    amount.text=widget.user.amount;

    final UserProvider provider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:   Text('edit-title'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                child: Text('first-name'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
              ),


              CustomTextFormField(controller: firstname, hintText: 'first-name'.tr(), prefixIcon: Icons.person, textInputType: TextInputType.text),
              SizedBox(height: 10,) ,
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                child: Text('second-name'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
              ),
              CustomTextFormField(controller: lastname, hintText: 'second-name', prefixIcon: CupertinoIcons.padlock_solid, textInputType: TextInputType.text),
              SizedBox(height: 10,) ,
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                child: Text('email'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
              ),
              CustomTextFormField(controller: email, hintText:'email'.tr(), prefixIcon: Icons.email, textInputType: TextInputType.emailAddress),
              SizedBox(height: 10,) ,
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                child: Text('phone'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
              ),
              CustomTextFormField(controller: telephone, hintText: 'phone'.tr(), prefixIcon: Icons.phone, textInputType: TextInputType.phone),
              SizedBox(height:10,) ,
                /* const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                      child: Text("Device Id",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                    )),
                CustomTextFormField(controller: deviceId, hintText: "device", prefixIcon: Icons.mobile_friendly_rounded, textInputType: TextInputType.text),
                SizedBox(height: 10,) ,*/

              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                child: Text('amount'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
              ),
              CustomTextFormField(controller: amount, hintText:'amount'.tr(), prefixIcon: Icons.monetization_on, textInputType: TextInputType.number),


              SizedBox(height:40,) ,
              DefaultButton(onPressed: (){
                provider.editUser(UserModel(id: widget.user.id, email: email.text, firstname: firstname.text, deviceToken:deviceId.text, lastname: lastname.text, phone:telephone.text, amount: amount.text),context);

              //  provider.isDataStored(UserModel(id: widget.user.id, email: email.text, firstname: firstname.text, deviceToken:deviceId.text, lastname: lastname.text, phone:telephone.text, amount: amount.text));
              }, text:'save'.tr())
            ],
          ),
        ),
      ),
    );
  }
}