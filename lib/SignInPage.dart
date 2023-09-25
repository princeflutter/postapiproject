import 'package:flutter/material.dart';
import 'package:postapiproject/SignUppage.dart';

class SignInPage extends StatefulWidget {
  static  Widget MytextField({
    required TextEditingController controller,
    required String hinttext,
  }) {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hinttext,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInPage.MytextField(controller: username, hinttext: "Username"),
          SignInPage.MytextField(controller: password, hinttext: "password"),
          
          ElevatedButton(onPressed: () {
            
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              
              
              return SignUppage();
            },));
            
          }, child: Text("Signin"))
        ],
      ),
    );
  }


}
