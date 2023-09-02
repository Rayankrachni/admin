
import 'package:adminapplication/helper/app_nav.dart';
import 'package:adminapplication/helper/app_shared.dart';
import 'package:adminapplication/screns/homeScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/app_size.dart';
import '../widget/button_widget.dart';
import '../widget/otpTextFormField.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required  this.verificationid});

  final String verificationid;
  TextEditingController c1=TextEditingController();
  TextEditingController c2=TextEditingController();
  TextEditingController c3=TextEditingController();
  TextEditingController c4=TextEditingController();
  TextEditingController c5=TextEditingController();
  TextEditingController c6=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('code-verification'.tr(),style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Center(
              child: SizedBox(
                width: AppSize.width*0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomOtpTextFormField(controller: c1),
                    CustomOtpTextFormField(controller: c2),
                    CustomOtpTextFormField(controller: c3),
                    CustomOtpTextFormField(controller: c4),
                    CustomOtpTextFormField(controller: c5),
                    CustomOtpTextFormField(controller: c6)
                  ],
                ),
              ),

            ),
            SizedBox(height: 20,) ,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DefaultButton(onPressed: () async{
                FirebaseAuth auth = FirebaseAuth.instance;
                String smsCode = c1.text+c2.text+c3.text+c4.text+c5.text+c6.text;
                print("code verification is $smsCode");

                // Create a PhoneAuthCredential with the code
                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationid, smsCode: smsCode);
                print("-----sms sent out -----");
                // Sign the user in (or link) with the credential
                await auth.signInWithCredential(credential);

                if(auth.currentUser!=null){
                  SharedPreferencesHelper.setBool("login", true);
                  push(context: context, screen: HomePage());}



              }, text: 'Verify',),
            )
          ],
        )
    );
  }
}