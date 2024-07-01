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
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MainApp(),
                          ),
                        );
                      },
                      icon: Image.asset(
                        'assets/images/logo_ictc.png',
                        width: 45,
                        height: 45,
                      ),
                      label: Text(
                        "Ateneo ICTC",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
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
                    leading: Icon(Icons.person),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.supervisor_account),
                    title: Text(
                      'About',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
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
                    leading: Icon(Icons.book),
                    title: Text(
                      'Programs',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
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
                  Divider(), // Divider for visual separation
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () async {
                        await Supabase.instance.client.auth.signOut();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Successfully signed out!")));
                        }
                        Navigator.pop(context);
                      },
                  ),
                ],
              );
            } else {
              // If user is not authenticated or snapshot data is null
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xff19306B)),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MainApp(),
                          ),
                        );
                      },
                      icon: Image.asset(
                        'assets/images/logo_ictc.png',
                        width: 45,
                        height: 45,
                      ),
                      label: Text(
                        "Ateneo ICTC",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
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
                    leading: Icon(Icons.supervisor_account),
                    title: Text(
                      'About',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
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
                    leading: Icon(Icons.book),
                    title: Text(
                      'Programs',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
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
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.login),
                    title: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
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

