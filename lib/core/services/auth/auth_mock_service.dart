import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService{
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  
  static final _defaultUser = ChatUser(
    id: '7', 
    name: 'default', 
    email: "teste@teste.com.br", 
    imageURL: 'assets/images/avatar.png'
  );

  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });  
  
  static Map<String, ChatUser> _users ={
    _defaultUser.email : _defaultUser
  }; 

  @override
  // TODO: implement currentUser
  ChatUser? get currentUser {
    return _currentUser;
  }

 @override
  // TODO: implement userChanges
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);    
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(String name, String email, String password, File? image) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(), 
      name: name, 
      email: email, 
      imageURL: image?.path ?? 'assets/images/avatar.png'
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user){
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}