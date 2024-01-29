import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class utils {
 //Size getScreenSize(){        //(mediaQuery used)
  //return(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size);
 //}
  showSnackbar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(                  //shows the notification appear the bottom
      SnackBar(
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: Row(   
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(content),
          ],
        ),
      ), 
    );
  }
  Future <Uint8List?> pickImage()async{
  ImagePicker picker = ImagePicker();
   XFile? file = await picker.pickImage(source:ImageSource.gallery);
    return file!.readAsBytes();
  }

  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }
}