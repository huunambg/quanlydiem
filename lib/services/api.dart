import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quanlydiem/const/ipv4.dart';
import 'package:quanlydiem/model/acount.dart';
import 'package:quanlydiem/model/class.dart';
import 'package:quanlydiem/model/grade.dart';
import 'package:quanlydiem/model/grade_with_student.dart';
import 'package:quanlydiem/model/student.dart';
import 'package:quanlydiem/model/subject.dart';

class ApiService {
  final String baseUrl;
  ApiService()
      : baseUrl = "http://$ipv4:3000/public/api"; // Thay bằng URL của bạn

  Future<dynamic> login(Account account) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(account.toJson()),
      );
      print("login ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      // Lỗi mạng hoặc các lỗi không xác định
      print("Network error: $e");
      rethrow;
    }
  }

  Future<dynamic> register(Account account) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(account.toJson()),
      );
      return response;
    } catch (e) {
      // Lỗi mạng hoặc các lỗi không xác định
      print("Network error: $e");
      throw "Unable to connect to server. Please check your internet connection.";
    }
  }

  Future<void> addGrade(Grade grade) async {
    final url = Uri.parse('$baseUrl/add-grade');
    print(url);
    try {
      final response = await http.post(url, body: grade.toJson());
      print("addGrade ${jsonDecode(response.body)['data']}");
      if (response.statusCode != 200) {
        throw response.body;
      }
    } catch (e) {
      print("addGrade: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<void> updateGrade(Grade grade) async {
    final url = Uri.parse('$baseUrl/update-grade');
    print(url);
    try {
      final response = await http.put(url, body: grade.toJsonUpdate());
      print("updateGrade ${jsonDecode(response.body)['data']}");
      if (response.statusCode != 200) {
        throw response.body;
      }
    } catch (e) {
      print("updateGrade: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<Class>> getListClassByTeacher(int teacherId) async {
    final url = Uri.parse('$baseUrl/get-class-by-teacher/$teacherId');
    print(url);
    try {
      final response = await http.get(
        url,
      );
      print("getListClassByTeacher ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Class> listClass = listData
            .map(
              (e) => Class.fromJson(e),
            )
            .toList();
        return listClass;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<Student>> getStudentByClass(int classId) async {
    final url = Uri.parse('$baseUrl/get-student-by-class/$classId');
    print(url);
    try {
      final response = await http.get(
        url,
      );
      print("getStudentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Student> listStudent = listData
            .map(
              (e) => Student.fromJson(e),
            )
            .toList();
        return listStudent;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<Subject>> getSubject(String accessToken) async {
    final url = Uri.parse('$baseUrl/get-all-subject');
    try {
      final response = await http.get(
        url,
      );
      print("getSubject ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Subject> listSubject = listData
            .map(
              (e) => Subject.fromJson(e),
            )
            .toList();
        return listSubject;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<Grade>> getGradeByClassAndStudent(
      int classId, int studentId) async {
    final url = Uri.parse('$baseUrl/get-grade-by-class-and-student');
    print(url);
    try {
      final response = await http.post(url,
          headers: {},
          body: {"class_id": "$classId", "student_id": "$studentId"});
      print("getStudentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<Grade> listGrade = listData
            .map(
              (e) => Grade.fromJson(e),
            )
            .toList();
        return listGrade;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }

  Future<List<GradeWithStudent>> getGradeBySubjectClass(
      int classId, int subjectId) async {
    final url = Uri.parse('$baseUrl/get-grade-subject-class');
    print(url);
    try {
      final response = await http.post(url,
          headers: {},
          body: {"class_id": "$classId", "subject_id": "$subjectId"});
      print("getStudentByClass ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body)['data'];
        List<GradeWithStudent> listGrade = listData
            .map(
              (e) => GradeWithStudent.fromJson(e),
            )
            .toList();
        return listGrade;
      } else {
        throw "Tài khoản hoặc mật khẩu không chính xác!.";
      }
    } catch (e) {
      print("Network error: $e");
      throw "Lỗi kết nối tới máy chủ.";
    }
  }
}
