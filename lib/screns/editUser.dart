
import 'package:adminapplication/controller/user_provider.dart';
import 'package:adminapplication/helper/app_size.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/widget/button_widget.dart';
import 'package:adminapplication/widget/textFormField.dart';
import 'package:country_picker/country_picker.dart';
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
  String countryName="United State";
  @override
  Widget build(BuildContext context) {
    firstname.text=widget.user.firstname;
    telephone.text=widget.user.phone;
    deviceId.text=widget.user.deviceToken;
    amount.text=widget.user.amount;
    countryName=widget.user.country;

    final UserProvider provider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:   Text('edit-title'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,fontFamily: "Montserrat"),),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                child: Text('first-name'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
              ),


              CustomTextFormField(controller: firstname, hintText: 'first-name'.tr(), prefixIcon: Icons.person, textInputType: TextInputType.text,),
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
                      const Icon(Icons.flag,color: Color(0xff701B45),),
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
                                  widget.user.country=countryName;
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
                          child:  Text("${widget.user.country}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat",color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,) ,
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                child: Text('phone'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
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
                child: Text('amount'.tr(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Montserrat"),),
              ),
              CustomTextFormField(controller: amount, hintText:'amount'.tr(), prefixIcon: Icons.monetization_on, textInputType: TextInputType.number),


              SizedBox(height:40,) ,
              DefaultButton(onPressed: (){
                provider.editUser(UserModel(id: widget.user.id, firstname: firstname.text, deviceToken:deviceId.text, phone:telephone.text, amount: amount.text,country:widget.user.country ),context);

              //  provider.isDataStored(UserModel(id: widget.user.id, email: email.text, firstname: firstname.text, deviceToken:deviceId.text, lastname: lastname.text, phone:telephone.text, amount: amount.text));
              }, text:'save'.tr())
            ],
          ),
        ),
      ),
    );
  }
}