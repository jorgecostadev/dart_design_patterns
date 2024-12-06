import 'package:design_patterns/behavioral/mediator/domain/average.dart';
import 'package:design_patterns/behavioral/mediator/infra/average_repository.dart';

class GetAverage {
  final AverageRepository averageRepository;

  GetAverage({required this.averageRepository});

  Future<Average> execute({required int studentId}) async {
    return averageRepository.getByStudentId(studentId: studentId);
  }
}