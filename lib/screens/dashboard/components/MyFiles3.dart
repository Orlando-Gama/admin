import 'package:admin/constants.dart'; 
import 'package:flutter/material.dart';

class MyFiles3 extends StatefulWidget {
  const MyFiles3({Key? key}) : super(key: key);

  @override
  State<MyFiles3> createState() => _MyFiles3State();
}

class _MyFiles3State extends State<MyFiles3> {

    List<String> categories = [
    "All",
    "Approved",
    "Pending",
    "Paid",
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => buildCategory(index),
                ),
              ),
             
          ],
        ),
        SizedBox(height: defaultPadding),
         
      ],
    );
  }
}