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
import 'package:flutter/material.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
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
                  _buildHero(context),
                  _buildMission(context),
                  _ourTeam(context),
                  
                  FooterWidget(),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHero(context),
                  _buildMission(context),
                  _ourTeam(context),
                   
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
        color: Colors.grey[50],
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.82,
        child: Padding(
          padding: EdgeInsets.fromLTRB(70, 0, 15, 20), // Adjust right padding for logo position
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text content in the left/middle side
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 20), // Adjust padding as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Ateneo ",
                            style: AppTextStyles.displayLargeBlue,
                          ),
                          Text(
                            "Information ",
                            style: AppTextStyles.displayLargeYellow,
                          ),
                          Text(
                            "and",
                            style: AppTextStyles.displayLargeBlue,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Communications Technology",
                            style: AppTextStyles.displayLargeBlue,
                          ),
                          Text(
                            "Center",
                            style: AppTextStyles.displayLargeBlue,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Information and Communications Technology ",
                            style: AppTextStyles.displaySmallBlack,
                          ),
                          Text(
                            "Center is Ateneo de Naga's Professional School ",
                            style: AppTextStyles.displaySmallBlack,
                          ),
                          Text(
                            "for ICT and the Premier IT Training Center in ",
                            style: AppTextStyles.displaySmallBlack,
                          ),
                          Text(
                            "Southern Luzon, Philippines.",
                            style: AppTextStyles.displaySmallBlack,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(right: 30), 
                margin: EdgeInsets.fromLTRB(0, 70, 30, 0), // Adjust margin as needed
                child: Image.asset(
                  'assets/images/logo_ictc.png',
                  height: 700, // Adjust height as needed
                  width: 700, // Adjust width as needed
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildMission(context) {
  return Stack(
    children: [
      Container(
        color: Color(0xff19306B),
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.75,
        child: Padding(
          padding: EdgeInsets.fromLTRB(70, 0, 15, 140), // Adjust right padding for logo position
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text content in the left/middle side
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 20), // Adjust padding as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "MISSION ",
                            style: AppTextStyles.displayLargeYellow,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ICTC seeks to share in the University mission in ",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "achieving  academic excellence through",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "developing, designing, and delivering quality ICT",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "programs responsive to the needs of the",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "community.",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 160, 50, 0),// Adjust padding as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "VISION",
                            style: AppTextStyles.displayLargeYellow,
                          ),
                        ],
                      ),  
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The globally recognized Center offering and",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "delivering quality Information & Communications",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "Technology programs for continuing education",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "and career academy courses in the region. The ",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "regional hub in providing world-class industry-",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "centric trainings and certifications. The leader in",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "providing conferences on emerging technological",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "trends powering the university into academic",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                          Text(
                            "excellence.",
                            style: AppTextStyles.displaySmallWhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _ourTeam(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: Column(
          children: [
            Text(
                "OUR TEAM",
                style: AppTextStyles.displayLargeBlueTeam,
              ),
              SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ // Adding space at the beginning
                _buildTeamMemberCard(
                  'Michelle Elija B. Santos',
                  'DIRECTOR',
                  'assets/images/background.png', // Replace with actual image path
                  imageSize: 300.0, // Adjust image size as needed
                  cardWidth: 400.0,
                  cardHeigth: 500.0,  // Adjust card width as needed
                ),
                SizedBox(width: 5.0), // Adding space between cards
            
                _buildTeamMemberCard(
                  'Aaron G. Infeliz',
                  'MARKETING SPECIALIST',
                  'assets/images/background.png', // Replace with actual image path
                  imageSize: 300.0, // Adjust image size as needed
                  cardWidth: 400.0,
                  cardHeigth: 500.0, // Adjust card width as needed
                ),
                SizedBox(width: 10.0), // Adding space at the end
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard(
    String name,
    String position,
    String imagePath, {
    double imageSize = 350.0,
    double cardWidth = 200.0,
    double cardHeigth = 200.0,
  }) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        color: Color.fromARGB(244, 244, 244, 244),
        width: cardWidth,
        height: cardHeigth,
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image at the top
            ClipRRect(
              borderRadius: BorderRadius.circular(200.0),
              child: Image.asset(
                imagePath,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12.0),
            // Name below the image
            Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.0),
            // Position below the name
            Text(
              position,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
