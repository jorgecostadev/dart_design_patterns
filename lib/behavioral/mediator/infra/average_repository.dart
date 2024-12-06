import 'package:design_patterns/behavioral/mediator/domain/average.dart';

abstract interface class AverageRepository {
  Future<Average> getByStudentId({required int studentId});

  Future<void> save({required Average average});
}

class AverageRepositoryMemory implements AverageRepository {
  final _averages = <Average>[];

  @override
  Future<Average> getByStudentId({required int studentId}) async {
    final averages = _averages.where((e) => e.studentId == studentId);
    return Average(studentId: averages.first.studentId, value: averages.first.value);
  }

  @override
  Future<void> save({required Average average}) async {
    _averages.removeWhere((e) => e.studentId == average.studentId);
    _averages.add(average);
  }
}
