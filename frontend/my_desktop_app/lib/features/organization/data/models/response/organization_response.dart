import 'package:my_desktop_app/features/organization/domain/entities/organization_entities.dart';

class OrganizationResponseModel extends OrganizationEntities {
  OrganizationResponseModel({
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.website,
    required super.address,
    required super.createdBy,
    required super.id,
    required super.organizationId,
  });

  factory OrganizationResponseModel.fromJson(Map<String, dynamic> json) {
    return OrganizationResponseModel(
      name: json['name'] ?? '', // Provide default value if null
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      website: json['website'] ?? '',
      address: json['address'] ?? '',
      createdBy: json['createdBy'] ?? '',
      id: json['_id'] ?? '', // Use _id as id
      organizationId: json['organizationId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'website': website,
      'address': address,
      'createdBy': createdBy,
      '_id': id,
      'organizationId': organizationId,
    };
  }
}
