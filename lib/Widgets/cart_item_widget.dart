import 'package:amazon_clone/Model/product_model.dart';
import 'package:amazon_clone/Resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/Screens/product_screens.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:amazon_clone/Utils/utils.dart';
import 'package:amazon_clone/Widgets/custom_simple_rounded_button.dart';
import 'package:amazon_clone/Widgets/custom_square_button.dart';
import 'package:amazon_clone/Widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({super.key,
  required this.product,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child:GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>
                    ProductScreen(productModel: product)), 
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Image.network(
                            product.url),
                      ),
                    ),
                  ),
                  ProductInformationWidget(
                      productName:product.productName,
                      cost: product.cost,
                      sellerName: product.sellerName),
                ],
              ),
            ),
          ),
          Expanded(
             flex: 3,
            child: Row(
              children: [
                CustomSquareButton(
                    onPressed: () {},
                    color: backgroundColor,
                    dimension: 40,
                     child: const Icon(Icons.remove),
                    ),
                CustomSquareButton(
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40,
                    child: const Text(
                      "0",
                      style: TextStyle(
                        color: activeCyanColor,
                      ),
                    ),
                    ),
                CustomSquareButton(
                    onPressed: () async {
                    await CloudFirestoreClass()
                    .addProductToCart(productModel: ProductModel(
                      url:product.url, 
                      productName: product.productName, 
                      cost: product.cost,
                       discount: product.discount,
                        uid: utils().getUid(),
                         sellerName: product.sellerName,
                          sellerUid: product.sellerUid,
                           rating: product.rating,
                            noOfRating: product.noOfRating));
                    },
                    color: backgroundColor,
                    dimension: 40,
                    child: const Icon(Icons.add),
                    ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                          onPressed: ()async{
                          CloudFirestoreClass().deleteProductFromCart(uid: product.uid);
                          },
                         text: "Delete"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                          onPressed: () {}, 
                          text: "Save for later"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more like this",
                        style: TextStyle(
                          color: activeCyanColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
