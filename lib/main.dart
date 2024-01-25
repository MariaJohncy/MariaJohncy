import 'package:amazon_clone/Firebase_Options.dart';
import 'package:amazon_clone/Providers/user_detials_provider.dart';
import 'package:amazon_clone/Layouts/screen_layout.dart';
//import 'package:amazon_clone/Screens/sell_screen.dart';
import 'package:amazon_clone/Screens/sign_in_screen.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
runApp(const Amazonapp());
}
class Amazonapp extends StatelessWidget {
  const Amazonapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
    ChangeNotifierProvider(create: (_)=>userDetialsProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Amazon Clone",
       theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor),
     home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      // ignore: non_constant_identifier_names
      builder: (context, AsyncSnapshot<User?> User){
      if(User.connectionState == ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      } else if (User.hasData){
      return const ScreenLayout();
     // return const SellScreen();
       } else {
      return const SignIn();
      }
       }),
      ),
    );
  }
}