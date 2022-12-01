import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myblog_app/Utlis/utlis.dart';
import 'package:myblog_app/view/Blog/addpost_blog.dart';
import 'package:myblog_app/view/signup_login/login.dart';
import 'package:myblog_app/widget/textformfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController serch_controller = TextEditingController();
  String serch = "";
  Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Course").snapshots();

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("View Page"),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Utlis().toastMessage("LogOut");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  }).onError((error, stackTrace) {});
                },
                icon: Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPostBlog()));
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: [
              TextFormField(
                controller: serch_controller,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
                cursorRadius: Radius.circular(10),
                cursorColor: Color(0xff8A8A8E),
                decoration: InputDecoration(
                    fillColor: Colors.black,
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Color(0xff8A8A8E))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color(0xff8A8A8E).withOpacity(0.7),
                    suffixIconColor: Color(0xff8A8A8E).withOpacity(0.7),
                    hintText: "Serch...",
                    hintStyle: TextStyle(color: Color(0xff8A8A8E))),
                onChanged: (String value) {
                  serch = value;
                },
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print("eroooooooo");
                    }


                    else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        String tempTitle=data["title"];
                        if(serch_controller.text.isEmpty){
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Card(
                              elevation: 5,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            child: Image.network(data["img"])),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                            ),
                                            Text(
                                              data["title"],
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                            ),
                                            Text(data["dis"],
                                                maxLines: 4,
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                        else if(tempTitle.toLowerCase().contains(serch_controller.text.toString())){
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Card(
                              elevation: 5,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            child: Image.network(data["img"])),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                            ),
                                            Text(
                                              data["title"],
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                            ),
                                            Text(data["dis"],
                                                maxLines: 4,
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }
                        else{
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Card(
                              elevation: 5,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            child: Image.network(data["img"])),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                            ),
                                            Text(
                                              data["title"],
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                            ),
                                            Text(data["dis"],
                                                maxLines: 4,
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }

                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
