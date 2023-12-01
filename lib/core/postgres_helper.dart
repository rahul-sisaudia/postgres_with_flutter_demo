import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

import '../resources/constants.dart';

class PostgresHelper {
  static var connection = PostgreSQLConnection(
      Constants.dbHostForEmulator, Constants.port, Constants.db,
      username: Constants.dbUsername, password: Constants.dbPassword);
  static Future<void> requestForDBConnectionStart() async {
    await connection
        .open()
        .then((value) => debugPrint("Connection Establish"));
  }

static Future<String?> createTable() async{
  try {
    // var result = await connection.query('''
    //   SELECT EXISTS (
    // SELECT FROM
    //     pg_tables
    // WHERE
    //     schemaname = 'public' AND
    //     tablename  = 'person'
    // )''');
    //ifExist = result[0][0];
    // if (!ifExist) {
    //   await connection.query('''
    //       CREATE TABLE person(
    //       name text,
    //       email text
    //       )
    //     ''');
    // }
    await connection.query('''
          CREATE TABLE person1(
          name text,
          email text
          )
        ''').then((value) => (){
          return "table created successfully";
    });
  } on PostgreSQLException catch (e) {
    print(e.message);
   return e.message;
  }
  return "";
}
  static Future<void> requestForDBConnectionStop() async {
    try {
      await connection
          .close()
          .then((value) => debugPrint("Connection successfully close"));
    } on PostgreSQLException catch (e) {
      print(e.message);
    }
  }

  static Future<void> addData() async {
    try {
          await connection.query('''
        INSERT INTO ${Constants.usersTable} (name,email)
        VALUES ('RAHUL THAKUR','rahul@oppong.co')
      ''');
    } on PostgreSQLException catch (e) {
      print(e.message);
    }
  }

  static Future<void> fetchAllData() async {
    try {
      dynamic results = await connection.query("SELECT * FROM ${Constants.usersTable}");
      if (results.isEmpty) {
        print("No Record Found");
      } else {
        for (final row in results) {
          var a = row[0];
          var b = row[1];
          print("A = " + a);
          print("B = " + b);
        }
      }
    } on PostgreSQLException catch (e) {
      print(e.message);
    }
  }
}
