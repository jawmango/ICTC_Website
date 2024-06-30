import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import '../Placer.dart';

class PendingDetails extends StatefulWidget {
  const PendingDetails({Key? key}) : super(key: key);

  @override
  State<PendingDetails> createState() => _PendingDetailsState();
}

class _PendingDetailsState extends State<PendingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Placer(
              child: pendingCourseDetails(context),
            ),
            FooterWidget()
          ],
        ),
      ),
    );
  }
}

Widget pendingCourseDetails(context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                "Pending Course Details",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
        Divider(),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Course Name: Introduction to Cyber Security",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Course Date: April 19 - 20, 2021",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Payment Status: Paid",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Certificate Status: Pending",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
