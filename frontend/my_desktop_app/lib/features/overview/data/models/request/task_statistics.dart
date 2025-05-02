class TaskStatisticsParams {
  final int? year;
  final String organizationId;
  TaskStatisticsParams({required this.organizationId, this.year});

  Map<String, dynamic> toJson () {
    return {
      'year' : year,
      'organizationId' : organizationId
    };
  }
}