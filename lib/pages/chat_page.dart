import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Chat Page'),
          TextButton(
            child: Text('Logout'),
            onPressed: ()=> AuthService().logout()
          )
        ],
      ),
    );
  }
}