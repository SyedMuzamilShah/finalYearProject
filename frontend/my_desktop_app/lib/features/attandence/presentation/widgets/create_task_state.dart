class CreateTaskState {
  String title = '';
  String description = '';
  DateTime? dueDate;
  List<Map<String, dynamic>> pdfFiles = [];
  Map<String, dynamic> location = {
    'type': 'Point',
    'coordinates': [0.0, 0.0],
    'address': '',
  };
  int aroundDistanceMeter = 1000;
  List<String> assignedEmployees = [];
  String organizationId = '680b90783e89bdee9eb7e458';
  String status = 'CREATED';

  // Optional helper methods if needed
  void clear() {
    title = '';
    description = '';
    dueDate = null;
    pdfFiles.clear();
    location = {
      'type': 'Point',
      'coordinates': [0.0, 0.0],
      'address': '',
    };
    aroundDistanceMeter = 1000;
    assignedEmployees.clear();
    status = 'CREATED';
  }
}
