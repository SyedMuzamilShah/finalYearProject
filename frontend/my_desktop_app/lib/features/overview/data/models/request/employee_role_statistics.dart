class EmployeeRoleStatisticsParams {
  final String organizationId;

  EmployeeRoleStatisticsParams({required this.organizationId});

  Map<String, dynamic> toJson () {
    return {
      'organizationId' : organizationId
    };
  }
}