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
import 'package:potdispred1/splash_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  // final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const Splash()
    ),
  );
}

// Future _getStoragePermission() async {
//   if (await Permission.storage.request().isGranted) {
//     setState(() {
//       permissionGranted = true;
//     });
//   } else if (await Permission.storage.request().isPermanentlyDenied) {
//     await openAppSettings();
//   } else if (await Permission.storage.request().isDenied) {
//     setState(() {
//       permissionGranted = false;
//     });
//   }
// }
