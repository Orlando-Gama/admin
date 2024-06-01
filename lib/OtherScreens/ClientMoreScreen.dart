import 'package:admin/OtherScreens/TransactionMoreScreen.dart';
import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/MyFiles2.dart'; 
import 'package:admin/screens/dashboard/components/header.dart';  
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClientMoreScreen extends StatefulWidget {
  const ClientMoreScreen({Key? key, this.uid}) : super(key: key);

  final uid;

  @override
  State<ClientMoreScreen> createState() => _ClientMoreScreenState();
}

class _ClientMoreScreenState extends State<ClientMoreScreen> {
 
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
            "Dashboard",
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
                       MyFiles2(uid: widget.uid,),
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
            "User Transaction",
            style: Theme.of(context).textTheme.titleMedium,
          ),


StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("transactions")
  .where("uid", isEqualTo: widget.uid)
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
    return
          SizedBox(
           
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

          )),
              (route) => false);
      },
      )
      
      ),
    ],
  )

                ]
              ],
              
            ),
          );
  }
)










        ],
      ),
    ),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) 
                      
                     StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.uid)

        .snapshots(),
    builder: (context, snapshot) {

    if (snapshot.hasError) {
    return Center(child: Text("Something went wrong"));
    }
    else if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator(
    color: Colors.white,
    ));
    }

    else {
    return ListView.builder(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemCount: snapshot.data!.docs.length,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
    DocumentSnapshot doc = snapshot.data!.docs[index];


    return 
                      
                      Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "User Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
           SizedBox(
      height: 200,
      child: Stack(
        children: [

            
           Center(
             child: CircleAvatar(
              radius: 300,
              backgroundImage: NetworkImage(doc['profilePic']),
             ),
           )
        ],
      ),
    ),
         

Container(
  width: 300,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child:  Text(
                    doc['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
    )
,
Container(
       width: 300,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   doc['email'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    doc['number'],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),

                  Text(
                    doc['address'],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
         
        ],
      ),
    )
,
  Container(
       width: 300,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   
                  Text(
                     doc['date'],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),

                  
                ],
              ),
            ),
          ),
         
        ],
      ),
    )
,

       
        ],
      ),







    );});}}),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: 
                    
                    StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.uid)

        .snapshots(),
    builder: (context, snapshot) {

    if (snapshot.hasError) {
    return Center(child: Text("Something went wrong"));
    }
    else if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator(
    color: Colors.white,
    ));
    }

    else {
    return ListView.builder(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemCount: snapshot.data!.docs.length,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
    DocumentSnapshot doc = snapshot.data!.docs[index];


    return 
                      
                      Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "User Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
           SizedBox(
      height: 200,
      child: Stack(
        children: [

            
           Center(
             child: CircleAvatar(
              radius: 300,
              backgroundImage: NetworkImage(doc['profilePic']),
             ),
           )
        ],
      ),
    ),
         

Container(
  width: 300,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child:  Text(
                    doc['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
    )
,
Container(
       width: 300,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   doc['email'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    doc['number'],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),

                  Text(
                    doc['address'],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
         
        ],
      ),
    )
,
  Container(
       width: 300,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   
                  Text(
                     doc['date'],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),

                  
                ],
              ),
            ),
          ),
         
        ],
      ),
    )
,

       
        ],
      ),







    );});}}),
                  ),
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
