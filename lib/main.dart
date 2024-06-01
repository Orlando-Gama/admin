import 'package:admin/constants.dart'; 
import 'package:admin/screens/LoginScreen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: FirebaseOptions(
      apiKey:  "AIzaSyBuxcZ-Da-e3GkU5qZcwdd0CS8N--GIquo", 
      appId: "1:848282982252:web:6baaa46e4de581e1964549", 
      messagingSenderId: "848282982252", 
      projectId: "rep-sync")
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initilize = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tadza Loan Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home:    FutureBuilder(
          
          future: _initilize,
          builder: ((context, snapshot) {


          if(snapshot.hasError){
            print("object");
          }if(snapshot.connectionState == ConnectionState.done){
            return    StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (!snapshot.hasData) {
              return  LoginScreen();
            }
            return MainScreen();
          },
        );
          }return Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        })),
      
    );
  }
}
