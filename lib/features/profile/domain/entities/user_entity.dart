class UserEntity {
  final String email;
  final String? firstname;
  final String? lastname;
  final String age;
  final String? fcmToken;

  UserEntity(this.lastname, this.age,this.firstname, {
    required this.email,
    this.fcmToken,
  });
}