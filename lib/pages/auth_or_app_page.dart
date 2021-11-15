import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<ChatUser?>(
          stream: AuthMockService().userChanges,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return LoadingPage();
            }else{
              return snapshot.hasData ? ChatPage() : AuthPage();
            }
          },),
      ),
    );
  }
}