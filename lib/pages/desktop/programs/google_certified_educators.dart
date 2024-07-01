import 'package:ICTC_Website/models/course.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/cards/levelCard.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleCertifiedEducatorsPage extends StatefulWidget {
  const GoogleCertifiedEducatorsPage({super.key});

  @override
  State<GoogleCertifiedEducatorsPage> createState() =>
      _GoogleCertifiedEducatorsPageState();
}

class _GoogleCertifiedEducatorsPageState
    extends State<GoogleCertifiedEducatorsPage> {
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
              _buildLevels(context),
              FooterWidget(),
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
    color: Color(0xff19306B),
    // color: Color(0xff153faa),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Google Certified Educator",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: Colors.white),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "A program offered by Google for educators who use Google Workspace for Education (formerly known as G Suite for Education) in their",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "classrooms. The certification is designed to validate educators' proficiency in effectively integrating technology ",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "and Google tools to enhance teaching and learning experiences for students.",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              // SizedBox(
              //   height: 8,
              // ),
              // Text(
              //   "integrating technology and Google tools to enhance teaching and learning experiences for students.",
              //   style: Theme.of(context).textTheme.labelMedium,
              // ),
              // SizedBox(
              //   height: 8,
              // ),
            ],
          ),
        ]),
  );
}

Widget _buildLevels(context) {
  return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      color: Color(0xfffff0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(350, 15, 350, 15),
        child: FutureBuilder(
          future: Supabase.instance.client
              .from('course')
              .select()
              .eq('program_id', 7)
              .withConverter(
                  (data) => data.map((e) => Course.fromJson(e)).toList()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Levels of Google Certified Educators Certification",
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!
                      .map((e) => LevelCard(course: e))
                      .toList()
                ),
              ]);
            }

            return Center(
              child: Text("No data found"),
            );
          }
        ),
      ));
}
