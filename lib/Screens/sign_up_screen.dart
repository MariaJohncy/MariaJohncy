import 'package:amazon_clone/Screens/sign_in_screen.dart';
import 'package:amazon_clone/Widgets/text_field_widget.dart';
import 'package:amazon_clone/Widgets/custom_main_button.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:amazon_clone/Resources/authenticationmethods.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isloading = false;

  @override
  void dispose() {
    namecontroller.dispose();
    addresscontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(padding: const EdgeInsets.symmetric(
         horizontal: 10, 
         vertical: 20),
         child: Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(amazonLogo,
              height: screenSize.height*0.10,
              ),
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        height: screenSize.height*0.85,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(                          
                              "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                 fontSize: 33),
                            ),
                          ),
                          TextFieldwidget(title: "Name",
                        controller: namecontroller,
                         obscureText: false,
                          hintText: "Enter your name",
                          ),
                           TextFieldwidget(title: "Address",
                        controller: addresscontroller,
                         obscureText: false,
                          hintText: "Enter your address",
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
                          child: CustomMainButton(child: const Text("Sign In", 
                          style: TextStyle(letterSpacing:0.6, 
                          color: Colors.black),), 
                          color: yellowColor, 
                          isloading:  false,
                          onPressed: () async {
                            setState(() {
                              isloading = isloading;
                            });
                          String output = await authenticationMethods.SignUp(
                            name: namecontroller.text,
                            address:addresscontroller.text, 
                            email: emailcontroller.text,
                            password: passwordcontroller.text);
                          setState(() {
                            isloading = false;
                          });  
                          if (output == "Success"){
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:(_)=> 
                        const SignIn(),
                        ),
                        );
                          }else{
                            print(output); //log => print
                          }
                          },
                          ),
                          ),
                        ],
                       ),
                      ),
                    ),
                  ),
                    CustomMainButton(child:const Text("Back",
                    style: TextStyle(letterSpacing: 0.6,
                    color: Colors.black,),
                     ),
        color: Colors.grey[400]!,
         isloading: false, onPressed: (){
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context){
              return const SignIn();
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