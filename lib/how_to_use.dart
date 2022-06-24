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

class HowtoUsePage extends StatelessWidget {
  const HowtoUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("How to Use"),
        // centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.green[200],
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/mobile_blur.jpg"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 00),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RichText(
                    text: const TextSpan(
                  style: TextStyle(fontSize: 18),
                  children: [
                    TextSpan(
                        text:
                            'On openning the app the camera is accessed by default.\n\nChoice 1: \nYou can select your image with the camera by clicking on the '),
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          radius: 15,
                        ),
                      ),
                    ),
                    TextSpan(text: ' icon'),
                  ],
                )),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(image: AssetImage("assets/main_page.png")),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 18),
                    children: [
                      TextSpan(
                          text:
                              '\nChoice 2: \nYou can select your image from your gallery by clicking on the '),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Icon(
                              Icons.image,
                              color: Colors.black,
                            ),
                            radius: 15,
                          ),
                        ),
                      ),
                      TextSpan(
                          text:
                              ' icon.\n\nBoth Choice will by default take you to the results page where you can view the label and confidence level.'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(image: AssetImage("assets/result_page1.png")),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(image: AssetImage("assets/result_page2.png")),
                ),
                RichText(
                    text: const TextSpan(
                  style: TextStyle(fontSize: 18),
                  children: [
                    TextSpan(
                        text: 'Hope you will have a great time using our app '),
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Icon(
                            Icons.sentiment_satisfied_alt_rounded,
                            color: Colors.black,
                          ),
                          radius: 15,
                        ),
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
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
