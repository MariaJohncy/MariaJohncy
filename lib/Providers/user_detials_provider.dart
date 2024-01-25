import 'package:amazon_clone/Model/user_detials_model.dart';
import 'package:amazon_clone/Resources/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class userDetialsProvider with ChangeNotifier {
  UserDetialsModel userDetials;
  userDetialsProvider()
      : userDetials =
            UserDetialsModel(name: "Loading", address: "Loading");

  Future getData() async {
    userDetials = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}