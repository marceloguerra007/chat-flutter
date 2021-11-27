import 'dart:io';

import 'package:chat/core/models/chat_user.dart';
import 'auth_firebase_service.dart';

abstract class AuthService{
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signup(String name, String email, String password, File? image);
  Future<void> login(String email, String password);
  Future<void> logout();

  factory AuthService(){
    return AuthFirebaseService();
  }
}