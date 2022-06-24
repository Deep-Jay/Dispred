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
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "About",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.green[200],
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/mobile_blur.jpg"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 40, 20, 0),
                child: Text.rich(
                  // ignore: unnecessary_const
                  const TextSpan(
                    children: [
                      TextSpan(
                          text:
                              "This app is made to predict the disease of a potato plant from the image of its leaf. This app can distinguish between a"),
                      TextSpan(
                          text: " Healthy leaf",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      TextSpan(text: ", a "),
                      TextSpan(
                          text: "Early Blight leaf",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow)),
                      TextSpan(text: " and a "),
                      TextSpan(
                          text: "Late  Blight leaf",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber)),
                      TextSpan(
                          text:
                              " of a potato plant.\n\nOn the backend it uses a"),
                      TextSpan(
                          text: " AI/ML model ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "build with"),
                      TextSpan(
                          text: " Tensorflow",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              " to predict and shows the result which has the maximum confidence. The model is reduced in size with the help of"),
                      TextSpan(
                          text: " Tensorflow Lite ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "to make compatible with the mobile app.\n\n"),
                      TextSpan(text: "Team Behind: "),
                    ],
                  ),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Row(
                // ignore: unnecessary_const
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/fg.png"),
                      radius: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {_launchURLjay()},
                    child: const Text(
                      "Jaydeep Nath",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Row(
                // ignore: unnecessary_const
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/df.png"),
                      // backgroundColor: Colors.lightBlueAccent,
                      radius: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {_launchURLsay()},
                    child: const Text(
                      "Sayan Khanra",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => {_launchURLlis()},
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Liscensed Under: GNU-GLPv3",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: const Icon(
          Icons.arrow_back_rounded,
        ),
      ),
    );
  }
}

_launchURLjay() async {
  const url = 'https://www.github.com/Deep-Jay';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw PlatformException(code: 'Could not launch $url');
  }
}

_launchURLsay() async {
  const url = 'https://www.github.com/sskbond007';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw PlatformException(code: 'Could not launch $url');
  }
}

_launchURLlis() async {
  const url = 'https://github.com/Deep-Jay/Dispred_App/blob/main/COPYING.txt';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw PlatformException(code: 'Could not launch $url');
  }
}
