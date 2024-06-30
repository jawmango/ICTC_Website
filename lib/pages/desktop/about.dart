import 'package:ICTC_Website/pages/desktop/styles.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import 'package:ICTC_Website/models/program.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/cards/program_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ICTC_Website/widgets/carousel/carousel.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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

Widget _buildHero(context) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/bg12.jpg'),
          fit: BoxFit.cover,
          ),
        ) ,
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.85,
        child: Padding(
          padding: EdgeInsets.fromLTRB(180, 15, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "MISSION",
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color : Color.fromARGB(255, 255, 200, 73),
                            )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ICTC seeks to share in the",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "University mission in achieving",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "academic excellence through",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "developing, designing, and",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "delivering quality ICT programs",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "responsive to the needs of the",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "community.",
                            style: AppTextStyles.bodyLarge,
                          ),
                        ],
                      ),
                    ]),
              ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 275, 130, 0),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    Row(
                      children: [
                        Text(
                          "VISION",
                           style: TextStyle(
                           fontSize: 55,
                           fontWeight: FontWeight.bold,
                          color : Color.fromARGB(255, 255, 200, 73),
                          )
                         ),
                          ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "The globally recognized Center offering",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "and delivering quality Information &",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "Communications Technology programs for",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            " continuing education and career academy",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "courses in the region. The regional hub in",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "providing world-class industry-centric trainings",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "and certifications. The leader in providing",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            " conferences on emerging technological trends ",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "powering the university into academic excellence.",
                            style: AppTextStyles.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
                    Container( //center logo
                      margin: EdgeInsets.fromLTRB(0, 110, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo_ictc.png',
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width*0.6,
                        ),
                      ],
                    ),
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
          Text("Our Team",
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 50),
          
        ],
      ),
    ),
  );
}