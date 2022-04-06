class Person {
  final String firstName;
  final String lastName;
  final String message;
  final String id;

  Person({
    required this.firstName,
    required this.lastName,
    required this.message,
    required this.id,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        firstName: json['first_name'],
        lastName: json['last_name'],
        message: json['message'],
        id: json['id'],
      );
}
