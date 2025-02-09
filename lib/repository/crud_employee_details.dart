import 'package:employee_details_app/pages/add_emplyee_details/model/employee_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class PersistentDatabase {
  late final Database database;

  Future<Database> initialiseDatabase() async {
    if (kIsWeb) {
      // sqfliteFfiInit();
      var factory = databaseFactoryFfiWeb;
      return await factory.openDatabase('employeesTable.db',
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              await db.execute('''
       CREATE TABLE employee(id INTEGER PRIMARY KEY, employeeName TEXT, employeeRole TEXT, fromDate Text, toDate Text)
      ''');
            },
          ));
    } else {
      return openDatabase(
        path.join(await getDatabasesPath(), 'employeesTable.db'),
        onCreate: (db, version) async {
          return await db.execute(
              'CREATE TABLE employee(id INTEGER PRIMARY KEY, employeeName TEXT, employeeRole TEXT, fromDate Text, toDate Text)');
        },
        version: 1,
      );
    }

    // return openDatabase(
    //   path.join(await getDatabasesPath(), 'employeesTable.db'),
    //   onCreate: (db, version) async {
    //     return await db.execute(
    //         'CREATE TABLE employee(id INTEGER PRIMARY KEY, employeeName TEXT, employeeRole TEXT, fromDate Text, toDate Text)');
    //   },
    //   version: 1,
    // );
    // return database;
  }

  Future<EmployeeDetailsModel> getEmployeeById(int employeeId) async {
    final db = await initialiseDatabase();

    final List<Map<String, Object?>> employeeMap =
        await db.query('employee', where: 'id = ?', whereArgs: [employeeId]);

    return EmployeeDetailsModel(
      employeeName: employeeMap[0]['employeeName'] as String,
      employeeRole: employeeMap[0]['employeeRole'] as String,
      fromDate: employeeMap[0]['fromDate'] as String,
      toDate: employeeMap[0]['toDate'] as String?,
    );
  }

  Future<void> insertEmployeeDetails(EmployeeDetailsModel task) async {
    try {
      final db = await initialiseDatabase();

      await db.insert(
        'employee',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EmployeeDetailsModel>>? getAllEmployess() async {
    try {
      final db = await initialiseDatabase();

      final List<Map<String, Object?>> employeeMap = await db.query('employee');

      if (employeeMap.isNotEmpty) {
        return employeeMap
            .map((task) => EmployeeDetailsModel(
                  id: task['id'] as int,
                  employeeName: task['employeeName'] as String,
                  employeeRole: task['employeeRole'] as String,
                  fromDate: task['fromDate'] as String,
                  toDate: task['toDate'] as String?,
                ))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEmployeeDetails(EmployeeDetailsModel task) async {
    try {
      final db = await initialiseDatabase();

      await db.update(
        'employee',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEmployeeDetails(int employeeId) async {
    try {
      final db = await initialiseDatabase();

      await db.delete(
        'employee',
        where: 'id = ?',
        whereArgs: [employeeId],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future close() async {
    final db = await initialiseDatabase();
    db.close();
  }
}
