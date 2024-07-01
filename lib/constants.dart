import 'package:flutter/material.dart';

var myDefaultBackground = Colors.grey;

var myAppBar = AppBar(
  backgroundColor: Colors.grey,
);

var myDrawer = Drawer(
        backgroundColor: Colors.grey,
        child: Column(
          children: [
            DrawerHeader (child: Icon(Icons.favorite)),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              ),
              ListTile(
              leading: Icon(Icons.chat),
              title: Text('Message'),
              ),
              ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              ),
              ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              ),
          ],
        )
      );