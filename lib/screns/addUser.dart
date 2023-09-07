
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
                        countryFilter: const
                        ["ZW","ZM","ZA","YT","YE","WS","WF","VU","VN","VI","VG","VE","VC","VA","UZ","UY","US","USAsssss","UM","UG","UA",'TZ','TW','TV','TT','TR','TO','TN','TM','TL','TK','TJ','TH','TG','TF','TD','TC','SZ','SY','SX','SV','ST','SS','SR','SO','SN','SM','SL','SK','SJ','SI','SH','SG','SE','SD','SC','SB','SQ','RW','RU','RS','RO','RE','QA','PY','PW','PT','PS','PR','PN','PM','PL','PK','PH','PG','PF','PE','PA','OM','NZ','NU','NR','NP','NO','NL','NI','NG','NE','NA','MZ','MY','MX','MW','MV','MU','MT','MR','MS','MQ','MP','MO','MN','MM','ML','MK','MH','MG','MF','ME','MD','MC','MA','LY','LV','LU','LT','LS','LR','LK','LI','LC','LB','LA','KZ','KY','KW','KR','KP','KN','KM','KI','KH','KG','KE','JP','JO','JM','JE','IT','IS','IR','IQ','IO','IN','IM','IL','IE','ID','HU','HT','HR','HN','HM','JK','GY','GW','GU','GT','GS','GR','GP','GN','GM','GL','GI','GH','GG','GF','GE','GD','GB','GA','FR','FO','FM','FK','FJ','FI','ET','ES','ER','EH','EG','EE','EC','DZ','DZ','DO','DM','DK','DJ','DE','CZ','CY','CX','CW','CV','CU','CR','CO','CN','CL','CK','CI','CH','CG','CF','CD','CC','CA','BZ','BY','BW','BV','BT','BS','BR','BQ','BO','BN','BM','BL','BJ','BI','BH','BG','BF','BE','BD','BB','BA','AZ','AX','AW','AU','AT','AS','AR','AQ','AO','AM','AL','AI','AG','AF','AE','AD'],
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