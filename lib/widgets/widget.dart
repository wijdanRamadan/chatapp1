import 'package:chatapp/services/database_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/views/chat.dart';

Widget searchList(QuerySnapshot querySnapshot , bool searched){
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  return  searched?
  ListView.builder(
    shrinkWrap: true,
    itemCount: querySnapshot.docs.length ,
    itemBuilder: (context,index){
      return searchTile(querySnapshot.docs[index].data()['name'],
          querySnapshot.docs[index].data()['email'],
          FirebaseAuth.instance.currentUser.email,
        context
          );
    },
  ) : Container();
}


Widget searchTile(String username , String peerUserEmail  , String currentUserEmail , context) {
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  return Container(
    color: Colors.grey[300],
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username , style: TextStyle(fontSize: 16),),
              Text(peerUserEmail , style: TextStyle(fontSize: 16))
            ],
          ),
          FlatButton(onPressed:()
          {
            if(peerUserEmail!=currentUserEmail )
           dataBaseMethods.startConversation(peerUserEmail, currentUserEmail);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Chat();
                }));
           } ,
              child: Text('message'))
        ],
      ),
    ),
  );
}

Widget chatMessageList(Stream chat){
return StreamBuilder(
  stream:  chat,
  builder: (context , snapshot){
    return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context , index){
        return messageTile(snapshot.data.docs[index].data()['message'],
            FirebaseAuth.instance.currentUser.uid == snapshot.data.docs[index].data()["sent_by"],);
        }
    ) : Container();
  },
);
}

Widget messageTile(String msg , bool sentByMe)
{
  return Container(
    padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: sentByMe ? 0 : 24,
        right: sentByMe ? 24 : 0),
    alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: sentByMe
          ? EdgeInsets.only(left: 30)
          : EdgeInsets.only(right: 30),
      padding: EdgeInsets.only(
          top: 17, bottom: 17, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: sentByMe ? BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23)
          ) :
          BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)),
          gradient: LinearGradient(
            colors: sentByMe ? [
              const Color(0xff007EF4),
              const Color(0xff2A75BC)
            ]
                : [
              const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF)
            ],
          )
      ),
      child: Text(msg,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'OverpassRegular',
              fontWeight: FontWeight.w300)),
    ),
  );
}