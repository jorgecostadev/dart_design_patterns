import 'package:design_patterns/Grade.dart';
import 'package:design_patterns/behavioral/mediator/data/calculate_average.dart';
import 'package:design_patterns/behavioral/mediator/infra/grade_repository.dart';

class SaveGrade {
  final GradeRepository gradeRepository;
  final CalculateAverage calculateAverage;

  SaveGrade({required this.calculateAverage, required this.gradeRepository});

  Future<void> execute({required InputSaveGrade input}) async {
    final grade = Grade.create(studentId: input.studentId, exam: input.exam, value: input.value);
    await gradeRepository.save(grade: grade);
    await calculateAverage.execute(studentId: input.studentId);
  }
}

typedef InputSaveGrade = ({
  int studentId,
  String exam,
  double value,
});
