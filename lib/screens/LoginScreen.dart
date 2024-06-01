import 'package:admin/constants.dart';
import 'package:admin/screens/main/loading.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart'; 
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

   TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  void validator(BuildContext context){
    if (emailController.text.isEmpty && passwordController.text.isEmpty ){

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your all fields" ,style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );
    }else if(emailController.text.isEmpty ){


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your Email", style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );

    }else if(passwordController.text.isEmpty ){


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your Password", style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),)
      );

    }
    else{
      loading(context);
      setState(() {
        isLoading = true;
      });
      Login(context);
    }
  }


   void Login(BuildContext context)async{
    try {
      firebase_auth.UserCredential userCredential =
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print(userCredential.user!.email);


      setState((){
        isLoading = false;
      });
      
Navigator.push(context, MaterialPageRoute(
                     
                                   builder: (context)=>
                     
                                    MainScreen()
                               )
                     
                              );

  SnackBar(content: Text("Successfully Logged In ", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.green,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
     
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),);
      
    } catch (e) {
      final snackbar = SnackBar(content: Text("Wrong combination of email & password..\nPlease try again", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.red,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(

          )),
              (route) => false);
      setState((){
        isLoading = false;
      });
    }
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

backgroundColor: Colors.white,

 body: ListView(

children: [

  SizedBox(height: 100,),
   Column(
      children: [



Container(
decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
color: Colors.pink,
),

height: 400,
  width: 400,
  child: Column(children: [
 SizedBox(height: 150,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: TextField(
            controller: emailController,
              decoration: InputDecoration(
          hintText: "Enter email",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                Icons.mail
              ),
            ),
          ),
              ),
            ),
        )
 
 
 ,

 SizedBox(height: 10,),
 
 Padding(
    padding: const EdgeInsets.symmetric(horizontal:20),
   child: TextField(
    
    controller: passwordController,
        decoration: InputDecoration(
          hintText: "Enter password",
         
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                Icons.lock
              ),
            ),
          ),
        ),
      ),
 ),


 SizedBox(height: 10,),
Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [


                        TextButton(
                            onPressed: (){
                              // finish(context);
                              // ForgotPasswordScreen().launch(context);
                            },
                            child: Text("Forgot Password?",style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF757575)
                            ))),

                      ],
                    ),

 
          
                     Padding(
                   padding: const EdgeInsets.symmetric(horizontal:20),
                       child: GestureDetector(
                     
                            onTap:()async{

                                validator(context);
                     
                              // Navigator.push(context, MaterialPageRoute(
                     
                              //     builder: (context)=>
                     
                              //         MainScreen()
                              // )
                     
                              // );
                     
                     
                            },
                            child:Container(
                               padding: const EdgeInsets.symmetric(horizontal:20),
                              alignment: Alignment.center,
                              width: 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                     
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFFffffff),
                                        Color(0xFFffffff),
                                        Color(0xFFffffff),
                                        
                                      ])
                     
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text('Login',
                     
                                  style: TextStyle(color: Colors.pink,
                                    fontSize: 20,
                                    fontFamily: 'Quicksand',
                                  ),
                                ),
                              ),
                            ),),
                     ),

                    SizedBox(height: 10,),
// OutlinedButton(
//       onPressed: () {
//         debugPrint('Received click');
//       },
//       child: const Text('Click Me'),

//       style: ButtonStyle(
       
//       ),
//     )
            //         Container(  
            //   margin: EdgeInsets.all(25),  
            //   child: OutlinedButton(  
            //     child: Text("Outline Button", style: TextStyle(fontSize: 20.0),),  
            //     highlightedBorderColor: Colors.red,  
            //     shape: RoundedRectangleBorder(  
            //         borderRadius: BorderRadius.circular(15)),  
            //     onPressed: () {},  
            //   ),  
            // ), 



  ]),
)
    ]),
 
],

 ),


    );
  }
}