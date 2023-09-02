
import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.lines=1,
    this.suffixIcon,
    this.onTapSuffix,
    required this.textInputType,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final int lines;
  final IconData? suffixIcon;
  final Function()? onTapSuffix;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,

      style:const TextStyle(color: Colors.black),
      obscureText: obscureText,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hintText,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20.0,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color:  Colors.blueAccent,
          size: 20,
        ),
        hintStyle: const TextStyle(
            fontFamily: 'myriad',

            fontSize: 14,
            color: Colors.grey
        ),

        suffix: suffixIcon != null
            ? InkWell(
          onTap: onTapSuffix,
          child: Icon(
            suffixIcon,
            color:  Colors.blueAccent,
            size: 20,
          ),
        )
            : null,
        enabledBorder:const OutlineInputBorder(
          borderRadius:BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            width: 1,
            color:  Colors.blueAccent,
          ),
        ),
        focusedErrorBorder:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide:  BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            width: 1,
            color:  Colors.blueAccent,
          ),
        ),
        errorBorder:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20),),
          borderSide:  BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}