// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hendrix_today_app/Objects/AppState.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
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
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
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
  final Map<String, String> Locations = {
    "Lost and Found": "1",
    "Title IX": "2",
    "Office of Diversity and Inclusion": "3",
    "Deans Office": "4"
  };

  @override
  Widget build(BuildContext context) {
    String? _dropDownValue;
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
                      fontSize: 29, color: Colors.white, fontFamily: 'Lora'),
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
                  'Lost and Found',
                  'Title IX',
                  'Office of Diversity and Inclusion',
                  'Deans office'
                ].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(
                        val,
                        //style: TextStyle(fontFamily: 'Lora'),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _dropDownValue = val;
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    title: Text(val.toString()),
                    insetPadding:
                        EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                    content: Column(children: [
                      Text(Locations[val].toString()),
                    ]),
                  );
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
          width: 320,
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
                title: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.phone,
                                  size: 35, color: Colors.white),
                            ),
                          ),
                          TextSpan(
                              text: 'Call Public Saftey',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: 'Lora'))
                        ],
                      ),
                    )
                    // child: Text(
                    //   "Call Public Safety",
                    //   style: TextStyle(
                    //       fontSize: 25, color: Colors.white, fontFamily: 'Lora'),
                    //   textAlign: TextAlign.center,
                    // ),
                    ),
                // leading: Padding(
                //   padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                //   child: Icon(Icons.phone, size: 40, color: Colors.white),
                // ),
                onTap: () => UrlLauncher.launch("tel://5014507711"),
              ))),
    ]));
  }
}
