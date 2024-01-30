import 'package:amazon_clone/Screens/sign_up_screen.dart';
import 'package:amazon_clone/Utils/utils.dart';
import 'package:amazon_clone/Widgets/custom_main_button.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:amazon_clone/Widgets/text_field_widget.dart';
import 'package:amazon_clone/Resources/authenticationmethods.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isloading = false;
  
  @override
  void dispose(){
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
 Widget build(BuildContext context){
  Size screenSize = MediaQuery.of(context).size;    //Screen size
  return Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(padding: const EdgeInsets.symmetric(
         horizontal: 10, vertical: 20,),
         child: Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(amazonLogo,                  
              height: screenSize.height*0.10,
              ),
                  Container(
                    height: screenSize.height*0.6,
                    width: screenSize.width*0.8,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                   child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign In",                                    
                        style: TextStyle(
                        fontWeight: FontWeight.w500,
                         fontSize: 33),
                      ),
                      TextFieldwidget(title: "Email",                
                    controller: emailcontroller,
                     obscureText: false,
                      hintText: "Enter your email",
                      ),
                      TextFieldwidget(title: "Password",
                    controller: passwordcontroller,
                     obscureText: true,
                      hintText: "Enter your password",
                      ),
                    Align(
                      alignment:Alignment.center ,
                      child:CustomMainButton(
                        child: const Text("Sign In", 
                      style: TextStyle(
                      letterSpacing:0.5, 
                      color: Colors.black),
                      ), 
                      color: yellowColor,                                      
                      isloading:  false,
                      onPressed: () async {
                        setState(() {
                          isloading = false;
                        });
                       String output = await authenticationMethods.SignIn(
                          email: emailcontroller.text, password: passwordcontroller.text);
                          setState(() {
                            isloading = isloading;                              //loading procedure
                          });
                          if (output == "success"){
                          } else {
                            utils().showSnackbar(                     //temporary messages
                              context: context, content:output);
                          }
                      }),
                      ),
                    ],
                   ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                     const Padding(
                       padding:EdgeInsets.symmetric(horizontal: 10),
                       child:Text(
                          "New to Amazon?",
                          style: TextStyle(color: Colors.grey),
                          ),
                     ),
                        Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                    CustomMainButton(child:const Text(
                      "Create an Amazon account",
                    style: TextStyle(
                      letterSpacing: 0.6,
                    color: Colors.black,
                    ),
                     ),
        color: Colors.grey[400]!,
         isloading: false, onPressed: (){
          Navigator.pushReplacement(context,
          MaterialPageRoute(builder:(context){
            return const SignUp();
          }),
          );
         }),
          ],
          ),
         ),
        ),
      ),
    ),
  );
 }
}