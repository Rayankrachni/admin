
import 'package:flutter/material.dart';

import '../helper/app_size.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isOnboading=false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool isOnboading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        color:  Colors.blueAccent,
        minWidth: AppSize.width * 0.75,
        height: AppSize.height * 0.07,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.white)
            ),
            const SizedBox(width: 10,),
            if(isOnboading) const Icon(Icons.arrow_forward,color: Colors.white,)
          ],
        ),
      ),
    );
  }
}