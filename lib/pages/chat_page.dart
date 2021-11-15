import 'package:chat/components/messages.dart';
import 'package:chat/components/new_messages.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({ Key? key }) : super(key: key);

  static const int LOGOUT = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat de Amigos'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                value: LOGOUT,
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10),
                      Text('Sair')
                    ],
                  ),
                )
              )
            ],
            onChanged: (value) {
              if (value == LOGOUT){
                AuthService().logout();
              }
            },            
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessages()
          ],
        ),
      ),
    );
  }
}