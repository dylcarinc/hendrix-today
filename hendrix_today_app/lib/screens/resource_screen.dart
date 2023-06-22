import 'package:flutter/material.dart';
import 'package:hendrix_today_app/widgets/resource_button.dart';

import 'package:url_launcher/url_launcher.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

_launchURL(String url) async {
  const submissionFormUrl =
      'https://forms.office.com/Pages/ResponsePage.aspx?id=jMH2DNLQP0qD0GY9Ygpj020T9lhtzfhCi8WBPrgNg0xURFZXMEEyUzUwR0lNSzZTTDdWWEQwOERSWiQlQCN0PWcu';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

class _ResourcesScreenState extends State<ResourcesScreen> {
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
    // below would be used for animating the map to grow when touched
    //double sideLength = 50;
    return Center(
        child: Column(children: <Widget>[
      const SizedBox(height: 100),
      const ResourceButton(
          titleString: "submit new event",
          icon: Icons.add,
          url:
              'https://forms.office.com/Pages/ResponsePage.aspx?id=jMH2DNLQP0qD0GY9Ygpj020T9lhtzfhCi8WBPrgNg0xURFZXMEEyUzUwR0lNSzZTTDdWWEQwOERSWiQlQCN0PWcu'),
      const SizedBox(height: 30),
      SizedBox(
          height: 100,
          width: 300,
          child: Card(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      // border color
                      color: Colors.black45,
                      // border thickness
                      width: 3)),
              elevation: 5,
              color: Colors.grey, //Colors.orange[200],
              child: DropdownButtonFormField(
                hint: const Text("Where is?",
                    style: TextStyle(
                        fontSize: 30, color: Colors.white, fontFamily: 'Lora'
                        //fontFamily: 'Lora',
                        //fontWeight: FontWeight.bold
                        )),
                isExpanded: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.question_mark,
                    size: 30,
                    color: Colors.white,
                  ),
                  labelText: "where is?",
                ),
                //iconSize: 30.0,
                style: const TextStyle(
                    color: Colors.black, fontSize: 30, fontFamily: "MuseoSlab"),
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
                        style: const TextStyle(fontFamily: 'Lora'),
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
                      insetPadding: const EdgeInsets.all(20),
                      content: Column(children: [
                        SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  // phone number
                                  onPressed: () => launchUrl(Uri.parse(
                                      "tel:+${listInfo![0].toString()}")),
                                  child: Text(listInfo![0].toString()),
                                ),
                                /* email launch button 
                                ElevatedButton(
                                  onPressed: () {
                                    UrlLauncher.launch(
                                        "tel://${listInfo![0].toString()}");
                                  },
                                  child: Text(listInfo![1].toString()),
                                ),*/
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
                      return Column(
                        children: [
                          alert,
                        ],
                      );
                    },
                  );
                },
              ))),
      const SizedBox(height: 30),
      const ResourceButton(
          titleString: "public safety",
          icon: Icons.phone,
          url: "tel:+5014507711"),
    ]));
  }
}
