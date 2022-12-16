import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogDetalis extends StatefulWidget {
  BlogDetalis({Key? key, required this.documentSnapshot}) : super(key: key);
  DocumentSnapshot documentSnapshot;

  @override
  State<BlogDetalis> createState() => _BlogDetalisState();
}

class _BlogDetalisState extends State<BlogDetalis> {
  @override
  void initState() {
    // print(" aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${documentSnapshot.toString()}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Blog New Deatlis"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "${widget.documentSnapshot["img"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
                child: Container(
              margin: EdgeInsets.all(4),
              child: Card(
                elevation: 6,
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        "${widget.documentSnapshot["title"]}",
                        maxLines: 2,

                        style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "${widget.documentSnapshot["dis"]}",
                        maxLines: 8,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    ));
  }
}
