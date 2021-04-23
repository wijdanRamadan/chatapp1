import 'package:chatapp/services/database_methods.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  DataBaseMethods dbMethods = new DataBaseMethods();
  TextEditingController userNameController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;
  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if (userNameController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await dbMethods.getUserByUsername(userNameController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          haveUserSearched = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat app'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24 , vertical: 16),
              color: Colors.grey[400],
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: userNameController,
                        decoration: InputDecoration(
                            hintText: 'username'
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon: Icon(Icons.search),
                        onPressed:(){
                            initiateSearch();
                        }),
                  )
                ],
              ),
            ),
            searchList( searchResultSnapshot ,haveUserSearched),
          ],
        ),
      ),
    );
  }

}
