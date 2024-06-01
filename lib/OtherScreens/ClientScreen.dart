import 'package:admin/OtherScreens/ClientMoreScreen.dart';
import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
 
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                
                child: SideMenu()
                
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
      children: [
        if (!Responsive.isDesktop(context))

          Container(
            height: 50,
            width: 50,
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.pink
            ),
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white,),
              onPressed: (){
          
                 if (!_scaffoldKey.currentState!.isDrawerOpen) {
                _scaffoldKey.currentState!.openDrawer();
              }
              },
            ),
          ),

          SizedBox(width: 10,),
        if (!Responsive.isMobile(context))
          Text(
            "Clients",
            style: TextStyle(
              color: Colors.pink,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: 
        TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor:  Colors.pink,
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
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg", color: Colors.pink,),
          ),
        ),
      ),
    )),
       ProfileCard()
      ],
    ),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                     
                      SizedBox(height: defaultPadding),
                      Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client User",
            style: Theme.of(context).textTheme.titleMedium,
          ),

StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("sellers").snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


    if(snapshot.hasError){
      print("Something went wrong");
    }if(snapshot.connectionState == ConnectionState.waiting){

      return Center(
        child: CircularProgressIndicator()
      );

    } 


final List transaction = [];

snapshot.data!.docs.map((DocumentSnapshot  document){


Map a = document.data() as Map<String, dynamic>;

transaction.add(a);


}).toList();

return   SizedBox(
           
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Client"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Number"),
                ),
                 DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: [
  for (var i = 0; i<transaction.length; i++)...[
                DataRow(
    cells: [
      DataCell(
        Row(
          children: [
          Image.network(
             transaction[i]['profilePic'],
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(transaction[i]['name']),
            ),
          ],
        ),
      ),
      DataCell(Text(transaction[i]['email'])),
      DataCell(Text(transaction[i]['number'])),
      DataCell(Text(transaction[i]['date'])),
      DataCell(IconButton(
        icon:Icon(Icons.remove_red_eye_outlined) ,

      onPressed: (){

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ClientMoreScreen(

            uid: transaction[i]['uid'],

          )),
              (route) => false);
      },
      )),
    ],
  )

  ]
              ],
            
            ),
          );


  }
),



         










        ],
      ),
    ),
                      
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
              ],
            )
          ],
        ),
      ),
    ),
            ),
          ],
        ),
      ),
    );
  }
}