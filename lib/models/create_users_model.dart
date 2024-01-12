class CreateUserModel {
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;

  CreateUserModel({
    required this.email, 
    required this.password, 
    this.name = "", 
    this.role = "", 
    this.avatar = "https://picsum.photos/800",
    });
  
}