import 'package:amazon_clone/Model/review_model.dart';
import 'package:amazon_clone/Providers/user_detials_provider.dart';
import 'package:amazon_clone/Resources/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({super.key,
  required this.productUid});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        'Type a review for this Product!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      submitButtonText: 'Send',
      commentHint: 'Type here',
     
      onSubmitted: (RatingDialogResponse res) async{
      CloudFirestoreClass().uploadReviewToDatabase(
        productUid: productUid, model:ReviewModel(
          senderName: Provider.of<userDetialsProvider>(context,listen: false).userDetials.name,
          description: res.comment,
          rating: res.rating.toInt()));
      },
    );
  }
}