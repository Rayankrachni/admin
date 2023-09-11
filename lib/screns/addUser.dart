
import 'package:adminapplication/helper/app_size.dart';
import 'package:adminapplication/helper/app_toast.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/widget/button_widget.dart';
import 'package:adminapplication/widget/textFormField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
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
  String imoji="🇺🇸";
  String countryName="United State";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final UserProvider provider=Provider.of<UserProvider>(context);
    Locale currentLocale = EasyLocalization.of(context)!.locale;

    print(currentLocale);
    provider.checkConnectivity();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:   Text('add-title'.tr(),style:const  TextStyle(fontWeight: FontWeight.w500,fontSize: 22,fontFamily: "Montserrat"),),

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

                SizedBox(height: 10,) ,
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                  child: Text('country'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
                ),
                Container(
                  width: AppSize.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:   Color(0xff701B45),
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Row(

                      children: [
                        Icon(Icons.flag,color: Color(0xff701B45),),
                        SizedBox(

                          child: TextButton(
                            onPressed: () {
                              showCountryPicker(
                                context: context,

                                //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                exclude: <String>['KN', 'MF'],
                                favorite: <String>['SE'],
                                //Optional. Shows phone code before the country name.
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  setState(() {


                                    countryName=country.name;
                                  });

                                },

                                // Optional. Sets the theme for the country list picker.
                                countryListTheme: CountryListThemeData(
                                  // Optional. Sets the border radius for the bottomsheet.
                                  borderRadius:const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  // Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                      labelText: 'search'.tr(),
                                      hintText: 'start'.tr(),
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  // Optional. Styles the text in the search field
                                  searchTextStyle:const TextStyle(
                                    color:  Color(0xff701B45),
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            },
                            child:  Text("$countryName",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat",color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const  SizedBox(height: 10,) ,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TextButton(
                        onPressed: () {
                          showCountryPicker(
                            context: context,

                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                            exclude: <String>['KN', 'MF'],
                            favorite: <String>['SE'],
                            //Optional. Shows phone code before the country name.
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              print('Select country: ${country.displayName}');
                              print('Select country: ${country.flagEmoji}');
                              print('Select country: ${country.countryCode}');
                              print('Select country: ${country.phoneCode}');
                              setState(() {

                                imoji=country.flagEmoji;
                                codePhone="+"+country.phoneCode;
                              });

                            },

                            // Optional. Sets the theme for the country list picker.
                            countryListTheme: CountryListThemeData(
                              // Optional. Sets the border radius for the bottomsheet.
                              borderRadius:const BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                              // Optional. Styles the search field.
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                                  ),
                                ),
                              ),
                              // Optional. Styles the text in the search field
                              searchTextStyle:const TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                        child:  Text(" ${imoji} ${codePhone}",style: TextStyle(color: Colors.black),),
                      ),

                      SizedBox(
                        width: AppSize.width*0.55,
                        child: TextFormField(
                          controller: telephone,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required'.tr();
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,

                          style:const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'phone'.tr(),

                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 20.0,
                              ),

                              hintStyle: const TextStyle(
                                  fontFamily: 'Montserrat',

                                  fontSize: 14,
                                  color: Colors.grey
                              ),


                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)
                              ),
                              focusedBorder:const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)
                              ),


                              errorBorder:const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
               SizedBox(height: 10,) ,

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

                        provider.storeData( UserModel(id: "",  firstname: firstname.text, deviceToken:deviceId.text, phone:phone, amount: amount.text,country: countryName),context);

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