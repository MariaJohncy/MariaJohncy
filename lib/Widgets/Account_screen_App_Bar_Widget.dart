import 'package:amazon_clone/Screens/search_screen.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:flutter/material.dart';

class AccountScreenAppBar extends StatelessWidget implements PreferredSizeWidget{   //with => implements
   @override
  Widget build(BuildContext context) {
    Size screenSize =MediaQuery.sizeOf(context);
    return Container(
    height: kAppBarHeight,
    width: screenSize.width,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
      colors: backgroundGradient,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:const EdgeInsets.symmetric(horizontal: 15),
          child: Image.network(amazonLogoUrl,
           height: kAppBarHeight *0.7,
          ),
        ),
        Row(
          children:[
            IconButton(onPressed: (){},
            icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.black,
            ),
            ),
            IconButton(onPressed: (){
              Navigator.push(
              context,
             MaterialPageRoute(
              builder: (context) => 
              const SearchScreen()));
            },
            icon: const Icon(
            Icons.search_outlined, 
            color: Colors.black,
            ),
            ),
          ],
        ),
      ],
    ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
   const AccountScreenAppBar({
   super.key,
   PreferredSize,
  });
}