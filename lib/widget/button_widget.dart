
import 'package:adminapplication/controller/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/app_size.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isOnboading=false,
    this.disable=false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool isOnboading;
  final bool disable;
  @override
  Widget build(BuildContext context) {
    final UserProvider provider=Provider.of<UserProvider>(context);
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        color:  Color(0xff701B45),
        minWidth: AppSize.width * 0.75,
        height: AppSize.height * 0.07,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          !provider.islogin ?  Text(
                text,
                style:const TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.white,fontFamily: "Montserrat")
            ):CircularProgressIndicator(color: Colors.white,),
            const SizedBox(width: 10,),
            if(isOnboading) const Icon(Icons.arrow_forward,color: Colors.white,)
          ],
        ),
      ),
    );
  }
}