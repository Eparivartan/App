import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? userId;
  String? userName;
  String? userContact;
  String? userEmail;
  String? addedOn;

  // Update the user data
  void updateUser({
    required String userId,
    required String userName,
    required String userContact,
    required String userEmail,
    required String addedOn,
  }) {
    this.userId = userId;
    this.userName = userName;
    this.userContact = userContact;
    this.userEmail = userEmail;
    this.addedOn = addedOn;

    notifyListeners(); // Notify listeners of changes
  }
}
