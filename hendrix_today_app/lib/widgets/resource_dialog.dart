import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

class LocationFinder extends StatefulWidget {
  const LocationFinder({super.key});

  @override
  State<LocationFinder> createState() => _LocationFinderState();
}

class _LocationFinderState extends State<LocationFinder> {
  // maybe do these in alphabetical order. could include a search bar if it
  // gets too overwhelming
  final Map<String, List<String>> locations = {
    "Career Services": [
      // office
      "(501) 450-1440", // phone number
      "2nd floor SLTC; Room 240", // location
      "careerservices2", // name of the image file in maps
    ],
    "Counseling Services": [
      "501-450-1448",
      "White house behind the Mills Building, 1541 Washington Ave",
      "counselingservices"
    ],
    "Deans Office": ["(501) 450-1222 ", "2nd Floor SLTC, Room 211", "dean"],
    "Lost and Found": ["(501) 329-6811", "1st Floor SLTC", "lostandfound"],
    "Office of Diversity and Inclusion": [
      "501-505-2951",
      "2nd Floor SLTC, Room 245 & 246",
      "dandi",
    ],
    "Title IX": ["501-505-2901", "1st Floor SLTC, Room ____", "titleIX"],
    "Residential Life": ["501-450-1416", "2nd Floor SLTC, Room 251", "reslife"]
  };

  @override
  Widget build(BuildContext context) {
    List<String>? listInfo;

    return SizedBox(
        height: 100,
        width: 300,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 5,
            color: Colors.grey, //Colors.orange[200],
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              hint: const Text("where is?",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'MuseoBold')),
              isExpanded: true,
              style: const TextStyle(
                  color: Colors.black, fontSize: 25, fontFamily: "MuseoSlab"),
              items: [
                'Career Services',
                'Counseling Services',
                'Deans Office',
                'Lost and Found',
                'Office of Diversity and Inclusion',
                'Title IX',
                'Residential Life'
              ].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(
                      val,
                      style: const TextStyle(fontFamily: 'MuseoBold'),
                    ),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    listInfo = locations[val];
                    debugPrint(listInfo![0]);
                  },
                );
                AlertDialog alert = AlertDialog(
                    title: Text(val.toString()), // location
                    alignment: Alignment.center,
                    insetPadding: const EdgeInsets.symmetric(
                        vertical: 100, horizontal: 50),
                    content: Column(children: [
                      SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: Column(
                            children: [
                              ElevatedButton(
                                // phone number
                                onPressed: () => _launchURL(
                                    "tel:+${listInfo![0].toString()}"),
                                child: Text(listInfo![0].toString()),
                              ),
                              Text(listInfo![1].toString()),
                              InteractiveViewer(
                                  // how to zoom in!!!! https://stackoverflow.com/questions/64093990/flutter-how-to-add-a-zoom-functionality-to-image
                                  boundaryMargin: const EdgeInsets.all(20.0),
                                  minScale:
                                      0.1, // doesn't go into effect until after you have made the inital zoom
                                  maxScale: 5,
                                  child: Image(
                                      height: 300,
                                      image: AssetImage(
                                          "assets/maps/${listInfo![2].toString()}.jpg")))
                            ],
                          )),
                    ]));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
            ))));
  }
}
