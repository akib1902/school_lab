import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String? department;
  String? batch;
  Map<String, dynamic>? selectedCourse;

  // =========================
  // SETTERS
  // =========================

  void setUser(String dept, String batchVal) {
    department = dept;
    batch = batchVal;
    notifyListeners();
  }

  void setCourse(Map<String, dynamic> course) {
    selectedCourse = course;
    notifyListeners();
  }

  void clearCourse() {
    selectedCourse = null;
    notifyListeners();
  }
}