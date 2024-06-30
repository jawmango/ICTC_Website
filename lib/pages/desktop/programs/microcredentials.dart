import 'package:ICTC_Website/models/course.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/cards/course_card.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MicrocredentialsPage extends StatefulWidget {
  const MicrocredentialsPage({super.key});

  @override
  State<MicrocredentialsPage> createState() => _MicrocredentialsPageState();
}

class _MicrocredentialsPageState extends State<MicrocredentialsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: SingleChildScrollView(
        child: Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildHero(context),
              //IframeTest(),
              _buildList(context),
              FooterWidget()
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildHero(context) {
  return Container(
    alignment: Alignment.topCenter,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.6,
    color: Color(0xFF19306B),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "MICRO-CREDENTIALS PROGRAM",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontSize: 45),
          ),
          SizedBox(height: 50),
          //characteristicsChips()
          Text(
            "A micro-credential is a short, focused, and specialized certification or credential that validates an  ",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 20),
          Text(
            "individual's knowledge, skills, and competencies in a specific area or domain. Unlike traditional ",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 20),
          Text(
              "academic degrees or certifications that require long-term study, micro-credentials are designed",
              style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: 20),
          Text(
              " to be more flexible, accessible, and time-efficient.",
              style: Theme.of(context).textTheme.labelMedium),
        ]),
  );
}

Widget _buildList(BuildContext context) {
  return Container(
      //height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.symmetric(vertical: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Micro-Credentials Courses",
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.only(left: 350, right: 350),
            child: FutureBuilder(
                future: Supabase.instance.client
                    .from('course')
                    .select()
                    .eq('program_id', 1)
                    .withConverter(
                        (data) => data.map((e) => Course.fromJson(e)).toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    return GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      children: snapshot.data!
                          .map((e) => CourseCard(course: e))
                          .toList(),
                    );
                  }

                  return Center(
                    child: Text("No data found."),
                  );
                }),
          )
        ],
      ));
}

Widget characteristicsChips() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Chip(
          backgroundColor: Color(0xFF19306B),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 1), // White border
            borderRadius: BorderRadius.circular(50),
          ),
          label: Text(
            "Focused Content",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 20),
        Chip(
            backgroundColor: Color(0xFF19306B),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1), // White border
              borderRadius: BorderRadius.circular(50),
            ),
            label: Text(
              "Short Duration",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        SizedBox(width: 20),
        Chip(
            backgroundColor: Color(0xFF19306B),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1), // White border
              borderRadius: BorderRadius.circular(50),
            ),
            label: Text(
              "Flixible Learning Options",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        SizedBox(width: 20),
        Chip(
            backgroundColor: Color(0xFF19306B),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1), // White border
              borderRadius: BorderRadius.circular(50),
            ),
            label: Text(
              "Stackable and Modular",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        SizedBox(width: 20),
        Chip(
            backgroundColor: Color(0xFF19306B),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1), // White border
              borderRadius: BorderRadius.circular(50),
            ),
            label: Text(
              "Employer Recognition",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        SizedBox(width: 20),
        Chip(
          backgroundColor: Color(0xFF19306B),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 1), // White border
            borderRadius: BorderRadius.circular(50),
          ),
          label: Text(
            "Continuous Learning",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}
