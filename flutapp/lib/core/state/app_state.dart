import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppState extends ChangeNotifier {
  final box = Hive.box('appBox');
  
  String? department;
  String? batch;
  Map<String, dynamic>? selectedCourse;

    // =========================
  // INIT (LOAD FROM HIVE)
  // =========================

  void loadFromStorage() {
    department = box.get('department');
    batch = box.get('batch');
    selectedCourse = box.get('course');

    notifyListeners();
  }

  // =========================
  // SETTERS
  // =========================

  void setUser(String dept, String batchVal) {
    department = dept;
    batch = batchVal;

    box.put('department', dept);
    box.put('batch', batchVal);

    notifyListeners();
  }

  // =========================
  // SET COURSE
  // =========================

  void setCourse(Map<String, dynamic> course) {
    selectedCourse = course;

    box.put('course', course);

    notifyListeners();
  }

  void clearCourse() {
    selectedCourse = null;
    box.delete('course');
    notifyListeners();
  }
}