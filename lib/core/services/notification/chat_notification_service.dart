import 'package:chat/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';


class ChatNotificationService with ChangeNotifier{
  List<ChatNotification> _items = [];

  List<ChatNotification> get items{
    return [..._items];
  }

  void add(ChatNotification notification){
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i){
    _items.removeAt(i);
    notifyListeners();
  }

  int get itemsCount{
    return _items.length;
  }

  //Push Notification
  Future<void> init() async {
    await _configureForeground();
  }

  //Utilizado geralmente para o IOS
  Future<bool> get _isAuthorized async{
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized){
      FirebaseMessaging.onMessage.listen((msg) { 
        if (msg.notification == null)
          return;
        
        add(ChatNotification(
          title: msg.notification!.title ?? '(Sem Titulo)',
          body: msg.notification!.body ?? ''));
      });
    }
  }


}