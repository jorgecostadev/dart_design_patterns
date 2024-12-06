import 'package:design_patterns/behavioral/mediator/infra/average_repository.dart';
import 'package:design_patterns/behavioral/mediator/data/calculate_average.dart';
import 'package:design_patterns/behavioral/mediator/data/get_average.dart';
import 'package:design_patterns/behavioral/mediator/infra/grade_repository.dart';
import 'package:design_patterns/behavioral/mediator/infra/mediator.dart';
import 'package:design_patterns/behavioral/mediator/data/save_grade.dart';
import 'package:design_patterns/behavioral/mediator/data/save_grade_mediator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GetAverage getAverage;
  late CalculateAverage calculateAverage;
  late AverageRepository averageRepository;
  late GradeRepository gradeRepository;

  setUp(() {
    averageRepository = AverageRepositoryMemory();
    gradeRepository = GradeRepositoryMemory();
    calculateAverage = CalculateAverage(averageRepository: averageRepository, gradeRepository: gradeRepository);
    getAverage = GetAverage(averageRepository: averageRepository);
  });

  test('Deve salvar as notas do aluno e calcular a média', () async {
    final sut = SaveGrade(gradeRepository: gradeRepository, calculateAverage: calculateAverage);
    final studentId = DateTime.now().millisecondsSinceEpoch;
    final inputP1 = (studentId: studentId, exam: 'P1', value: 10.0);
    await sut.execute(input: inputP1);
    final inputP2 = (studentId: studentId, exam: 'P2', value: 9.0);
    await sut.execute(input: inputP2);
    final inputP3 = (studentId: studentId, exam: 'P3', value: 8.0);
    await sut.execute(input: inputP3);
    final outputGetAverage = await getAverage.execute(studentId: studentId);
    expect(outputGetAverage.value, equals(9));
  });

  test('Deve salvar as notas do aluno e calcular a média usando mediator', () async {
    final mediator = Mediator();
    mediator.register(
      eventName: 'gradeSaved',
      callback: (data) async => await calculateAverage.execute(studentId: data.studentId),
    );
    final sut = SaveGradeMediator(gradeRepository: gradeRepository, mediator: mediator);
    final studentId = DateTime.now().millisecondsSinceEpoch;
    final inputP1 = (studentId: studentId, exam: 'P1', value: 10.0);
    await sut.execute(input: inputP1);
    final inputP2 = (studentId: studentId, exam: 'P2', value: 9.0);
    await sut.execute(input: inputP2);
    final inputP3 = (studentId: studentId, exam: 'P3', value: 8.0);
    await sut.execute(input: inputP3);
    final outputGetAverage = await getAverage.execute(studentId: studentId);
    expect(outputGetAverage.value, equals(9));
  });
}
