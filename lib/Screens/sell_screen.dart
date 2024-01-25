import 'dart:typed_data';
import 'package:amazon_clone/Providers/user_detials_provider.dart';
import 'package:amazon_clone/Resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:amazon_clone/Utils/utils.dart';
import 'package:amazon_clone/Widgets/custom_main_button.dart';
import 'package:amazon_clone/Widgets/loading_widget.dart';
import 'package:amazon_clone/Widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isloading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int>keysForDiscount = [0,70,60,50];

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: !isloading? SingleChildScrollView(
      child:SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
          Stack(
            children: [
             image==null? Image.network("https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
              height: screenSize.height/10,
              ):Image.memory(
                image!,
                height: screenSize.height/10,
              ),
              IconButton(onPressed: ()async{
              Uint8List? temp = await utils().pickImage();
              if (temp != null){
                setState(() {
                  image = temp;
                });
              }
              }, icon: const Icon(Icons.file_upload)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 35, vertical: 10,
            ),
            height: screenSize.height*0.7,
            width: screenSize.width*0.7,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const Text("Item Detials",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                ),
                TextFieldwidget(
                  title: "Name",
                 controller: nameController,
                 obscureText: false,
                 hintText: "Enter the name of Item"),
                  TextFieldwidget(
                  title: "Cost",
                  controller: costController,
                 obscureText: false,
                 hintText:"Enter the cost of Item"),
                 const Text("Discount",
                 style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                 ),
                 ),
                 ListTile(
                  title: const Text(
                    "None",
                  ),
                  leading: Radio(
                    value: 1,
                   groupValue: selected, 
                   onChanged: (int?i){
                    setState(() {
                      selected = i!;
                    });
                   }),
                 ),
                 ListTile(
                  title: const Text(
                    "70%",
                  ),
                  leading: Radio(
                    value: 2,
                   groupValue: selected, 
                   onChanged: (int?i){
                    setState(() {
                      selected = i!;
                    });
                   }),
                 ),
                 ListTile(
                 title : const Text(
                    "60%",
                  ),
                  leading: Radio(
                    value: 3,
                   groupValue: selected, 
                   onChanged: (int?i){
                    setState(() {
                      selected = i!;
                    });
                   }),
                 ),
                 ListTile(
                  title: const Text(
                    "50%",
                  ),
                  leading: Radio(
                    value: 4,
                   groupValue: selected, 
                   onChanged: (int?i){
                    setState(() {
                      selected = i!;
                    });
                   }),
                 ),
              ],
            ),
          ),
          CustomMainButton(
            child:Text("Sell",
            style: TextStyle(
            color: Colors.black,
            ),
            ), 
            color: yellowColor,
             isloading: isloading,
              onPressed: ()async{
                String output = await CloudFirestoreClass().uploadProductToDatabase(
                image: image,
               productName: nameController.text,
                rawCost: costController.text,
                 discount: keysForDiscount[selected-1], 
                 sellerName: Provider.of<userDetialsProvider>(context,listen: false).userDetials.name,
                  sellerUid: FirebaseAuth.instance.currentUser!.uid,
                  );
                  if(output == "Success"){
                    utils().showSnackbar(
                      context: context,
                       content: "Posted P0roduct");
                  } else{
                    utils().showSnackbar(
                    context: context,
                     content: output);
                  }
              }),
              CustomMainButton(child: const Text("Back",
              style: TextStyle(
                color: Colors.black,
              ),
              ), 
              color: Colors.grey[300]!, 
              isloading: false,
               onPressed: (){
                Navigator.pop(context);
               })
              ],
            ),
          ),
        ),
      ),
      )
      :const LoadingWidget(),
    ));
  }
}