import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:postapiproject/SignInPage.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({Key? key}) : super(key: key);

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  final ImagePicker picker = ImagePicker();

  String imagepath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge
          InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Material(
                      child: CupertinoAlertDialog(
                        insetAnimationCurve: Curves.linear,
                        insetAnimationDuration: Duration(seconds: 3),

                        title: Text("Pick your Image"),
                        actions: [
                          IconButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  imagepath = photo!.path;
                                });
                              },
                              icon: Icon(Icons.camera)),
                          IconButton(
                              onPressed: () async {
                                Navigator.pop(context);

                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);

                                setState(() {
                                  imagepath = image!.path;
                                });
                              },
                              icon: Icon(Icons.photo))
                        ],
                      ),
                    );
                  },
                );

// Pick an image.

// Capture a photo.
              },
              child: imagepath != ""
                  ? CircleAvatar(
                radius: 100,
                backgroundImage: FileImage(File((imagepath))),
              )
                  : CircleAvatar(
                radius: 100,
                backgroundColor: Colors.yellow,
              )),
          SignInPage.MytextField(controller: name, hinttext: "name"),
          SignInPage.MytextField(controller: email, hinttext: "email"),
          SignInPage.MytextField(controller: number, hinttext: "number"),
          SignInPage.MytextField(controller: password, hinttext: "password"),
          ElevatedButton(
              onPressed: () async {
                List<int> imagearray = File(imagepath).readAsBytesSync();

                String imageee = base64Encode(imagearray);

                print("===$imageee");


                Map userdata = {
                  "name": name.text,
                  "email": email.text,
                  "number": number.text,
                  "password":password.text,
                  "encodeimage":imageee
                };


                var url = Uri.https('example.com', 'whatsit/create');
                var response = await http.post(url, body: userdata);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');



                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return SignInPage();
                  },
                ));
              },
              child: Text("Sign Up"))
        ],
      ),
    );
  }
}
