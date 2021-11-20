import 'package:chat/core/models/chat_notification.dart';
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
  }

  int get itemsCount{
    return _items.length;
  }

}