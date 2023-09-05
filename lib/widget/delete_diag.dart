
import 'dart:ui';
import 'package:adminapplication/controller/user_provider.dart';
import 'package:adminapplication/helper/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class WrongDialog extends StatefulWidget {
   WrongDialog({super.key,required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<WrongDialog> createState() => _WrongDialogState();
}

class _WrongDialogState extends State<WrongDialog> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider provider=Provider.of<UserProvider>(context);
    return    Stack(
      children: [
        // Blurred background
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the blur intensity
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust the opacity and color
            ),
          ),
        ),
        // Custom dialog
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  height: 65,
                  width: 65,
                  decoration:const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle
                  ),
                  child:!provider.isDelete? Icon(Icons.delete,color: Colors.white,size: 28,):CircularProgressIndicator(),
                ),
                SizedBox(height: 20,),
                Text(
                    'delete-title'.tr(),
                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),

                  //  style: AppTextStyle(size:20, fontweight: FontWeight.bold, color: errorColor,)

                ),
                const SizedBox(height: 20,),
                Wrap(
                    children: [
                      Text(
                          'delete-description'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                         // AppTextStyle(size:12, fontweight: FontWeight.w500, color: Theme.of(context).colorScheme.onSecondary,)

                      ),
                    ]
                ),
                SizedBox(height: 20,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: AppSize.width*0.3,
                      height: 40,
                      child: ElevatedButton(onPressed: widget.onPressed,

                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // Set the button's background color
                            onPrimary: Colors.white,
                            elevation: 1, // Set the elevation (shadow) of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // Set the border radius
                            ),
                            // Set the minimum width and height
                            // Add more properties as needed, e.g., padding, textStyle, etc.
                          ),

                          child:  Text( 'delete'.tr(),
                            //  style:AppTextStyle(size: 15, fontweight: FontWeight.normal,color:Colors.white)
                          )),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: AppSize.width*0.3,
                      height: 40,
                      child: ElevatedButton(onPressed:(){
                        Navigator.pop(context);
                      },

                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).cardColor, // Set the button's background color
                            onPrimary: Theme.of(context).colorScheme.secondary,
                            elevation: 1,

                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(5), // Set the border radius
                            ),
                            // Set the minimum width and height
                            // Add more properties as needed, e.g., padding, textStyle, etc.
                          ),

                          child: Text( 'cancel'.tr(),
                             // style:AppTextStyle(size: 15, fontweight: FontWeight.w500,color:  Theme.of(context).colorScheme.secondary)
                          )),

                    ),
                  ],
                ),



              ],
            ),
          ),
        ),
      ],
    );
  }
}
