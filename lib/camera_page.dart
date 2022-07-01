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

import 'dart:async';
import 'package:potdispred1/widget.dart';
import 'result_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

ImagePicker picker = ImagePicker();

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String output = '';

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    const NavigationDrawerWidget();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Select Image'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_size_select_actual_rounded),
            color: Colors.white,
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Execution Started")
                  ],
                ),
              ));
              XFile? image = await picker.pickImage(
                  source: ImageSource.gallery, maxHeight: 1800);
              if (image != null) {
                final stopwatch = Stopwatch()..start();
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                          imageFile: image,
                          stopWatch: stopwatch,
                        )));
              }
            },
          ),
        ],
      ),
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.green[200],
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/mobile_blur.jpg"),
                fit: BoxFit.cover)),
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.green,
                color: Colors.amberAccent,
              ));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          final stopwatch = Stopwatch()..start();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                    color: Colors.amberAccent,
                    strokeWidth: 3,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Execution Started")
              ],
            ),
          ));
          try {
            await _initializeControllerFuture;
            await _controller.setFlashMode(FlashMode.off);
            final image = await _controller.takePicture();

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imageFile: image,
                  stopWatch: stopwatch,
                ),
              ),
            );
          } catch (e) {
            // print(e);
          }
        },
        child: const Icon(
          Icons.camera,
          color: Colors.black54,
          size: 45,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
