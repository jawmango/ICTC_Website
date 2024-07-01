import 'package:ICTC_Website/models/course.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/cards/skillCard.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SkillUpPage extends StatefulWidget {
  const SkillUpPage({super.key});

  @override
  State<SkillUpPage> createState() => _SkillUpPageState();
}

class _SkillUpPageState extends State<SkillUpPage> {

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
        child: Column(
          children: [_buildHero(context), _buildList(context), FooterWidget()],
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
            "Skill-Up Program",
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
                "Ateneo ICTC's training or educational initiative designed to help individuals",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "acquire new skills or upgrade existing ones to enhance their employability and career prospects.",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              // SizedBox(
              //   height: 8,
              // ),
              // Text(
              //   "and Google tools to enhance teaching and learning experiences for students.",
              //   style: Theme.of(context).textTheme.labelMedium,
              // ),
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

Widget _buildList(BuildContext context) {
  return Container(
      color: Color(0xfffff0),
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Skill-Up Courses",
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 50),
          Padding(
            //height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.only(left: 350, right: 350),
            child: FutureBuilder(
                future: Supabase.instance.client
                    .from('course')
                    .select()
                    .eq('program_id', 8)
                    .withConverter(
                        (data) => data.map((e) => Course.fromJson(e)).toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: snapshot.data!
                          .map((e) => SkillCard(course: e))
                          .toList(),
                    );
                  }

                  return Center(
                    child: Text("No data found."),
                  );
                }),
          ),
        ],
      ));
}
