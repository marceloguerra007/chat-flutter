import 'package:chat/components/message_bubble.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currenteUser = AuthService().currentUser;
    
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else if (!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text('Ainda não há mensagem'));
        }else{
          final msgs = snapshot.data!;
          return ListView.builder(            
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => Container(
              child: MessageBubble(
                key: ValueKey(msgs[i].id),
                message: msgs[i], 
                belongsToCurrentUser: currenteUser?.id == msgs[i].userId
              )
            )
          );
        }
      },
    );
  }
}