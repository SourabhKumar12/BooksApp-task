class LeadModel {
  final String name;
  final String email;

  LeadModel({required this.name, required this.email});

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      name: json['firstName'] + json['lastName'],
      email: json['email'],
    );
  }
}
