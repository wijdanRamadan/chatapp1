import 'package:chatapp/helper/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseMethods {

  HelperFunctions helperFunctions = new HelperFunctions();
     getUserByUsername(String username) async {
    return await FirebaseFirestore.instance.collection('users')
    .where('name' , isEqualTo: username)
    .get();
     }

     getUserByEmail(String email) async {
       return await FirebaseFirestore.instance.collection('users')
           .where('email' , isEqualTo: email)
           .get();
     }
     getUserIdByEmail(String email)
     {
        String id ;
        getUserByEmail(email).then((value){
          id = value.data.uid;
        });
     }

     uploadUserInfo(userMap){
       FirebaseFirestore.instance.collection('users')
           .add(userMap);
     }
     
       createConversation(conversationID , conversationMap){
       FirebaseFirestore.instance.collection('conversations')
           .doc(conversationID)
           .set(conversationMap)
           .catchError((e){
             print(e.toString());
       });
       }
       startConversation(String currentUserId , String peerUserId){
       List<String> users =[currentUserId , peerUserId];
       String conversationId = helperFunctions.getConversationId(
           currentUserId, peerUserId);
       Map<String , dynamic > conversationMap = {
         'users': users,
         'conversation_id': conversationId,
       };
       Constants.conversationId=conversationId;
       createConversation(conversationId, conversationMap);
       }

       addConversationMessages(String conversationId , messageMap)
       {
         FirebaseFirestore.instance.collection('conversations')
             .doc(conversationId)
             .collection('chats')
             .add(messageMap);

       }

       sendMessage(conversationId , String message)
       {
if(message.isNotEmpty)
  {
    Map<String , dynamic> messageMap = {
      'message' : message,
      'sent_by' :  FirebaseAuth.instance.currentUser.uid,
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    addConversationMessages(conversationId, messageMap);
  }

       }

       getConversationMessages(String conversationId) async{
         return  FirebaseFirestore.instance.collection('conversations')
             .doc(conversationId)
             .collection('chats')
             .orderBy('time')
             .snapshots();
       }


       }


