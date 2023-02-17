import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'StudentData.dart';
import 'databaseServices.dart';

class Myapp1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return (MyState());
  }
}

List<DataRow> rowss = [];

class MyState extends State {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  List<Student> student = [];

  DatabaseServices db = DatabaseServices();
  @override
  void initState() {
    db.initDatabase();
    super.initState();
  }
//   getrows() async {
//     var rows = await db.selectrecord(int.parse(c1.text));

//     Map<String, Object?> element = rows[0];

//     var id = element['id'];
//     var name = element['name'];
//     var age = element['age'];

//     setState(() {
//       for (int i = 0; i < rows.length; i++) {
//         rowss.add(DataRow(cells: [
//           DataCell(Text("$id")),
//           DataCell(Text("$name")),
//           DataCell(Text("$age"))
//         ]));
//    }
// });
//   }
  getrows() async {
    var rows = await db.selectAllrecord();

    setState(() {
      for (int i = 0; i < rows.length; i++) {
        Map<String, Object?> element = rows[i];

        var id = element['id'];
        var name = element['name'];
        var age = element['age'];

        rowss.add(DataRow(cells: [
          DataCell(Text("$id")),
          DataCell(Text("$name")),
          DataCell(Text("$age"))
        ]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   inputDecorationTheme: InputDecorationTheme(
      //       enabledBorder: OutlineInputBorder(
      //         borderSide: BorderSide(
      //             width: 3, color: Color.fromARGB(255, 114, 251, 64)),
      //       ),
      //       focusedBorder: OutlineInputBorder(
      //           borderSide: BorderSide(
      //               width: 3, color: Color.fromARGB(255, 255, 124, 64)))),
      // ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assignment 4'),//Sqlite
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Id',
                  border: OutlineInputBorder(),
                ),
                controller: c1,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Enter Name', border: OutlineInputBorder()),
                controller: c2,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Enter Age', border: OutlineInputBorder()),
                controller: c3,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        var s1 = Student(
                            id: int.parse(c1.text),
                            name: c2.text,
                            age: int.parse(c3.text));
                        db.insertStudent(s1);
                        student.add(s1);
                      });
                    },
                    child: Text(
                      'Insert',
                    ),
                  ),
                ),
                //
                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getrows();
                      });
                    },
                    child: Text(
                      'Select',
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                      var s1 = Student(
                          id: int.parse(c1.text),
                          name: c2.text,
                          age: int.parse(c3.text));
                      db.updateStudent(s1);
                    },
                    child: Text(
                      'Update',
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                      var s1 = Student(
                          id: int.parse(c1.text),
                          name: c2.text,
                          age: int.parse(c3.text));
                      db.deleteStudent(s1);
                    },
                    child: Text(
                      'Delete',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text('Id'),
                      ),
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(label: Text('Age'))
                    ],
                    rows: rowss,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
