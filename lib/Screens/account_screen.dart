import 'package:amazon_clone/Model/order_request_model.dart';
import 'package:amazon_clone/Model/product_model.dart';
import 'package:amazon_clone/Model/user_detials_model.dart';
import 'package:amazon_clone/Providers/user_detials_provider.dart';
import 'package:amazon_clone/Screens/sell_screen.dart';
import 'package:amazon_clone/Widgets/custom_main_button.dart';
import 'package:amazon_clone/Widgets/product_showcase_list_view.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:amazon_clone/Widgets/Account_screen_App_Bar_Widget.dart';
import 'package:amazon_clone/Widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AccountScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height - (kAppBarHeight / 2),
          width: screenSize.width,
          child: Column(children: [
            const IntroductionAccountWidgetScreen(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomMainButton(
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.orange,
                  isloading: false,
                  onPressed: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomMainButton(
                  child: const Text(
                    "Sell",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  color: yellowColor,
                  isloading: false,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder:(context)=>const SellScreen()));
                  }),
            ),
             FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orders")
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      List<Widget> children = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        ProductModel model = ProductModel.getModelFromJson(
                            json: snapshot.data!.docs[i].data());
                        children.add(SimpleProductWidget(productModel: model));
                      }
               return ProductShowCaseListView(
                title: "Your Orders", children: testChildren);
                    }
                    }),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order Requests",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(stream:
             FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("orderRequests")
              .snapshots(),
              builder: 
              (context,
              AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
                if (snapshot.connectionState == ConnectionState.waiting){
                  return Container();
                } else {
                 return ListView.builder(
                    itemCount: snapshot.data!.docs.hashCode,
                  itemBuilder: (context,index){
                    OrderRequestModel model = OrderRequestModel.getModelFromJson(json: snapshot.data!.docs[index].data());
                  }
                  );
                }
              }
              ),
              
            ),
          ]),
          ),
          ),
          );
                    }
                  }
class IntroductionAccountWidgetScreen extends StatelessWidget {
  const IntroductionAccountWidgetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserDetialsModel userDetialsModel =
        Provider.of<userDetialsProvider>(context).userDetials;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.000000000001),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: " Hello, ",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 27,
                      ),
                    ),
                    TextSpan(
                      text: userDetialsModel.name,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: 20,
              ),
            ),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
