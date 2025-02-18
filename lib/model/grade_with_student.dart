class GradeWithStudent {
  int? gradeId;
  int? studentId;
  int? subjectId;
  int? classId;
  double? ddgtx1;
  double? ddgtx2;
  double? ddgtx3;
  double? ddgtx4;
  double? ddgGk;
  double? ddgCk;
  double? dtbMhk;
  String? academicYear;
  String? semester;
  String? fullName;
  String? dateOfBirth;

  GradeWithStudent(
      {this.gradeId,
      this.studentId,
      this.subjectId,
      this.classId,
      this.ddgtx1,
      this.ddgtx2,
      this.ddgtx3,
      this.ddgtx4,
      this.ddgGk,
      this.ddgCk,
      this.dtbMhk,
      this.academicYear,
      this.semester,
      this.fullName,
      this.dateOfBirth});

  GradeWithStudent.fromJson(Map<String, dynamic> json) {
    gradeId = json['grade_id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    classId = json['class_id'];
    ddgtx1 = (json['ddgtx1'] as num?)?.toDouble();
    ddgtx2 = (json['ddgtx2'] as num?)?.toDouble();
    ddgtx3 = (json['ddgtx3'] as num?)?.toDouble();
    ddgtx4 = (json['ddgtx4'] as num?)?.toDouble();
    ddgGk = (json['ddg_gk'] as num?)?.toDouble();
    ddgCk = (json['ddg_ck'] as num?)?.toDouble();
    dtbMhk = (json['dtb_mhk'] as num?)?.toDouble();
    academicYear = json['academic_year'];
    semester = json['semester'];
    fullName = json['full_name'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    return {
      'grade_id': gradeId,
      'student_id': studentId,
      'subject_id': subjectId,
      'class_id': classId,
      'ddgtx1': ddgtx1,
      'ddgtx2': ddgtx2,
      'ddgtx3': ddgtx3,
      'ddgtx4': ddgtx4,
      'ddg_gk': ddgGk,
      'ddg_ck': ddgCk,
      'dtb_mhk': dtbMhk,
      'academic_year': academicYear,
      'semester': semester,
      'full_name': fullName,
      'date_of_birth': dateOfBirth,
    };
  }

  GradeWithStudent copyWith({
    int? gradeId,
    int? studentId,
    int? subjectId,
    int? classId,
    double? ddgtx1,
    double? ddgtx2,
    double? ddgtx3,
    double? ddgtx4,
    double? ddgGk,
    double? ddgCk,
    double? dtbMhk,
    String? academicYear,
    String? semester,
    String? fullName,
    String? dateOfBirth,
  }) {
    return GradeWithStudent(
      gradeId: gradeId ?? this.gradeId,
      studentId: studentId ?? this.studentId,
      subjectId: subjectId ?? this.subjectId,
      classId: classId ?? this.classId,
      ddgtx1: ddgtx1 ?? this.ddgtx1,
      ddgtx2: ddgtx2 ?? this.ddgtx2,
      ddgtx3: ddgtx3 ?? this.ddgtx3,
      ddgtx4: ddgtx4 ?? this.ddgtx4,
      ddgGk: ddgGk ?? this.ddgGk,
      ddgCk: ddgCk ?? this.ddgCk,
      dtbMhk: dtbMhk ?? this.dtbMhk,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
