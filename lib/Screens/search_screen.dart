//import 'package:amazon_clone/Model/user_detials_model.dart';
import 'package:amazon_clone/Widgets/User_detials_bar.dart';
import 'package:amazon_clone/Widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
      body: const Stack(
        children: [
          SingleChildScrollView(
            child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
          ],
          ),
          ),
          UserDetialBar(offset: 0),
        ],
      ),
    );
  }
}