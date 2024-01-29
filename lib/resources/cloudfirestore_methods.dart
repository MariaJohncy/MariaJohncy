import 'dart:typed_data';
import 'package:amazon_clone/Model/order_request_model.dart';
import 'package:amazon_clone/Model/product_model.dart';
import 'package:amazon_clone/Model/review_model.dart';
import 'package:amazon_clone/Providers/user_detials_provider.dart';
import 'package:amazon_clone/Utils/utils.dart';
import 'package:amazon_clone/Widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../Model/user_detials_model.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNameAndAddressToDatabase(
      {required UserDetialsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    print(snap.data());

    UserDetialsModel userModels = UserDetialsModel.getModelFromJson(
      (snap.data() as dynamic),
    );
    return userModels;
  }

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something went wrong";

    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = utils().getUid();
        String url = await uploadImageToDatabse(image: image, uid: uid);
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));
        ProductModel product = ProductModel(
            url: url,
            productName: productName,
            cost: cost,
            discount: discount,
            uid: uid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            noOfRating: 0);
        await firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }
    return output;
  }

  Future<String> uploadImageToDatabse(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }
  Future<List<Widget>>getProductsFromDiscount (int discount)async{
    List<Widget> children = [];
   QuerySnapshot <Map<String,dynamic>> snap = await firebaseFirestore
    .collection("products")
    .where("discount",isEqualTo: discount)
    .get();
    
    for (int i = 0; i<snap.docs.length; i++){
    DocumentSnapshot docSnap = snap.docs[i];
    ProductModel model =
     ProductModel.getModelFromJson(json:(docSnap.data() as dynamic));
     children.add(SimpleProductWidget(productModel:model));
    }
    return children;
  }
  Future uploadReviewToDatabase ({
    required String productUid,
    required ReviewModel model}) async{
     await firebaseFirestore
      .collection("products")
      .doc(productUid)
      .collection("reviews")
      .add(model.getJson());
    }
  
   Future addProductToCart({required ProductModel productModel})async{
    await firebaseFirestore
    .collection("users")
    .doc(firebaseAuth.currentUser!.uid)
    .collection("cart")
    .doc(productModel.uid)
    .set(productModel.getJson());
   }
   Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
   .collection("Users")
   .doc(firebaseAuth.currentUser!.uid)
   .collection("cart")
   .doc(uid)
   .delete();
   }

   Future buyAllItemsInCart({ required UserDetialsModel userDetials}) async {
  QuerySnapshot<Map<String,dynamic>> snapshot = await firebaseFirestore
   .collection("Users")
   .doc(firebaseAuth.currentUser!.uid)
   .collection("cart")
   .get();

   for (int i = 0; i<snapshot.docs.length; i++){
    ProductModel model = ProductModel
    .getModelFromJson(json: snapshot.docs[i].data());
    addProductToOrders(model: model, userDetials: userDetials);
    await deleteProductFromCart(uid: model.uid);
   }
   }

   Future addProductToOrders({required ProductModel model, required UserDetialsModel userDetials}) async {
    await firebaseFirestore
    .collection("users")
    .doc(firebaseAuth.currentUser!.uid)
    .collection("orders")
    .add(model.getJson());
    await deleteProductFromCart(uid: model.uid);
   }
  Future sendOrderRequest ({required ProductModel model, required UserDetialsModel userDetials}) async {
  OrderRequestModel orderRequestModel = OrderRequestModel(
    orderName: model.productName,
     buyersAddress: userDetials.address);
     await firebaseFirestore
     .collection("users")
     .doc(model.sellerUid)
     .collection("orderRequests")
     .add(orderRequestModel.getJson());
  await sendOrderRequest(model: model, userDetials: userDetials);
  }
}