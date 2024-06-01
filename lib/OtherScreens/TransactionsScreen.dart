import 'package:admin/OtherScreens/TransactionMoreScreen.dart';
import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
   List<String> categories = [
    "All",
    "Approved",
    "Pending",
    "Paid",
    "Denied",
  ];

  int selectedIndex = 0;

   Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        margin: const EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.pink : Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            categories[index],
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
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
            "Transactions",
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
                      SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => buildCategory(index),
                ),
              ),
                      SizedBox(height: defaultPadding),


                       selectedIndex == 0
                ?
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
            "Recent Transaction",
            style: Theme.of(context).textTheme.titleMedium,
          ),

StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("transactions").snapshots(),
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
    return SizedBox(
           
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Client"),
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
                DataColumn(
                  label: Text("Status"),
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
             transaction[i]['image'][0],
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
      DataCell(Text("Mwk ${(transaction[i]['total'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00")),
      DataCell(Text(transaction[i]['status'])),
      DataCell(Text(transaction[i]['createdAt'])),
      DataCell(IconButton(
        icon:Icon(Icons.remove_red_eye_outlined) ,

      onPressed: (){

         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TransactionMoreScreen(

            id: transaction[i]['id'],
  uid:transaction[i]['uid'] ,
          )),
              (route) => false);
      },
      )
      
      ),
    ],
  )
                ]

              ],
              // rows: List.generate(
              //   demoRecentFiles.length,

                
              //   (index) => recentFileDataRow(demoRecentFiles[index]),
              // ),
            ),
          );

  })


          
        ],
      ),
    )   :  selectedIndex == 1 ?
    
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
            "Recent Transaction",
            style: Theme.of(context).textTheme.titleMedium,
          ),

StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("transactions") .where("status", isEqualTo: "Approved").snapshots(),
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
    return SizedBox(
           
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Client"),
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
                DataColumn(
                  label: Text("Status"),
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
             transaction[i]['image'][0],
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
      DataCell(Text("Mwk ${(transaction[i]['total'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00")),
      DataCell(Text(transaction[i]['status'])),
      DataCell(Text(transaction[i]['createdAt'])),
      DataCell(IconButton(
        icon:Icon(Icons.remove_red_eye_outlined) ,

      onPressed: (){

         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TransactionMoreScreen(

            id: transaction[i]['id'],
  uid:transaction[i]['uid'] ,
          )),
              (route) => false);
      },
      )
      
      ),
    ],
  )
                ]

              ],
              // rows: List.generate(
              //   demoRecentFiles.length,

                
              //   (index) => recentFileDataRow(demoRecentFiles[index]),
              // ),
            ),
          );

  })


          
        ],
      ),
    )   :  selectedIndex == 2 ?Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Transaction",
            style: Theme.of(context).textTheme.titleMedium,
          ),

StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("transactions") .where("status", isEqualTo: "Pending").snapshots(),
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
    return SizedBox(
           
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Client"),
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
                DataColumn(
                  label: Text("Status"),
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
             transaction[i]['image'][0],
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
      DataCell(Text("Mwk ${(transaction[i]['total'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00")),
      DataCell(Text(transaction[i]['status'])),
      DataCell(Text(transaction[i]['createdAt'])),
      DataCell(IconButton(
        icon:Icon(Icons.remove_red_eye_outlined) ,

      onPressed: (){

         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TransactionMoreScreen(

            id: transaction[i]['id'],
  uid:transaction[i]['uid'] ,
          )),
              (route) => false);
      },
      )
      
      ),
    ],
  )
                ]

              ],
              // rows: List.generate(
              //   demoRecentFiles.length,

                
              //   (index) => recentFileDataRow(demoRecentFiles[index]),
              // ),
            ),
          );

  })


          
        ],
      ),
    )   :  selectedIndex == 3 ?Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Transaction",
            style: Theme.of(context).textTheme.titleMedium,
          ),

StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("transactions") .where("status", isEqualTo: "Paid").snapshots(),
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
    return SizedBox(
           
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Client"),
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
                DataColumn(
                  label: Text("Status"),
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
             transaction[i]['image'][0],
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
      DataCell(Text("Mwk ${(transaction[i]['total'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00")),
      DataCell(Text(transaction[i]['status'])),
      DataCell(Text(transaction[i]['createdAt'])),
      DataCell(IconButton(
        icon:Icon(Icons.remove_red_eye_outlined) ,

      onPressed: (){

         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TransactionMoreScreen(

            id: transaction[i]['id'],
  uid:transaction[i]['uid'] ,
          )),
              (route) => false);
      },
      )
      
      ),
    ],
  )
                ]

              ],
              // rows: List.generate(
              //   demoRecentFiles.length,

                
              //   (index) => recentFileDataRow(demoRecentFiles[index]),
              // ),
            ),
          );

  })


          
        ],
      ),
    )   :  selectedIndex == 4 ?Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Transaction",
            style: Theme.of(context).textTheme.titleMedium,
          ),

StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("transactions")
  .where("status", isEqualTo: "Denied")
  .snapshots(),
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
    return SizedBox(
           
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Client"),
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
                DataColumn(
                  label: Text("Status"),
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
             transaction[i]['image'][0],
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
      DataCell(Text("Mwk ${(transaction[i]['total'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00")),
      DataCell(Text(transaction[i]['status'])),
      DataCell(Text(transaction[i]['createdAt'])),
      DataCell(IconButton(
        icon:Icon(Icons.remove_red_eye_outlined) ,

      onPressed: (){

         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TransactionMoreScreen(

            id: transaction[i]['id'],
            uid:transaction[i]['uid'] ,

          )),
              (route) => false);
      },
      )
      
      ),
    ],
  )
                ]

              ],
              // rows: List.generate(
              //   demoRecentFiles.length,

                
              //   (index) => recentFileDataRow(demoRecentFiles[index]),
              // ),
            ),
          );

  })


          
        ],
      ),
    )   :  SizedBox(),
                      
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