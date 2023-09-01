
import 'package:flutter/material.dart';

import '../helper/app_size.dart';


class CustomOtpTextFormField extends StatelessWidget {
  const CustomOtpTextFormField({
    super.key,
    required this.controller,
    this.onTapSuffix,
  });

  final TextEditingController controller;
  final Function()? onTapSuffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.width*0.12,
      child: TextFormField(
        controller: controller,

        validator: (value) {
          if (value!.isEmpty) {
            return 'Toast.empty-field';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,

        style: TextStyle(color:Theme.of(context).colorScheme.secondary,),
        obscureText: false,
        decoration:const InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 20.0,
          ),

          enabledBorder:const OutlineInputBorder(
            borderRadius:BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black26,
            ),
          ),
          focusedErrorBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide:  BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.teal,
            ),
          ),
          errorBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10),),
            borderSide:  BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}