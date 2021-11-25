import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage(this.url,this.name,this.age,this.gender,this.id,{Key? key}) : super(key: key);
  String url;
  String name;
  String age;
  String gender;
  String id;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? url = '';
  bool isVisible = false;
  TextEditingController? ctl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctl = TextEditingController();
    url = widget.url;
    checkUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                          title:  'HACKATHON',
                              url: url!,name: widget.name,age:
                        widget.age,gender: widget.gender,id: widget.id,
                            )));
              })
          ,
          title: const Text(
            "HACKATHON",
            style: TextStyle(color: Colors.red),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        body: Stack(children: <Widget>[
          Positioned(
              bottom: 0.0,
              child: SvgPicture.asset(
                "assets/background.svg",
                fit: BoxFit.cover,
              )),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Configure o seu proprio URL "),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: ctl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'URL',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        url = value;
                        isVisible = true;
                        print(url);
                        ctl!.clear();
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(url!),
                        IconButton(
                            onPressed: () => removeUrl(),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  void checkUrl() {
    if (url != "" && url != null) {
      setState(() {
        isVisible = true;
      });
    }
  }

  void removeUrl() {
    setState(() {
      url = '';
      isVisible = false;
    });
  }
}
