import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatFirebaseService implements ChatService{
  
  @override
  Stream<List<ChatMessage>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store.collection('chat').withConverter(
      fromFirestore: _fromFirestore, 
      toFirestore: _toFirestore
    )
    .orderBy('createdAt', descending: true)
    .snapshots();
    
    return Stream<List<ChatMessage>>.multi((controller) {
      snapshots.listen((snapshot) { 
        List<ChatMessage> list = snapshot.docs.map((doc) => doc.data()).toList();
        controller.add(list);
      });
    });

    /* //Retorno simplicado que é igual o retorno acima mas de forma implicita.
      return snapshots.map((snapshot){
        return snapshot.docs.map((doc){
          return doc.data();
        }).toList();
      });
     */
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final msg = ChatMessage(
      id: '', 
      text: text, 
      createdAt: DateTime.now(), 
      userId: user.id, 
      userName: user.name, 
      userImageURL: user.imageURL
    );
    
    final store = FirebaseFirestore.instance;
    final docRef = await store
    .collection('chat')
    .withConverter(
      fromFirestore: _fromFirestore, 
      toFirestore: _toFirestore)
    .add(msg);     

    final doc = await docRef.get();
    return doc.data()!;   
  }

  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc, 
    SnapshotOptions? options
  ){
    return ChatMessage(
      id: doc.id, 
      text: doc['text'], 
      createdAt: DateTime.parse(doc['createdAt']), 
      userId: doc['userId'], 
      userName: doc['userName'], 
      userImageURL: doc['userImageURL']
    );   
  }
  
  Map<String, dynamic> _toFirestore(ChatMessage msg, SetOptions? options){
    return {
      'text': msg.text, 
      'createdAt': msg.createdAt, 
      'userId': msg.userId, 
      'userName': msg.userName,
      'userImageURL': msg.userImageURL   
    };
  }
}