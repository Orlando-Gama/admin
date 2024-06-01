import 'package:admin/OtherScreens/ClientScreen.dart';
import 'package:admin/OtherScreens/ProfileScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:admin/OtherScreens/SystemUsersScreen.dart';
import 'package:admin/OtherScreens/TransactionsScreen.dart';
import 'package:admin/main.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  _logoutAlert(context) {
    Alert (

        context: context,
      image:Icon(

        Icons.question_mark
      ),


        desc: "Are you sure to logout?",

        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () =>Navigator.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle( fontSize: 20,),
            ),
          ),
          DialogButton(
           color: Colors.black,
            onPressed: () async{

              await FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyApp()));
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    Drawer(
      backgroundColor: Colors.pink,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
         
         DrawerListTile(
             title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
             press: () {

 Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(

          )),
              (route) => false);

             },
            ),
            DrawerListTile(
            title: "Transaction",
            svgSrc: "assets/icons/menu_tran.svg",
             press: () {

               Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TransactionsScreen(

          )),
              (route) => false);
             },
            ),
           DrawerListTile(
            title: "Clients",
              svgSrc: "assets/images/sellers.svg",
             press: () {

                 Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ClientScreen(

          )),
              (route) => false);
             },
           ),
            DrawerListTile(
             title: "System Users",
             svgSrc: "assets/icons/menu_doc.svg",
              press: () {

                   Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SystemUsersScreen(

          )),
              (route) => false);
              },
           ),
          
          
         DrawerListTile(
             title: "Profile",
           svgSrc: "assets/images/user.svg",
             press: () {

                 Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(

          )),
              (route) => false);
             },
           ),
          DrawerListTile(
             title: "Logout",
            svgSrc: "assets/images/sign-out.svg",
             press: () async{

              await  _logoutAlert(context);
             },
         ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
