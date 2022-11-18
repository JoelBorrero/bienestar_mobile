import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.role,
        required this.token,
    });

    final int id;
    final String email;
    final String firstName;
    final String lastName;
    final String role;
    final String token;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["user"]["id"],
        email: json["user"]["email"],
        firstName: json["user"]["first_name"],
        lastName: json["user"]["last_name"],
        role: json["user"]["role"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "role": role,
        "token": token,
    };
}
