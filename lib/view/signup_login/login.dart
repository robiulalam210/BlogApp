import 'package:flutter/material.dart';
import 'package:myblog_app/Utlis/utlis.dart';
import 'package:myblog_app/view/home.dart';
import 'package:myblog_app/view/signup_login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myblog_app/widget/coustom_button.dart';
import 'package:myblog_app/widget/textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  bool loading = false;

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
        title: Text("Login"),
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
                        data_return: 'Enter email',
                        obsText: false,
                        icon: Icon(Icons.mail),
                        hintText: 'Enter Email'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CoustomTextFormField(
                        controller: _controllerPassword,
                        data_return: '',
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
                      loading = true;
                    });
                    setState(() {
                      Login(_controllerEmail.text.toString(),
                          _controllerPassword.text.toString(), context);
                    });
                  }
                }, loading: loading, data: 'Login'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                Text("Don't have an account ? ",
                    style: TextStyle(fontSize: 16)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                    child: Text("Sign Up", style: TextStyle(fontSize: 20)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Login(email, password, BuildContext context) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Utlis().toastMessage("Sucessfully User Match");
        Utlis().toastMessage(value.user!.email.toString());
        setState(() {
          loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utlis().toastMessage(error.toString());
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      Utlis().toastMessage(e.toString());
    }
  }
}
