import 'package:design_patterns/behavioral/mediator/domain/average.dart';
import 'package:design_patterns/behavioral/mediator/infra/average_repository.dart';
import 'package:design_patterns/behavioral/mediator/infra/grade_repository.dart';

class CalculateAverage {
  final AverageRepository averageRepository;
  final GradeRepository gradeRepository;

  CalculateAverage({required this.averageRepository, required this.gradeRepository});

  Future<void> execute({required int studentId}) async {
    final grades = await gradeRepository.getByStudentId(studentId: studentId);
    final total = grades.fold(0.0, (previous, grade) => previous += grade.value);
    final value = total / grades.length;
    final average = Average(studentId: studentId, value: value);
    await averageRepository.save(average: average);
  }
}
