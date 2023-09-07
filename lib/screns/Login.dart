
import 'package:adminapplication/controller/user_provider.dart';
import 'package:adminapplication/helper/app_nav.dart';
import 'package:adminapplication/helper/app_size.dart';
import 'package:adminapplication/helper/app_toast.dart';
import 'package:adminapplication/model/user_model.dart';
import 'package:adminapplication/screns/homeScreen.dart';
import 'package:adminapplication/widget/button_widget.dart';
import 'package:adminapplication/widget/textFormField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController telephone=TextEditingController();

  String codePhone="+1";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final UserProvider provider=Provider.of<UserProvider>(context);
    provider.checkConnectivity();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,


      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                const Center(
                  child:  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/fca-logo.jpg"),
                  ),
                ),

                SizedBox(height: 20,),

                Center(child: Text('Login'.tr(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22,fontFamily: "Montserrat"),)),

                SizedBox(height: 40,),
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

                      CountryCodePicker(
                        onChanged: (v){
                          setState(() {
                            codePhone=v.toString();
                          });

                        },
                        showFlag: true,
                        flagWidth: 20,


                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: 'US',
                        favorite: const ['+1', 'US'],
                        countryFilter: const ['IT','US','USA' ,'FR','CD', 'CG', 'KE', 'UG','zh','vi','uz','ur','uk','tt','tr','tk','th','tg','ta','sv','sr','sk','sd','sq','so','sl','sd','ru','ro','pt','ps','pl','no','nn','nl','nb','ms','mn','ml','ml','lv','lt','ky','ku','ko','km','kk','ka','ja','it','is','id','hy','hu','hr','hi','he','ha','gl','fi','fa','et','es','en','el','de','cs','ca','dz','bs','bn','bg','be','az','ar','am','af'],
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required'.tr();
                            }
                            return null;
                          },

                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,

                          style:const TextStyle(color: Colors.black,fontFamily: "Montserrat"),
                          decoration: InputDecoration(
                              hintText: 'phone'.tr(),

                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 20.0,
                              ),

                              hintStyle: const TextStyle(
                                  fontFamily: "Montserrat",

                                  fontSize: 12,
                                  color: Colors.grey
                              ),


                              enabledBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)
                              ),


                              errorBorder:UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),



                SizedBox(height: 20,) ,
                DefaultButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate() )
                      {
                        provider.islogin=true;

                        String phone=codePhone+telephone.text;



                         provider.loginUser( phone,context);

                      }

                    }, text:'login-btn'.tr() ,disable: !provider.islogin,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}