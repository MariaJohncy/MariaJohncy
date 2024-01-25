import 'package:amazon_clone/Resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/Widgets/Ad_banner_widget.dart';
import 'package:amazon_clone/Widgets/categories_horizontal_list_view_bar.dart';
import 'package:amazon_clone/Widgets/loading_widget.dart';
import 'package:amazon_clone/Widgets/product_showcase_list_view.dart';
import 'package:amazon_clone/Utils/data.dart';
import 'package:amazon_clone/Widgets/User_detials_bar.dart';
import 'package:amazon_clone/Widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() { 
     setState(() {
     offset = controller.position.pixels;
     });
    });
  }

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

   void getData()async{
   List <Widget> temp70 = await CloudFirestoreClass().getProductsFromDiscount(70);
   List <Widget> temp60 = await CloudFirestoreClass().getProductsFromDiscount(60);
   List <Widget>temp50 = await CloudFirestoreClass().getProductsFromDiscount(50);
   List <Widget> temp0 = await CloudFirestoreClass().getProductsFromDiscount(0);
   print("everything is done");

   setState(() {
     discount70 != temp70;
     discount60 != temp60;
     discount50 != temp50;
     discount0 != temp0;
   });
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
         hasBackButton: false),
        body: discount70!=null && 
              discount60!=null &&
              discount50!=null &&
              discount0!=null
              ? Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [ 
                  const SizedBox(
                    height: kAppBarHeight / 2,
                  ),
                  const CategoriesHorizontalListView(),const AdBannerWidget(),
                  ProductShowCaseListView(
                    title: "Upto 70% Off",
                   children: discount70!),
                  ProductShowCaseListView(
                    title: "Upto 60% Off", 
                    children: discount60!),
                  ProductShowCaseListView(
                    title: "Upto 50% Off", 
                    children: discount50!),
                  ProductShowCaseListView(
                    title: "Explore", 
                    children: discount0!),
                ],
              ),
            ),
            UserDetialBar(offset: offset),
          ],
        ): const LoadingWidget(),
    );
  }
}