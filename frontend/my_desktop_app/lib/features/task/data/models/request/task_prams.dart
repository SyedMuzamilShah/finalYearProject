import 'package:latlong2/latlong.dart';

class TaskCreateParams {
  final String title;
  final String description;
  final DateTime dueDate;
  final String organizationId;
  final LocationModel? location;

  TaskCreateParams(
      {required this.title, required this.organizationId ,required this.description, required this.dueDate, this.location});

  toJson() {
    return {
      'title': title,
      'description': description,
      'organizationId': organizationId,
      'dueDate': dueDate.toIso8601String(),
      'location': location?.toJson()
    };
  }
}
class LocationModel {
  final num latitude;
  final num longitude;
  final String? address;

  LocationModel({required this.latitude, required this.longitude, this.address = 'Address'});

  Map<String, dynamic> toJson() {
    return {
      'type': 'Point',
      'coordinates': [longitude, latitude]};
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final coords = json['coordinates'] as List;
    return LocationModel(
      longitude: coords[0],
      latitude: coords[1],
      address: json['address']
    );
  }

  LatLng toLatLng() => LatLng(latitude.toDouble(), longitude.toDouble());
}


class TaskUpdateParams {
  toJson() {
    return {};
  }
}

class TaskDeleteParams {
  final String id;

  TaskDeleteParams({required this.id});
  toJson() {
    return {'id': id};
  }
}

class TaskReadParams {
  final String? organizationId;
  final String? adminId;
  final String? status;
  final String? search;
  final DateTime? dueDate;
  final int? page;
  final int? limit;
  final String? sort;

  TaskReadParams({
    this.organizationId,
    this.adminId,
    this.status,
    this.search,
    this.dueDate,
    this.page,
    this.limit,
    this.sort,
  });

  TaskReadParams copyWith({
    String? organizationId,
    String? adminId,
    String? status,
    String? search,
    DateTime? dueDate,
    int? page,
    int? limit,
    String? sort,
  }) {
    return TaskReadParams(
      organizationId: organizationId ?? this.organizationId,
      adminId: adminId ?? this.adminId,
      status: status ?? this.status,
      search: search ?? this.search,
      dueDate: dueDate ?? this.dueDate,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (organizationId != null) data['organizationId'] = organizationId;
    if (adminId != null) data['adminId'] = adminId;
    if (status != null) data['status'] = status;
    if (search != null) data['search'] = search;
    if (dueDate != null) data['dueDate'] = dueDate!.toIso8601String();
    if (page != null) data['page'] = page;
    if (limit != null) data['limit'] = limit;
    if (sort != null) data['sort'] = sort;

    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskReadParams &&
        other.organizationId == organizationId &&
        other.adminId == adminId &&
        other.status == status &&
        other.search == search &&
        other.dueDate == dueDate &&
        other.page == page &&
        other.limit == limit &&
        other.sort == sort;
  }

  @override
  int get hashCode {
    return Object.hash(
      organizationId,
      adminId,
      status,
      search,
      dueDate,
      page,
      limit,
      sort,
    );
  }
}
