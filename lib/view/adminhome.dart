import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myblog_app/Utlis/utlis.dart';
import 'package:myblog_app/view/Blog/addpost_blog.dart';
import 'package:myblog_app/view/Blog/updatepost_blog.dart';
import 'package:myblog_app/view/signup_login/login.dart';
import 'package:myblog_app/widget/textformfield.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Course").snapshots();

  UpDate(cource_id, cource_title, cource_dis, img) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (builder) => UpdatePostBlog(
            docmentID: cource_id,
            title: cource_title,
            dis: cource_dis,
            img: img)));
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    Future<void> deleteUser(selectedData) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Course');
      return users.doc(selectedData).delete().then((value) {
        print("User Deleted");
        Utlis().toastMessage("Delet");
      }).catchError((error) {
        Utlis().toastMessage(error.toString());
        print("Failed to delete user: $error");
      });
    }

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
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print("eroooooooo");
                    } else if (snapshot.connectionState ==
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

                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Card(
                            elevation: 5,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(data["img"],fit: BoxFit.cover,)),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Text(data["dis"],
                                              maxLines: 3,
                                              style: TextStyle(fontSize: 16)),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    UpDate(
                                                        document.id,
                                                        data["title"],
                                                        data["dis"],
                                                        data["img"]);
                                                  },
                                                  icon: Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      deleteUser(document.id);
                                                    });
                                                  },
                                                  icon: Icon(Icons.delete)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
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
