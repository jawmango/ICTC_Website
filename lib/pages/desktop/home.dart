import 'package:ICTC_Website/constants.dart';
import 'package:ICTC_Website/main.dart';
import 'package:ICTC_Website/models/program.dart';
import 'package:ICTC_Website/pages/desktop/about.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/pages/desktop/profile/profile_page.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/cards/program_card.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ICTC_Website/widgets/carousel/carousel.dart';

class HomeDesktopPage extends StatefulWidget {
  const HomeDesktopPage({super.key});

  @override
  State<HomeDesktopPage> createState() => _HomeDesktopPageState();
}

class _HomeDesktopPageState extends State<HomeDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1118) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeroSmallScreen(context),
                  _buildPrograms(context),
                  FooterWidget(),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHero(context),
                  FeaturedPrograms(),
                  _buildPrograms(context),
                  FooterWidget(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
class FeaturedPrograms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> programs = [
      {
        'imageUrl': 'assets/images/mc.png',
        'description': 'Description of Program 1',
      },
      {
        'imageUrl': 'assets/images/skillup.png',
        'description': 'Description of Program 2',
      },
      {
        'imageUrl': 'assets/images/gce.png',
        'description': 'Description of Program 3',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Programs',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          Text(
            'We have courses that span dozens of domains and all different levels of commitment. Here are three of our most popular ones for',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          Text(
            ' students, but there are plenty more where they came from.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: programs.map((program) => _buildProgramItem(program)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramItem(Map<String, String> program) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 43, 42, 42).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                  child: Image.network(
                    program['imageUrl']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      program['description']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[800],
                      ),
                    ),
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


Widget _buildHero(context) {
  return Stack(
    children: [
      Container(
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        color: Color(0xff19306B),
        child: Padding(
          padding: EdgeInsets.fromLTRB(180, 15, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "BE A ",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                          "CERTIFIED",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    Text(
                      "PROFESSIONAL",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Seize the opportunity to gain a competitive edge by mastering",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "essential skills. Unlock new horizons of expertise, from hands-on",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "learning experiences to industry-relevant skills. Delve into",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "specialized courses with Ateneo ICTC.",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ]),
            ],
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/bg1.png',
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width*0.9,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    ],
  );
}

//mobile
Widget _buildHeroSmallScreen(context) {
  return Container(
    alignment: Alignment.topLeft,
    width: MediaQuery.of(context).size.width,
    height: 750,
    color: Color(0xff19306B),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BE A ",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text("CERTIFIED", style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          Text(
            "PROFESSIONAL.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Seize the opportunity to gain a competitive edge by mastering",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "essential skills. Unlock new horizons of expertise, from hands-on",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "learning experiences to industry-relevant skills. Delve into",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "specialized courses with Ateneo ICTC.",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 8,
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget _buildPrograms(context) {
  return Container(
    color: Color(0xfffff0),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Featured Programs",
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 50),
          FutureBuilder(
            future: Supabase.instance.client
                .from('program')
                .select()
                .withConverter(
                    (data) => data.map((e) => Program.fromJson(e)).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final programs = snapshot.data as List<Program>;
              if (MediaQuery.of(context).size.width < 1450) {
                // ListView for small screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ProgramCardWidget(program: programs[index]),
                      );
                    },
                  ),
                );
              } else {
                // GridView for larger screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      return ProgramCardWidget(program: programs[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}
