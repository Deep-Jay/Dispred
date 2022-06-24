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

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:potdispred1/camera_page.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetocam();
  }

  _navigatetocam() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    await Future.delayed(const Duration(milliseconds: 2000));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(camera: firstCamera)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.green,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/mobile_blur.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/logo.jpg"),
                // backgroundColor: Colors.lightBlueAccent,
                radius: 100,
              ),
              const SizedBox(height: 40),
              FadingText(
                "D I S P R E D",
                style: const TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontFamily: 'Roboto-Medium'),
              ),
              const SizedBox(height: 80),
              const Padding(
                padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 0.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.green,
                  color: Colors.amberAccent,
                  // strokeWidth: 10.0,
                  minHeight: 5.0,
                ),
              ),
              const SizedBox(height: 80),
              const Text(
                "Licensed under: GNU-GPLv3",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
