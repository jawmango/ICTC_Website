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

class ProgramPages extends StatefulWidget {
  const ProgramPages({super.key});

  @override
  State<ProgramPages> createState() => _ProgramPagesState();
}

class _ProgramPagesState extends State<ProgramPages> {
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
                  _buildPrograms(context),
                  FooterWidget(),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // _buildHero(context),
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

Widget _buildPrograms(context) {
  return Container(
    color: Color(0xfffff0),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Programs",
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
