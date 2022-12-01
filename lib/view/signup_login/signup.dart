import 'package:flutter/material.dart';
import 'package:myblog_app/Utlis/utlis.dart';
import 'package:myblog_app/view/signup_login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myblog_app/widget/coustom_button.dart';
import 'package:myblog_app/widget/textformfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loding = false;
  final _key = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerEmail.clear();
    _controllerPassword.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _key,
                child: Column(
                  children: [
                    CoustomTextFormField(
                        controller: _controllerEmail,
                        data_return: 'Enter Email',
                        obsText: false,
                        icon: Icon(Icons.mail),
                        hintText: 'Enter Email'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CoustomTextFormField(
                        controller: _controllerPassword,
                        data_return: 'Enter passwoed',
                        obsText: true,
                        icon: Icon(Icons.password),
                        hintText: 'Enter Password')
                  ],
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CoustomMaterialButton(
                onpressed: () {
                  if (_key.currentState!.validate()) {
                    setState(() {
                      loding = true;
                    });
                    setState(() {
                      Singup(_controllerEmail.text.toString(),
                          _controllerPassword.text.toString(), context);
                    });
                  }
                }, loading: loding, data: 'SignUp'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  "Don't have an account ? ",
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text("Sign In", style: TextStyle(fontSize: 24)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void Singup(email, password, BuildContext context) async {
    try {
      loding = true;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
        setState(() {
          loding = false;
        });
        Utlis().toastMessage("Sucessfully insert data");
      }).onError((error, stackTrace) {
        setState(() {
          loding = false;
        });
        Utlis().toastMessage(error.toString());
      });
    } catch (e) {
      setState(() {
        loding = false;
      });

      Utlis().toastMessage(e.toString());
    }
  }
}
