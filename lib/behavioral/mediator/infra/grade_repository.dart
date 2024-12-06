import 'package:design_patterns/Grade.dart';

abstract interface class GradeRepository {
  Future<List<Grade>> getByStudentId({required int studentId});

  Future<void> save({required Grade grade});
}

class GradeRepositoryMemory implements GradeRepository {
  final _grades = <Grade>[];

  @override
  Future<List<Grade>> getByStudentId({required int studentId}) async {
    return _grades.where((e) => e.studentId == studentId).toList();
  }

  @override
  Future<void> save({required Grade grade}) async {
    _grades.add(grade);
  }
}
