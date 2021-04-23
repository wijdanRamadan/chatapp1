import 'package:flutter/material.dart';
import 'package:chatapp/services/database_methods.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/widgets/widget.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController msgController = new TextEditingController();
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  Stream chatMessageStream ;

  @override
  void initState() {
    dataBaseMethods.getConversationMessages(Constants.conversationId).then((value) {
      chatMessageStream=value;
      print(chatMessageStream.length);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('name'),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(chatMessageStream),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24 , vertical: 16),
                color: Colors.grey[400],
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: msgController,
                          decoration: InputDecoration(
                              hintText: 'message'
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(icon: Icon(Icons.send),
                          onPressed:(){
                            dataBaseMethods.sendMessage(Constants.conversationId, msgController.text);
                            msgController.text='';
                          }),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
