import 'package:amazon_clone/Model/user_detials_model.dart';
import 'package:amazon_clone/Providers/user_detials_provider.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetialBar extends StatelessWidget {
  final double offset;
   const UserDetialBar({
    super.key,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    UserDetialsModel userDetials = Provider.of<userDetialsProvider>(context).userDetials;
    return Positioned(
      top: -offset / 3,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:lightBackgroundaGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            ),
        ),
        child:Padding(padding:const EdgeInsets.symmetric(
          vertical: 3, horizontal: 20,
        ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.location_on_outlined,
                color:Colors.grey[900],
                ),
              ),
              SizedBox(
                width: screenSize.width*0.7,
                child: Text(
                  "Deliever to ${userDetials.name}  -${userDetials.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                   color: Colors.grey[900],
                   ),
                   ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}