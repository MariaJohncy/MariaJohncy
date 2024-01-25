import 'package:amazon_clone/Model/user_detials_model.dart';
import 'package:amazon_clone/Resources/cloudfirestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();

  Future <String> SignUp ({
  required String name, 
  required String address,
  required String email,
  required String password}) async{
  name.trim();
  address.trim();
  email.trim();
  password.trim();
  String output = "Something went wrong";
  if (name!= "" && address!="" && email!= "" && password!= ""){ //!= not equal
   try{
   await firebaseAuth.createUserWithEmailAndPassword(
    email: email, password: password);
    UserDetialsModel user = UserDetialsModel(name: name, address: address);
  await cloudFirestoreClass.uploadNameAndAddressToDatabase(user: user);
   output = "success";
   }on FirebaseAuthException catch(e){
    output = e.message.toString();   
   }
  } else {
    output = "please fill up all the fields";
  }
  return output;
}

Future <String> SignIn ({
  required String email,
  required String password}) async{
  email.trim();
  password.trim();
  String output = "Something went wrong";
  if (email!= "" && password!= ""){ 
   try{
   await firebaseAuth.createUserWithEmailAndPassword(
    email: email, password: password);
   output = "success";
   } on FirebaseException catch (e){
    output = e.message.toString();
   }
  } else {
    output = "Please fill up the fields.";
  }
  return output;
  }
} 