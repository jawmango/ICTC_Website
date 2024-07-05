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
import 'package:ICTC_Website/pages/desktop/morePrograms.dart';

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
                  // FeaturedPrograms(),
                  A1HomeFeatprograms(),
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

class A1HomeFeatprograms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: 1980,
          height: 1580,
          decoration: BoxDecoration(color: Colors.grey[30]),
          child: Stack(
            children: [
              Positioned( // Google Cert Container
                left: 330,
                top: 1056,
                child: Container(
                  width: 1320,
                  height: 364,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF153FAA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -3,
                        top: 0,
                        child: Container(
                          width: 662,
                          height: 364,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x72032E9D),
                                blurRadius: 2,
                                offset: Offset(0, 2),
                                spreadRadius: 3,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 142,
                        top: 48,
                        child: Container(
                          width: 373,
                          height: 268,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("assets/images/gce.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 731,
                        top: 90,
                        child: Container(
                          height: 185,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 539,
                                child: Text(
                                  'Google Certified Educators Program',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 506,
                                height: 87,
                                child: Text(
                                  'Aids educators in preparing for the Google for Education Certified Educator examinations and individuals who would like to gain more proficiency in using the Google Workspace in their respective fields.',
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned( // Skill up container
                left: 330,
                top: 649,
                child: Container(
                  width: 1320,
                  height: 364,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF153FAA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 61,
                        top: 111.50,
                        child: Container(
                          width: 509,
                          height: 141,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Skill-Up Program',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 506,
                                height: 87,
                                child: Text(
                                  'Constitutes a structured sequence of educational sessions meticulously designed to impart essential and sought-after skills demanded within the contemporary market landscape.',
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 658,
                        top: 0,
                        child: Container(
                          width: 662,
                          height: 364,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 730,
                        top: 124,
                        child: Container(
                          width: 518,
                          height: 117,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("assets/images/skillup.png"),
                              fit: BoxFit.fill,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFFFFFF),
                                blurRadius: 0,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned( // Micro Cred Container
                left: 327,
                top: 254,
                child: Container(
                  width: 1320,
                  height: 364,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF153FAA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 723,
                        top: 120,
                        child: Container(
                          width: 506,
                          height: 141,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Micro Credential Program',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 506,
                                height: 87,
                                child: Text(
                                  'Short, focused, and competency-based certifications that validate specific skills and knowledge in a particular area.',
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: -8,
                        top: 0,
                        child: Container(
                          width: 662,
                          height: 364,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x6D228E46),
                                blurRadius: 2,
                                offset: Offset(0, 2),
                                spreadRadius: 3,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 168,
                        top: 3,
                        child: Container(
                          width: 326,
                          height: 327,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("assets/images/mc.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 330,
                top: 120,
                child: Center(
                  child: SizedBox(
                    width: 1320,
                    height: 110,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'We have courses that span dozens of domains and all different levels of commitment. Here are three of our most popular ones for students, but there are plenty more where they came from.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 1.5, // Adjust line height as needed
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 326,
                top: 45,
                child: Container(
                  width: 1292,
                  height: 130,
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 470,
                        child: Text(
                          'Featured Programs',
                          style: TextStyle(
                            color: Color(0xFF153FAA),
                            fontSize: 46,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
          padding: EdgeInsets.fromLTRB(130, 15, 15, 15),
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
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProgramPages(),
                              ),
                            );
                          },
                              style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              backgroundColor: Color(0xFFF3B503), // Yellow-orange color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0), // Rounded corners
                              ),
                            ),
                          child: Text(
                            "Register Now!",
                                style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff19306B),
                              ),
                          ),
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
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20), // Adjust top padding here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 00), // Adjust top padding for the title
            child: Text(
              "Programs",
              style: TextStyle(
                color: Color(0xFF153FAA),
                fontSize: 46,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          SizedBox(height: 20),
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

