class Employee {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status; // 'active', 'blocked', 'pending'
  final String? profileImageUrl;
  final DateTime? lastActive;
  final String organizationId;
  final bool isVerified;
  final DateTime? createdAt;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    this.profileImageUrl,
    this.lastActive,
    required this.organizationId,
    required this.isVerified,
    this.createdAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
      profileImageUrl: json['profileImageUrl'],
      lastActive: json['lastActive'] != null ? DateTime.parse(json['lastActive']) : null,
      organizationId: json['organizationId'],
      isVerified: json['isVerified'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}