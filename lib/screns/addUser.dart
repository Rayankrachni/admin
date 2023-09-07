
import 'package:adminapplication/helper/app_size.dart';
import 'package:adminapplication/helper/app_toast.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/widget/button_widget.dart';
import 'package:adminapplication/widget/textFormField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
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

  String codePhone="+1";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final UserProvider provider=Provider.of<UserProvider>(context);
    provider.checkConnectivity();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:   Text('add-title'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,fontFamily: "Montserrat"),),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                  child: Text('first-name'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
                ),
                CustomTextFormField(controller: firstname, hintText: 'first-name'.tr(), prefixIcon: Icons.person, textInputType: TextInputType.text),

                SizedBox(height: 20,) ,
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                  child: Text('second-name'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
                ),
                CustomTextFormField(controller: lastname, hintText:'second-name'.tr(), prefixIcon: Icons.person, textInputType: TextInputType.text),
                SizedBox(height: 10,) ,
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                  child: Text('email'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
                ),
                CustomTextFormField(controller: email, hintText: 'email'.tr(), prefixIcon: Icons.email, textInputType: TextInputType.emailAddress),
                SizedBox(height: 10,) ,
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                  child: Text('phone'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color:  Color(0xff701B45),

                      )
                  ),
                  child: Row(
                    children: [

                      CountryCodePicker(
                        onChanged: (v){
                          setState(() {
                            codePhone=v.toString();
                          });
                         
                        },
                        showFlag: true,


                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: 'US',
                        favorite: const ['+1', 'US'],
                        countryFilter: const ['IT', 'US','USA','FR','CD', 'CG', 'KE', 'UG','zh','vi','uz','ur','uk','tt','tr','tk','th','tg','ta','sv','sr','sk','sd','sq','so','sl','sd','ru','ro','pt','ps','pl','no','nn','nl','nb','ms','mn','ml','ml','lv','lt','ky','ku','ko','km','kk','ka','ja','it','is','id','hy','hu','hr','hi','he','ha','gl','fi','fa','et','es','en','el','de','cs','ca','dz','bs','bn','bg','be','az','ar','am','af'],
                        showFlagDialog: false,
                        comparator: (a, b) => b.name!.compareTo(a.name!),
                        //Get the country information relevant to the initial selection
                        onInit: (code) => debugPrint(
                            "on init ${code!.name!} ${code.dialCode} ${code.name}"),
                      ),
                      SizedBox(
                        width: AppSize.width*0.5,
                        child: TextFormField(
                          controller: telephone,


                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,

                          style:const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText:'phone'.tr(),

                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 20.0,
                              ),

                              hintStyle: const TextStyle(
                                  fontFamily: "Montserrat",

                                  fontSize: 14,
                                  color: Colors.grey
                              ),


                              enabledBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)
                              ),


                              errorBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
               SizedBox(height: 10,) ,
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
                  child: Text('amount'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
                ),
                CustomTextFormField(controller: amount, hintText: 'amount'.tr(), prefixIcon: Icons.monetization_on, textInputType: TextInputType.number),
                SizedBox(height: 20,) ,


                SizedBox(height: 20,) ,
                DefaultButton(
                    onPressed: (){

                      if(_formKey.currentState!.validate() )
                      {


                        String phone=codePhone+telephone.text;

                        provider.storeData( UserModel(id: "", email: email.text, firstname: firstname.text, deviceToken:deviceId.text, lastname: lastname.text, phone:phone, amount: amount.text,authid: ""),context);

                      }
                      if(codePhone==null){
                        ToastHelper.showToast(msg: 'select-code'.tr(), backgroundColor: Colors.red);
                      }
                    }, text: 'add'.tr())
              ],
            ),
          ),
        ),
      ),
    );
  }
}