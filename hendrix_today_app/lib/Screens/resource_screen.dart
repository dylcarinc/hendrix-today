import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart' as url_launcher;
//import 'package:dropdown_formfield/dropdown_formfield.dart';

// get HDX type face imported and make it look better

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

_launchURL() async {
  const url =
      'https://forms.office.com/Pages/ResponsePage.aspx?id=jMH2DNLQP0qD0GY9Ygpj020T9lhtzfhCi8WBPrgNg0xURFZXMEEyUzUwR0lNSzZTTDdWWEQwOERSWiQlQCN0PWcu';
  final uri = Uri.parse(url);
  if (await url_launcher.canLaunchUrl(uri)) {
    await url_launcher.launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

/**TextSpan(text: 'And this is a clickable text',
    recognizer: TapGestureRecognizer()
   onTap: () => UrlLauncher.launch("tel://5014507711")    
    ), 
    */

class _ResourcesScreenState extends State<ResourcesScreen> {
  // maybe do these in alphabetical order. could include a search bar if it gets too overwhelming
  final Map<String, List<String>> Locations = {
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
    String? _dropDownValue;
    List<String>? listInfo;
    // below would be used for animating the map to grow when touched
    //double sideLength = 50;
    return Center(
        child: Column(children: <Widget>[
      SizedBox(height: 100),
      SizedBox(
          height: 100,
          width: 300,
          child: Card(
              shape: StadiumBorder(
                side: BorderSide(
                  // border color
                  color: Colors.black38,
                  // border thickness
                  width: 5,
                ),
              ),
              elevation: 5,
              color: Color.fromARGB(255, 202, 81, 39),
              child: ListTile(
                title: Text(
                  "Submit to Hendrix Today!",
                  style: TextStyle(
                      fontSize: 27, color: Colors.white, fontFamily: 'Lora'),
                  textAlign: TextAlign.center,
                ),
                leading: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
                onTap: () => _launchURL(),
              ))),
      SizedBox(height: 30),
      SizedBox(
          height: 100,
          width: 300,
          child: Card(
              shape: RoundedRectangleBorder(
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
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.question_mark,
                    size: 30,
                    color: Colors.white,
                  ),
                  labelText: "where is?",
                ),
                //iconSize: 30.0,
                style: TextStyle(
                    color: Colors.black, fontSize: 30, fontFamily: 'Lora'),
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
                        style: TextStyle(fontFamily: 'Lora'),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _dropDownValue = val;
                      listInfo = Locations[val];
                      print(listInfo![0]);
                    },
                  );
                  AlertDialog alert = AlertDialog(
                      title: Text(val.toString()), // location
                      alignment: Alignment.center,
                      insetPadding: EdgeInsets.all(20),
                      content: Column(children: [
                        Container(
                            width: double.infinity,
                            height: 400,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  // phone number
                                  onPressed: () {
                                    url_launcher.launch(
                                        "tel://${listInfo![0].toString()}");
                                  },
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
                                Text("${listInfo![1].toString()}"),
                                InteractiveViewer(
                                    // how to zoom in!!!! https://stackoverflow.com/questions/64093990/flutter-how-to-add-a-zoom-functionality-to-image
                                    boundaryMargin: EdgeInsets.all(20.0),
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
      SizedBox(height: 30),
      SizedBox(
          height: 100,
          width: 300,
          child: Card(
              shape: StadiumBorder(
                side: BorderSide(
                  // border color
                  color: Colors.black38,
                  // border thickness
                  width: 5,
                ),
              ),
              elevation: 5,
              color: Color.fromARGB(255, 202, 81, 39), //Colors.orange[200],
              child: ListTile(
                title: Text(
                  "Call Public Safety",
                  style: TextStyle(
                      fontSize: 30, color: Colors.white, fontFamily: 'Lora'),
                  textAlign: TextAlign.center,
                ),
                leading: Icon(Icons.phone, size: 50, color: Colors.white),
                onTap: () => url_launcher.launch("tel://5014507711"),
              ))),
    ]));
  }
}
