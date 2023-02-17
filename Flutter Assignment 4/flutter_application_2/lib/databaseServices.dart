import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'StudentData.dart';
import 'student.dart';

class DatabaseServices {
  late Future<Database>
      database; //making database global so that every function inside the class can access it.
  void initDatabase() async {
    // Open the database and store the reference.
    database = openDatabase(
      // Set the path to the database.
      join(await getDatabasesPath(), 'student_database4.db'),
      // When the database is first created, create a table to store counters;
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          'CREATE TABLE student(id int, name varchar(50), age int)',
        );
        Fluttertoast.showToast(
            msg: "Table created finally",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  } //Function whatever () ends here

  // Define a function that inserts student into the database.
  Future<void> insertStudent(Student stud) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the student into the correct table. Here, if a student is inserted twice,
    // it replace any previous data.

    await db.insert(
      'student',
      stud.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    Fluttertoast.showToast(
      msg: "Record Inserted",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.purple,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

 Future<List<Map<String, Object?>>> selectrecord(int id) async {
    final Database db = await database;
    
    List<Map<String, Object?>> rows =
        await db.query("student", where: "id=?", whereArgs: [id]);
    return rows;
  }

  Future<List<Map<String, Object?>>> selectAllrecord() async {
    final Database db = await database;

    List<Map<String, Object?>> rows =
        await db.query("student");
  return rows;
}

  Future<void> deleteStudent(Student stud) async {
    final Database db = await database;
    await db.delete('student', where: 'id=?', whereArgs: [stud.id]);

    Fluttertoast.showToast(
        msg: "Record deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> updateStudent(Student stud) async {
    final Database db = await database;
    await db
        .update('student', stud.toMap(), where: 'id=?', whereArgs: [stud.id]);
    Fluttertoast.showToast(
        msg: "Record Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
