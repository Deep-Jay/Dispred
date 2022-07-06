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

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';

class DisplayPictureScreen extends StatefulWidget {
  final XFile imageFile;
  final dynamic stopWatch;

  const DisplayPictureScreen(
      {Key? key, required this.imageFile, required this.stopWatch})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  List? output;
  dynamic color;
  String aboutLate = """
-  Caused by the oomycete pathogen Phytophthora infestans (P. infestans).

-  Host crop and plants are Solanaceous plants such as potato, tomato, petunia and nightshade.

-  Initial symptoms appear on leaves the as pale green water soaked spots (2-10 mm) mostly on the margin and tips.

-  In moist weather, spots may appear anywhere on the leaves, enlarge rapidly and turn necrotic and black killing the entire leaf instantly.

-  Affetcs all above-ground portions of the plant and tubers of the Host, first recognized by its foliar symptoms.\n\n\n
""";

  String envcondLate = """
-  High-humidity and moisture (6-12 hours of moisture are ideal and usually occur as morning dew, rain or overhead irrigation).

-  Moderate temperatures (~60-80°F)(~16°C-27°C).\n\n\n
""";

  String manageLate = """
-  Use pathogen-free seed.

-  Plant early in the season to escape high disease pressure.

-  Do not allow water to remain on leaves for long periods of time.

-  Scout plants often and remove infected plants, infected tubers, volunteers and weeds.

-  Clean tools and equipments after leaving a field.

-  Keep tubers in storage dry and at low temperatures (38°F)(3-4°C).

-  Plant tolerant varieties when possible.

-  Protect the crop with fungicides.
""";

  String aboutEarly = """
-  Caused by the fungus Alternaria solani and attacks older leaves first.

-  Mainly appears on leaves and tubers.

-  Initially the symptoms occur on the lower and older leaves in the form of small (1-2mm), circular to oval, brown spots.

-  Mature lesions on foliage look dry and papery, and often have the concentric rings, looking like 'bull's eye'.

-  Under severe conditions, the entire foliage blighted and field gives burnt appearance.\n\n\n
""";

  String envcondEarly = """
-  Favoured by moderate temperature (17-25°C) and high humidity (75%).

-  Intermittent dry and wet weather is more conducive for early blight.\n\n\n
""";

  String manageEarly = """
-  Always use only disease free seed tubers for raising the crop.

-  Cultivation of solanaceous crops being collateral hosts, nearby potato fields must be avoided.

-  Fungicidal sprays are effective in controlling early blight and other leaf spots. Spraying of crop with chlorothalonil (0.20%), mancozeb (0.20%) or propineb (0.20%) can take care of these diseases.

-  Apply recommended dose of nitrogen.

-  Time irrigation to minimize leaf wetness duration during cloudy weather and allow sufficient time for leaves to dry prior to nightfall.

-  Scout fields regularly for infection beginning after plants reach 12 inches in height. Pay particular attention to edges of fields that are adjacent to fields planted to potato the previous year.

-  Avoid injury and skinning during harvest.

-  Rotate fields to non-host crops for at least three years (three to four-year crop rotation).

-  Eradicate weed hosts such as hairy nightshade to reduce inoculum for future plantings.
""";

  late String about;
  late String favenvcond;
  late String prevension;
  late double maxVal;
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    loadModel();
    runModel();
    isSaved = false;
  }

  loadModel() async {
    try {
      await Tflite.loadModel(
          model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
    } on PlatformException {
      // print("Could'nt load tflite model");
    }
  }

  runModel() async {
    
    loadModel();
    try {
      var predictions = await Tflite.runModelOnImage(
          path: widget.imageFile.path,
          imageMean: 0.0,
          imageStd: 255.0,
          numResults: 2,
          threshold: 0.2,
          asynch: true);
      setState(() {
        output = predictions;
      });
      final timeElapsed = widget.stopWatch.elapsedMilliseconds / 1000;
      widget.stopWatch..stop();
      await _changeColor();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.done,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Execution Completed in ${timeElapsed}s",
            )
          ],
        ),
        action: SnackBarAction(label: "DISMISS", onPressed: () {}),
        duration: Duration(milliseconds: 2500),
      ));
    } on PlatformException {
      // print("There was an error in prediction");
    }
  }

  _changeColor() => {
        if (output?[0]["label"] == "Healthy")
          {
            color = Colors.green,
            about = "All Good\n\n\n",
            favenvcond = "\n",
            prevension = "\n",
            maxVal = 0.25
          }
        else if (output?[0]["label"] == "Early Blight")
          {
            color = Colors.yellow,
            about = aboutEarly,
            favenvcond = envcondEarly,
            prevension = manageEarly,
            maxVal = 0.7
          }
        else
          {
            color = Colors.amber,
            about = aboutLate,
            favenvcond = envcondLate,
            prevension = manageLate,
            maxVal = 0.7
          }
      };

  _saveImage() async {
    final Directory? savePath = await getExternalStorageDirectory();
    DateTime now = DateTime.now();
    var epochTime = now.millisecondsSinceEpoch;
    String path =
        savePath.toString().split('Android')[0].split("'")[1] + "Download/";
    new Directory(path + "Dispred/").create().then((Directory directory) =>
        path = directory.path + "${output![0]["label"]}_${epochTime}.jpg");
    if (!isSaved) {
      if (await Permission.storage.request().isGranted) {
        await widget.imageFile.saveTo(path);
        final pathShow = path.split("0")[1].split("/")[1] +
            "/" +
            path.split("0")[1].split("/")[2] +
            "/";
        isSaved = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.done,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                  "Saved at /$pathShow\nas ${output![0]["label"]}_${epochTime}.jpg")
            ],
          ),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: "OK",
            onPressed: () {},
          ),
        ));
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        // await openAppSettings();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(days: 30),
          content: Row(
            children: [
              Icon(
                Icons.report_problem,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text("A requested permission was denied")
            ],
          ),
          action: SnackBarAction(
            label: "OPEN\nSETTINGS",
            onPressed: () => openAppSettings(),
          ),
        ));
      } else if (await Permission.storage.request().isDenied) {
        print(path);
      }
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Text("Already Saved")
          ],
        ),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ));
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey,
            child: Image.file(File(widget.imageFile.path))),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text(
              'Results',
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: _saveImage, icon: Icon(Icons.save))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Disease Predicted: ${output?[0]["label"]}',
                            //\n\nConfidence: ${(double.parse((output![0]["confidence"]).toStringAsFixed(2)) * 100).toString()}%',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            // 'Disease Predicted: ${output![0]["label"]}\n\n
                            'Confidence: ${(double.parse((output![0]["confidence"]).toStringAsFixed(2)) * 100).toString()}%',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: DraggableScrollableSheet(
                  initialChildSize: .2,
                  minChildSize: .2,
                  maxChildSize: maxVal,
                  builder: (context, scrollController) => ListView(
                    controller: scrollController,
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                            // border: Border.all(width: 10),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.black),
                        child: const Center(
                            child: Icon(
                          Icons.drag_handle_rounded,
                          color: Colors.white,
                        )),
                      ),
                      Container(
                        color: Colors.black,
                        child: SingleChildScrollView(
                            // child: Text(
                            //   about1,
                            //   style:const TextStyle(color: Colors.white),
                            //   ),
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(TextSpan(
                              style: const TextStyle(color: Colors.white),
                              children: [
                                const TextSpan(
                                    text: "In a nutshell:\n\n",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                TextSpan(
                                    text: about,
                                    style: const TextStyle(fontSize: 18)),
                                const TextSpan(
                                    text:
                                        "Favourable Environmental Conditions:\n\n",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                TextSpan(
                                    text: favenvcond,
                                    style: const TextStyle(fontSize: 18)),
                                const TextSpan(
                                    text: "General Disease Management:\n\n",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                TextSpan(
                                    text: prevension,
                                    style: const TextStyle(fontSize: 18)),
                              ])),
                        )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.of(context).pop(true);
              },
              child: const Icon(Icons.arrow_back)),
        )
      ],
    );
  }
}
