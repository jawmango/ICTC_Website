import 'package:ICTC_Website/main.dart';
import 'package:ICTC_Website/models/program.dart';
import 'package:ICTC_Website/pages/auth/login_page.dart';
import 'package:ICTC_Website/pages/desktop/about.dart';
import 'package:ICTC_Website/pages/desktop/profile/profile_page.dart';
import 'package:ICTC_Website/widgets/programPage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Drawerdesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        
     return Drawer(
      backgroundColor: Colors.grey[300],
      child: StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the stream to emit a value
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error in the stream
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data;

            if (data?.session?.user != null) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xff19306B)),
                        'assets/images/logo_ictc.png',
                        width: 45,
                        height: 45,
                      ),

                        "Ateneo ICTC",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),

                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AboutPage(), // Replace with correct page
                        ),
                      );
                    },
                  ),
                        'assets/images/logo_ictc.png',
                        width: 45,
                        height: 45,
                      ),
                        "Ateneo ICTC",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MainApp(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AboutPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AboutPage(), // Replace with correct page
                        ),
                      );
                    },
                  ),
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(), // Replace with correct page
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

