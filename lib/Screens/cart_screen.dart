import 'package:amazon_clone/Providers/user_detials_provider.dart';
import 'package:amazon_clone/Resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/Utils/utils.dart';
import 'package:amazon_clone/Widgets/custom_main_button.dart';
import 'package:amazon_clone/Model/product_model.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:amazon_clone/Widgets/User_detials_bar.dart';
import 'package:amazon_clone/Widgets/cart_item_widget.dart';
import 'package:amazon_clone/Widgets/search_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
      isReadOnly: true,
      hasBackButton: false),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: kAppBarHeight / 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("cart").snapshots(),
                      builder: (context, 
                      AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>
                      snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CustomMainButton(
                          child: const Text("Loading",
                          style: TextStyle(
                          color: Colors.black,
                          ),
                          ), 
                        color: yellowColor, 
                        isloading: true, 
                        onPressed: (){});
                        } else{
                         return CustomMainButton(
                        child: Text(
                          "Proceed to buy (${snapshot.data!.docs.length})items",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ), 
                        color: yellowColor,
                       isloading: false,
                       onPressed: ()async{
                        await CloudFirestoreClass().buyAllItemsInCart(
                          userDetials: 
                          Provider.of<userDetialsProvider>(context,listen: false).userDetials);
                        utils().showSnackbar(
                          context: context, content: "Done");
                       }); 
                       }
                      }),
                    ),
                    Expanded(
                    child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("cart").snapshots(),
                    builder: (context, 
                    AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
                    if (
                      snapshot.connectionState == ConnectionState.waiting){
                      return Container();
                    } else {
                    return ListView.builder(
                    itemCount:snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                    ProductModel model = ProductModel.getModelFromJson(
                    json: snapshot.data!.docs[index].data());
                    return CartItemWidget(product:model);
                    });
                    }
                 }),
                    ),
                  ],
            ),
             const UserDetialBar(
              offset: 0),
          ],
        ),
      ),
    );
  }
}