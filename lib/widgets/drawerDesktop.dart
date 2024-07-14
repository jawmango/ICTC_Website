import 'package:ICTC_Website/main.dart';
import 'package:ICTC_Website/models/program.dart';
import 'package:ICTC_Website/pages/auth/login_page.dart';
import 'package:ICTC_Website/pages/desktop/about.dart';
import 'package:ICTC_Website/pages/desktop/morePrograms.dart';
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[  
                      Image.asset(
                        'assets/images/logo_ictc.png',
                        width: 45,
                        height: 45,
                      ),
                      Text(
                        "Ateneo ICTC",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      ]
                    )
                  ),
                  ListTile(
                    leading: Icon(Icons.home,
                    color: Color(0xFF19306B)),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person, 
                      color: Color(0xFF19306B)),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.supervisor_account,
                    color: Color(0xFF19306B)),
                    title: Text(
                      'About',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book,
                    color: Color(0xFF19306B)),
                    title: Text(
                      'Programs',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/programs');
                    },
                  ),
                  SizedBox(height: 510),
                  Divider(), // Divider for visual separation
                  ListTile(
                    leading: Icon(Icons.logout, color: Color(0xFF19306B)),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
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
                        Navigator.pushNamed(context, '/home');
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[  
                      Image.asset(
                        'assets/images/logo_ictc.png',
                        width: 45,
                        height: 45,
                      ),
                      Text(
                        "Ateneo ICTC",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      ]
                    )
                  ),
                  ListTile(
                    leading: Icon(Icons.home, color: Color(0xFF19306B)),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.supervisor_account, color: Color(0xFF19306B)),
                    title: Text(
                      'About',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book, color: Color(0xFF19306B)),
                    title: Text(
                      'Programs',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/programs');
                    },
                  ),
                  SizedBox(height: 560),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.login, color: Color(0xFF19306B)),
                    title: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/login');
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

