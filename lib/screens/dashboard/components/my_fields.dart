 
import 'package:admin/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart'; 

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "My Files",
        //       style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        //     ),
        //     ElevatedButton.icon(
        //       style: TextButton.styleFrom(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: defaultPadding * 1.5,
        //           vertical:
        //               defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        //         ),
        //       ),
        //       onPressed: () {},
        //       icon: Icon(Icons.add),
        //       label: Text("Add New"),
        //     ),
        //   ],
        // ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      //itemCount: 4,
      
      children: [

    
        Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.blue,
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
                  color: Colors.white ,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/images/sellers.svg",
                  colorFilter: ColorFilter.mode(
                      primaryColor, BlendMode.srcIn),
                ),
              ),
              IconButton(
                
                onPressed: (){},

                icon: Icon(Icons.more_vert_outlined),

              )

               
            ],
          ),
          Text(
            "Total Customers",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color:  primaryColor,
          //   percentage: 35,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

               StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('sellers')
                                                                   
                                                                  .snapshots(),
                                                              builder: (context, snapshot) {
                                                                if (!snapshot.hasData) {
                                                                  return Center(child:  Text("0"));
                                                                }
                                                                return
              Text(
                snapshot.data!.docs.length.toString().toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
              );}),





             
            ],
          )
        ],
      ),
    ),
    
    

    Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
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
                child: SvgPicture.asset(
                  "assets/images/transaction-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(
                       Colors.green, BlendMode.srcIn),
                ),
              ),
               IconButton(
                
                onPressed: (){},

                icon: Icon(Icons.more_vert_outlined),

              )
            ],
          ),
          Text(
            "Transactions ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color:  primaryColor,
          //   percentage: 35,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('transactions')
                                                                   
                                                                  .snapshots(),
                                                              builder: (context, snapshot) {
                                                                if (!snapshot.hasData) {
                                                                  return Center(child:  Text("0"));
                                                                }
                                                                return
              Text(
                snapshot.data!.docs.length.toString().toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
              );}),
              
            ],
          )
        ],
      ),
    ),
    


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
            "Total Amount",
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
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('transactions')

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
    total2 += tot;  
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
