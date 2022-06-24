/* This file is part of Dispred.

Dispred is free software: you can redistribute it and/or modify it 
under the terms of the GNU General Public License as published by the 
Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Dispred is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with Dispred.
If not, see <https://www.gnu.org/licenses/>. */

import 'package:flutter/material.dart';
import 'about_page.dart';
import 'how_to_use.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Dispred'),
            backgroundColor: Colors.green,
          ),
          body: Container(
            color: Colors.black87,
            child: ListView(
              //padding: padding,
              children: [
                // const SizedBox(height: 30),
                buildHeader(name: "Dispred"),
                const SizedBox(height: 10),
                const Divider(color: Colors.white),
                const SizedBox(height: 10),
                buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0)),
                const SizedBox(
                  height: 10,
                ),
                buildMenuItem(
                    text: 'About',
                    icon: Icons.info,
                    onClicked: () => selectedItem(context, 1)),
                const SizedBox(height: 10),
                // buildMenuItem(
                //     text: 'How To Use',
                //     icon: Icons.help,
                //     onClicked: () => selectedItem(context, 1)),
                // const SizedBox(height: 10),
                buildMenuItem(
                    text: 'Source Code',
                    icon: Icons.code_rounded,
                    onClicked: () => selectedItem(context, 2)),
                const SizedBox(height: 10),
                buildMenuItem(
                    text: 'Main Project',
                    icon: Icons.golf_course,
                    onClicked: () => selectedItem(context, 3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildHeader({required String name}) {
  return Container(
    height: 180,
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/nav_header.jpg"), fit: BoxFit.cover),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/logo.jpg"),
            // backgroundColor: Colors.black,
            radius: 30.0,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Potato Leaf Blight\nDisease Recognition\nApp",
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto-Medium'),
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClicked}) {
  const color = Colors.white;

  return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: color,
          fontSize: 20,
        ),
      ),
      onTap: onClicked);
}

Uri source_code = Uri.parse('https://www.github.com/Deep-Jay/Dispred');
Uri main_project =
    Uri.parse('https://www.github.com/Deep-Jay/Deep-learning_Poject');

Future<void> _launch(Uri url) async {
  await canLaunchUrl(url) ? await launchUrl(url) : NullThrownError();
}

Future<void> selectedItem(BuildContext context, int index) async {
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      // Navigator.of(context).pop();
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const AboutPage()));
      break;
    case 4:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HowtoUsePage()));
      break;
    case 2:
      _launch(source_code);
      break;
    case 3:
      _launch(main_project);
      break;
  }
}
