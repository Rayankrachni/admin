
import 'package:adminapplication/helper/app_nav.dart';
import 'package:adminapplication/helper/app_shared.dart';
import 'package:adminapplication/screns/homeScreen.dart';
import 'package:adminapplication/widget/textFormField.dart';
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextFormField(controller: c1, hintText:'otp-code'.tr(), prefixIcon: Icons.code, textInputType: TextInputType.text),
            ),
            SizedBox(height: 20,) ,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DefaultButton(onPressed: () async{
                FirebaseAuth auth = FirebaseAuth.instance;
                String smsCode = c1.text;
                print("code verification is $smsCode");

                // Create a PhoneAuthCredential with the code
                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationid, smsCode: smsCode);
                print("-----sms sent out -----");
                // Sign the user in (or link) with the credential
                await auth.signInWithCredential(credential);

                if(auth.currentUser!=null){
                  SharedPreferencesHelper.setBool("login", true);
                  pushAndRemove(context: context, screen: HomePage());}



              }, text: 'Verify',),
            )
          ],
        )
    );
  }
}