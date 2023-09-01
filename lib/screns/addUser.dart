
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/widget/button_widget.dart';
import 'package:adminapplication/widget/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/user_provider.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController firstname=TextEditingController();
  TextEditingController lastname=TextEditingController();
  TextEditingController telephone=TextEditingController();
  TextEditingController deviceId=TextEditingController();
  TextEditingController amount=TextEditingController();
  @override
  Widget build(BuildContext context) {

    final UserProvider provider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:   Text("Add New User",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                    child: Text("First Name",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                  )),
              CustomTextFormField(controller: firstname, hintText: "first name", prefixIcon: Icons.person, textInputType: TextInputType.text),
              SizedBox(height: 20,) ,
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                    child: Text("Last Name",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                  )),
              CustomTextFormField(controller: lastname, hintText: "last name", prefixIcon: Icons.person, textInputType: TextInputType.text),
              SizedBox(height: 10,) ,
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                    child: Text("Email",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                  )),
              CustomTextFormField(controller: email, hintText: "email", prefixIcon: Icons.email, textInputType: TextInputType.emailAddress),
              SizedBox(height: 10,) ,
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                    child: Text("Phone",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                  )),
              CustomTextFormField(controller: telephone, hintText: "telephone", prefixIcon: Icons.phone, textInputType: TextInputType.phone),
              SizedBox(height: 10,) ,
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                    child: Text("Device Id",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                  )),
              CustomTextFormField(controller: deviceId, hintText: "device", prefixIcon: Icons.mobile_friendly_rounded, textInputType: TextInputType.text),
              SizedBox(height: 10,) ,
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                    child: Text("Amount",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                  )),
              CustomTextFormField(controller: amount, hintText: "Amount", prefixIcon: Icons.monetization_on, textInputType: TextInputType.number),
              SizedBox(height: 20,) ,


              SizedBox(height: 20,) ,
              DefaultButton(
                  onPressed: (){
                    provider.storeData( UserModel(id: "", email: email.text, firstname: firstname.text, deviceToken:deviceId.text, lastname: lastname.text, phone:telephone.text, amount: amount.text),context);
                  }, text: "add")
            ],
          ),
        ),
      ),
    );
  }
}