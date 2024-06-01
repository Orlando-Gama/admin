import 'package:admin/OtherScreens/ClientMoreScreen.dart';
import 'package:admin/constants.dart';
import 'package:admin/responsive.dart'; 
import 'package:admin/screens/dashboard/components/header.dart'; 
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TransactionMoreScreen extends StatefulWidget {
  const TransactionMoreScreen({Key? key, this.id, this.uid}) : super(key: key);

  final id;
  final uid;

  @override
  State<TransactionMoreScreen> createState() => _TransactionMoreScreenState();
}

class _TransactionMoreScreenState extends State<TransactionMoreScreen> {
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
int _selected = 0;


 void ShowImages(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.transparent.withOpacity(0.05),
          body: Center(
            child: Hero(
              tag: 'my-hero-animation-tag',
              child: Container(
                height: 500,

                child: Stack(
                  children: [
                    SizedBox(height: 20,),
                    PageView(
                      onPageChanged: (num){
                        setState((){
                          _selected = num;
                        });
                      },
                      children: [
                        //for(var i = 0; i < imagelist.length; i++ )

                        /*FullScreenWidget(
                      child:
                    )*/
                          Container(
                            margin: EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage("assets/images/user-profile-icon-free-vector.jpg"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),

                      ],
                    ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //for(var i = 0; i < imagelist.length; i++ )
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: _selected == 0 ? Color(0xff016DD1) : Colors.white,
                              ),
                              width: _selected == 0 ? 20 : 10,
                              height: 10,
                              margin: EdgeInsets.symmetric(horizontal: 12),)
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 20,
                      child: GestureDetector(
                        onTap:(){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          //   return ProductDetail(
                          //     p: widget.p,
                          //     name: widget.name,
                          //   );
                          // }));
                        },
                        child: Text('Winkford',style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20), ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap:(){
                             
                            },
                            child:Icon(Icons.close, color: Colors.white, size: 20,) /*Text('$namee',style: TextStyle(
                                  fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20), )*/,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

signOutUser()async{
   
       AlertDialog(
         backgroundColor: Colors.white,
         title: Text('Confirm Transaction '),
         content: Text('Remember the moment you confirm this theres no coming back'),
         actions: [
           TextButton(onPressed: (){
            // Get.back();

           }, child: Text('Deny Loan')
           ),
           TextButton(onPressed: (){
           //  Get.back(result: 'loggedOut');

           }, child: Text(
               'Approve Loan'
           )),
         ],
       );
   
 }
  _logoutAlert(context, id) {
    Alert (

        context: context,
      image:Icon(

        Icons.question_mark
      ),


        desc: "Remember the moment you confirm this theres no coming back",

        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () async{

               await Deny(id);
            },
            child: Text(
              "Deny Loan",
              style: TextStyle( fontSize: 20,),
            ),
          ),
          DialogButton(
           color: Colors.black,
            onPressed: () async{

             await Approve(id);
              

          
            },
            child: Text(
              "Approve Loan",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),

          //  DialogButton(
          //  color: Colors.black,
          //   onPressed: () async{
              

          
          //   },
          //   child: Text(
          //     "Pay Loan",
          //     style: TextStyle(color: Colors.white, fontSize: 20),
          //   ),
          // )
        ]).show();
  }
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;


  CollectionReference transaction= FirebaseFirestore.instance.collection("transactions");
    Future<bool> Approve(id) async {
    try {
      await transaction.doc(id).update({
        'status': 'Approved',
      });

     SnackBar(content: Text("Transaction approved successfuly", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.green,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),);

      return true; // Return true if the operation was successful.
    } catch (error) {
      // Handle any errors or exceptions here
      // You can log the error or display an error message.
     SnackBar(content: Text("Transaction approving was unsuccessful", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.red,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),);

      return false; // Return false if there was an error.
    }
  }

    Future<bool> Deny(id) async {
    try {
      await transaction.doc(id).update({
        'status': 'Denied',
      });

     SnackBar(content: Text("Transaction denied successfuly", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.green,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),);

      return true; // Return true if the operation was successful.
    } catch (error) {
      // Handle any errors or exceptions here
      // You can log the error or display an error message.
     SnackBar(content: Text("Transaction denying was unsuccessful", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.red,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),);

      return false; // Return false if there was an error.
    }
  }

   Future<bool> pay(id) async {
    try {
      await transaction.doc(id).update({
        'status': 'Paid',
      });

     SnackBar(content: Text("Transaction has been paid successfuly", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.green,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),);

      return true; // Return true if the operation was successful.
    } catch (error) {
      // Handle any errors or exceptions here
      // You can log the error or display an error message.
     SnackBar(content: Text("Transaction paid was unsuccessful", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.red,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),);

      return false; // Return false if there was an error.
    }
  }

 List imagelist = [];
  @override
  Widget build(BuildContext context) {
    
 
   final Size _size = MediaQuery.of(context).size;
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
            "Transaction Details",
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
                  flex: 3,
                  child: Column(
                    children: [
                        Column(
      children: [
        
        SizedBox(height: defaultPadding),
        Responsive(
          mobile:
          GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1, 
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding, 
      //itemCount: 4,
      
      children: [

    
StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.uid )

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


        GestureDetector(
          onTap: (){
            Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ClientMoreScreen(

          )),
              (route) => false);
          },
          child: Container(
              padding: EdgeInsets.all(defaultPadding),
            
              child: CircleAvatar(
          backgroundColor: Colors.yellow,
          radius: 75,
        
          backgroundImage:NetworkImage(doc['profilePic'] ),
              
              ),
            ),
        );
        
    });}}),
    
    
StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.uid )

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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
            doc['name'],
             style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            Divider( color: Colors.black,),
           Text(
            doc['email'],
            style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(
            color: Colors.black,
          ),
           Text(
            doc['number'],style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            
        ],
      ),
    );
        
    });}}),
    

   Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/images/totallauncher-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(
                       Colors.orange, BlendMode.srcIn),
                ),
              ),
               IconButton(
                
                onPressed: (){},

                icon: Icon(Icons.more_vert_outlined),

              )
            ],
          ),
          Text(
            "Total Paid",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color:  primaryColor,
          //   percentage: 35,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

 StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: widget.uid )
        .where('status', isEqualTo: "Paid")
        .snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {

    if (snapshots.hasError) {
    return Text("Something went wrong");
    }


    int total2 = 0; // Initialize total2 to 0
    if (snapshots.hasData) {
    snapshots.data!.docs.forEach((doc) {

      int tot =  doc['total'];

   // int orderTotal = tot; // Assuming 'totalAmount' is a double
    total2 += tot; // Accumulate the total amount
    });

    return Text(
      (total2 == 0)
          ? "K 0.00"
          : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                      style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
                    );
    }

    return Text("loading");
    },
                    ) ,
              





              
            ],
          )
        ],
      ),
    ),
    

    Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.network(
                  "assets/images/account-balance-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(
                       Colors.red, BlendMode.srcIn),
                ),
              ),
             IconButton(
                
                onPressed: (){},

                icon: Icon(Icons.more_vert_outlined),

              )
            ],
          ),
          Text(
            "Balances",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color:  primaryColor,
          //   percentage: 35,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: widget.uid )
        .where('status', isEqualTo: "Approved")
        .snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {

    if (snapshots.hasError) {
    return Text("Something went wrong");
    }


    int total2 = 0; // Initialize total2 to 0
    if (snapshots.hasData) {
    snapshots.data!.docs.forEach((doc) {

      int tot =  doc['total'];

   // int orderTotal = tot; // Assuming 'totalAmount' is a double
    total2 += tot; // Accumulate the total amount
    });

    return Text(
      (total2 == 0)
          ? "K 0.00"
          : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                      style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
                    );
    }

    return Text("loading");
    },
                    ) ,
              
              
            ],
          )
        ],
      ),
    ),
    
    
    ], 
    )
          
          
          ,
          tablet: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1, 
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding, 
      //itemCount: 4,
      
      children: [

    
StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.uid )

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


        GestureDetector(
          onTap: (){
            Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ClientMoreScreen(

          )),
              (route) => false);
          },
          child: Container(
              padding: EdgeInsets.all(defaultPadding),
            
              child: CircleAvatar(
                radius: 75,
          backgroundColor: Colors.yellow,
        
          backgroundImage:NetworkImage(doc['profilePic'] ),
              
              ),
            ),
        );
        
    });}}),
    
    
StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.uid )

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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
            doc['name'],
             style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            Divider( color: Colors.black,),
           Text(
            doc['email'],
            style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(
            color: Colors.black,
          ),
           Text(
            doc['number'],style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            
        ],
      ),
    );
        
    });}}),
    

   Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/images/totallauncher-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(
                       Colors.orange, BlendMode.srcIn),
                ),
              ),
               IconButton(
                
                onPressed: (){},

                icon: Icon(Icons.more_vert_outlined),

              )
            ],
          ),
          Text(
            "Total",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color:  primaryColor,
          //   percentage: 35,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

 StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: widget.uid )
        .where('status', isEqualTo: "Paid")
        .snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {

    if (snapshots.hasError) {
    return Text("Something went wrong");
    }


    int total2 = 0; // Initialize total2 to 0
    if (snapshots.hasData) {
    snapshots.data!.docs.forEach((doc) {

      int tot =  doc['total'];

   // int orderTotal = tot; // Assuming 'totalAmount' is a double
    total2 += tot; // Accumulate the total amount
    });

    return Text(
      (total2 == 0)
          ? "K 0.00"
          : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                      style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
                    );
    }

    return Text("loading");
    },
                    ) ,
              





              
            ],
          )
        ],
      ),
    ),
    

    Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.network(
                  "assets/images/account-balance-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(
                       Colors.red, BlendMode.srcIn),
                ),
              ),
             IconButton(
                
                onPressed: (){},

                icon: Icon(Icons.more_vert_outlined),

              )
            ],
          ),
          Text(
            "Balances",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color:  primaryColor,
          //   percentage: 35,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: widget.uid )
        .where('status', isEqualTo: "Approved")
        .snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {

    if (snapshots.hasError) {
    return Text("Something went wrong");
    }


    int total2 = 0; // Initialize total2 to 0
    if (snapshots.hasData) {
    snapshots.data!.docs.forEach((doc) {

      int tot =  doc['total'];

   // int orderTotal = tot; // Assuming 'totalAmount' is a double
    total2 += tot; // Accumulate the total amount
    });

    return Text(
      (total2 == 0)
          ? "K 0.00"
          : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                      style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
                    );
    }

    return Text("loading");
    },
                    ) ,
              
              
            ],
          )
        ],
      ),
    ),
    
    
    ], 
    )
          
          ,
          desktop:GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1, 
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding, 
      //itemCount: 4,
      
      children: [

    
StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.uid )

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


        GestureDetector(
          onTap: (){
            Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ClientMoreScreen(
            

          )),
              (route) => false);
          },
          child: Container(
              padding: EdgeInsets.all(defaultPadding),
            
              child: CircleAvatar(
                radius: 75,
          backgroundColor: Colors.yellow,
        
          backgroundImage:NetworkImage(doc['profilePic'] ),
              
              ),
            ),
        );
        
    });}}),
    
    
StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.uid )

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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
            doc['name'],
             style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            Divider( color: Colors.black,),
           Text(
            doc['email'],
            style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(
            color: Colors.black,
          ),
           Text(
            doc['number'],style: TextStyle(
              color: Colors.black
             ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            
        ],
      ),
    );
        
    });}}),
    

   Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/images/totallauncher-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(
                       Colors.orange, BlendMode.srcIn),
                ),
              ),
               IconButton(
                
                onPressed: (){},

                icon: Icon(Icons.more_vert_outlined),

              )
            ],
          ),
          Text(
            "Total",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color:  primaryColor,
          //   percentage: 35,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

 StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: widget.uid )
        .where('status', isEqualTo: "Paid")
        .snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {

    if (snapshots.hasError) {
    return Text("Something went wrong");
    }


    int total2 = 0; // Initialize total2 to 0
    if (snapshots.hasData) {
    snapshots.data!.docs.forEach((doc) {

      int tot =  doc['total'];

   // int orderTotal = tot; // Assuming 'totalAmount' is a double
    total2 += tot; // Accumulate the total amount
    });

    return Text(
      (total2 == 0)
          ? "K 0.00"
          : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                      style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
                    );
    }

    return Text("loading");
    },
                    ) ,
              





              
            ],
          )
        ],
      ),
    ),
    

    Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.network(
                  "assets/images/account-balance-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(
                       Colors.red, BlendMode.srcIn),
                ),
              ),
             IconButton(
                
                onPressed: (){},

                icon: Icon(Icons.more_vert_outlined),

              )
            ],
          ),
          Text(
            "Balances",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color:  primaryColor,
          //   percentage: 35,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: widget.uid )
        .where('status', isEqualTo: "Approved")
        .snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {

    if (snapshots.hasError) {
    return Text("Something went wrong");
    }


    int total2 = 0; // Initialize total2 to 0
    if (snapshots.hasData) {
    snapshots.data!.docs.forEach((doc) {

      int tot =  doc['total'];

   // int orderTotal = tot; // Assuming 'totalAmount' is a double
    total2 += tot; // Accumulate the total amount
    });

    return Text(
      (total2 == 0)
          ? "K 0.00"
          : "Mwk ${(total2.toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00",
                      style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
                    );
    }

    return Text("loading");
    },
                    ) ,
              
              
            ],
          )
        ],
      ),
    ),
    
    
    ], 
    )
          
          
          
          
          
           ,
        ),
      ],
    )
 ,
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
            "Transaction Details",
            style: Theme.of(context).textTheme.titleMedium,
          ),


StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("transactions")
  
 .where('id', isEqualTo: widget.id )
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



return  SizedBox(
           
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Amount"),
                ),
                DataColumn(
                  label: Text("Total"),
                ),
                DataColumn(
                  label: Text("Status"),
                ),
                 DataColumn(
                  label: Text("Category"),
                ),
                DataColumn(
                  label: Text("Type"),
                ),

                
              ],
              rows: [
                for (var i = 0; i<transaction.length; i++)...[

                DataRow(
    cells: [
        DataCell(Text("Mwk ${(transaction[i]['amount'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00")),
      
           
        DataCell(Text("Mwk ${(transaction[i]['total'].toString()).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}.00")),
      
      DataCell(Text(transaction[i]['status'].toString())),
      DataCell(Text(transaction[i]['category'].toString())),
        DataCell(Text(transaction[i]['type'].toString())),
    ],
  )

              ]
              ],
               
            ),
          );

  }),


         StreamBuilder<QuerySnapshot>(
  
  stream: FirebaseFirestore.instance.collection("transactions")
  
 .where('id', isEqualTo: widget.id )
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
                  label: Text("Percentage"),
                ),
                DataColumn(
                  label: Text("Fee"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                 DataColumn(
                  label: Text("Time"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),

                
              ],
              rows: [
 for (var i = 0; i<transaction.length; i++)...[
                DataRow(
    cells: [
      DataCell(Text(transaction[i]['percentages'].toString())),
      DataCell(Text(transaction[i]['fee'].toString())),
      DataCell(Text(transaction[i]['createdAt'].toString())),
      DataCell(Text(transaction[i]['time'].toString())),
      DataCell(
        
        TextButton(onPressed: ()async{

 await  _logoutAlert(context, transaction[i]['id'] );

        },
        
        child: Text("Confirm Transaction", style: TextStyle(
          color: Colors.white
        ),),)
        
        ),
    ],
  )

              ]
              ],
               
            ),
          );
  }
         )
          ,
        ],
      ),
    ),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Collateral Images",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
Text(
            "These images will be used as collateral for the loan, Until the our client pays back the loan collected with its fees!!",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('transactions')
        .where('id',isEqualTo: widget.id )
        .snapshots(),
    builder: (context, snapshot) {
    if(snapshot.hasError){
    return Scaffold(
    body: Center(
    child: Text('Error: $snapshot.error'),
    ),
    );
    }
    if (!snapshot.hasData) {
    return Scaffold(
    body: Center(
    child: CircularProgressIndicator(),
    ),
    );
    }
    else {
    return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemBuilder: (context, index) {
    DocumentSnapshot doc = snapshot.data!.docs[index];


    imagelist = doc['image'];

    return        GestureDetector(
                                    onTap:(){
                                      ShowImages(context);
                                    },
                                    child: Container(
                                      height: 300,
                                      child: Stack(
                                        children: [
                                          PageView(
                                            onPageChanged: (num){
                                              setState((){
                                                _selected = num;
                                              });
                                            },
                                            children: [
                                               for(var i = 0; i < imagelist.length; i++ )
                                                Container(
                                                  margin: EdgeInsets.all(0.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    image: DecorationImage(
                                                      image: NetworkImage(doc['image'][i],),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 20,
                                            right: 0,
                                            left: 0,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                 for(var i = 0; i < imagelist.length; i++ )
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      color: _selected == 0 ? Colors.pink : Colors.white,
                                                    ),
                                                    width: _selected == 0 ? 20 : 10,
                                                    height: 10,
                                                    margin: EdgeInsets.symmetric(horizontal: 12),)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
    }
    );
    }}),
 

    
         
 

       
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
                  Expanded(
                    flex: 2,
                    child: Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Collateral Images",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
Text(
            "These images will be used as collateral for the loan, Until the our client pays back the loan collected with its fees!!",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),



          StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('transactions')
        .where('id',isEqualTo: widget.id )
        .snapshots(),
    builder: (context, snapshot) {
    if(snapshot.hasError){
    return Scaffold(
    body: Center(
    child: Text('Error: $snapshot.error'),
    ),
    );
    }
    if (!snapshot.hasData) {
    return Scaffold(
    body: Center(
    child: CircularProgressIndicator(),
    ),
    );
    }
    else {
    return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    itemBuilder: (context, index) {
    DocumentSnapshot doc = snapshot.data!.docs[index];


    imagelist = doc['image'];

     return     GestureDetector(
                                    onTap:(){
                                      ShowImages(context);
                                    },
                                    child: Container(
                                      height: 300,
                                      child: Stack(
                                        children: [
                                          PageView(
                                            onPageChanged: (num){
                                              setState((){
                                                _selected = num;
                                              });
                                            },
                                            children: [
                                               for(var i = 0; i < imagelist.length; i++ )
                                                Container(
                                                  margin: EdgeInsets.all(0.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    image: DecorationImage(
                                                      image: NetworkImage(doc['image'][i],),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 20,
                                            right: 0,
                                            left: 0,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                 for(var i = 0; i < imagelist.length; i++ )
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      color: _selected == 0 ? Colors.pink : Colors.white,
                                                    ),
                                                    width: _selected == 0 ? 20 : 10,
                                                    height: 10,
                                                    margin: EdgeInsets.symmetric(horizontal: 12),)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
    }
    );
    }}),
 

    
         
 

       
        ],
      ),
    ),
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
