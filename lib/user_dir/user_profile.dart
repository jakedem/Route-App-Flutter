import 'package:flutter/material.dart';
import 'package:routeapp/authentication_dir/sign_in_screen.dart';
import 'package:routeapp/user_dir/profile_edit.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 86, 79),
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('images/Borris Lee.png'),
                ),
                Column(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // Navigate to edit profile screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()),
                        );
                      },
                      icon: Icon(Icons.edit,
                          color: Color.fromARGB(255, 0, 86, 79)),
                      label: Text('Edit Profile',
                          style:
                              TextStyle(color: Color.fromARGB(255, 0, 86, 79))),
                    ),
                    SizedBox(height: 8.0),
                    TextButton.icon(
                      onPressed: () {
                        // Navigate to sign in screen and remove all routes
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                            (Route<dynamic> route) => false);
                      },
                      icon: Icon(Icons.logout,
                          color: Color.fromARGB(255, 0, 86, 79)),
                      label: Text('Logout',
                          style:
                              TextStyle(color: Color.fromARGB(255, 0, 86, 79))),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Text(
              'Borris Lee',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Software Engineer',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 10.0),
                Text(
                  'borris.lee@email.com',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 10.0),
                Text(
                  'Main St, Apt 1',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.location_city),
                SizedBox(width: 10.0),
                Text(
                  'Cape Coast, UCC',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
