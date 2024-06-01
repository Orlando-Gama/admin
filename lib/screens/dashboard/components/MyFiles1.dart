import 'package:admin/OtherScreens/ClientMoreScreen.dart';
import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFiles1 extends StatefulWidget {
  const MyFiles1({Key? key, this.id}) : super(key: key);

  final id;

  @override
  State<MyFiles1> createState() => _MyFiles1State();
}

class _MyFiles1State extends State<MyFiles1> {
  @override
  Widget build(BuildContext context) {
   final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView2(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            id:widget.id,
          ),
          tablet: FileInfoCardGridView2( id:widget.id,),
          desktop: FileInfoCardGridView2(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
             id:widget.id,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView2 extends StatefulWidget {
  const FileInfoCardGridView2({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.id
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  final id;

  @override
  State<FileInfoCardGridView2> createState() => _FileInfoCardGridView2State();
}

class _FileInfoCardGridView2State extends State<FileInfoCardGridView2> {
  @override
   Widget build(BuildContext context) {
    return 
    
    GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      //itemCount: 4,
      
      children: [

    
StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.id )

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
        
          backgroundImage:NetworkImage(doc['profilePic'] ),
              
              ),
            ),
        );
        
    });}}),
    
    
StreamBuilder<QuerySnapshot>  (
        stream: FirebaseFirestore.instance
            .collection('sellers').
    where('uid', isEqualTo: widget.id )

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
        .where('uid', isEqualTo: widget.id )
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
        .where('uid', isEqualTo: widget.id )
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
    );
  }
}
