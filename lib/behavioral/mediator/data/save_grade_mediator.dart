import 'package:design_patterns/Grade.dart';
import 'package:design_patterns/behavioral/mediator/infra/grade_repository.dart';
import 'package:design_patterns/behavioral/mediator/infra/mediator.dart';

class SaveGradeMediator {
  final GradeRepository gradeRepository;
  final Mediator mediator;

  SaveGradeMediator({required this.gradeRepository, required this.mediator});

  Future<void> execute({required InputSaveGrade input}) async {
    final grade = Grade.create(studentId: input.studentId, exam: input.exam, value: input.value);
    await gradeRepository.save(grade: grade);
    await mediator.notify(eventName: 'gradeSaved', callbackData: (studentId: input.studentId));
  }
}

typedef InputSaveGrade = ({
  int studentId,
  String exam,
  double value,
});
