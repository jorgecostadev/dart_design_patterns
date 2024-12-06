class Grade {
  final int id;
  final int studentId;
  final String exam;
  final double value;

  Grade({
    required this.id,
    required this.studentId,
    required this.exam,
    required this.value,
  });

  factory Grade.create({required int studentId, required String exam, required double value}) {
    final id = DateTime.now().millisecondsSinceEpoch;
    return Grade(
      id: id,
      studentId: studentId,
      exam: exam,
      value: value,
    );
  }
}
