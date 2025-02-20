class Users {
  final String id;
  final String name;
  final String email;
  final String password;

  Users(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});
}

List<Users> usersList = [
  Users(
      id: '1',
      name: 'سارة',
      email: "sara@gmail.com",
      password: 's1234',
  ),
  Users(
    id: '2',
    name: 'ريم',
    email: "reem@gmail.com",
    password: 'r1234',
  ),
  Users(
    id: '3',
    name: 'محمد',
    email: "moh@gmail.com",
    password: 'm1234',
  ),
  Users(
    id: '4',
    name: 'مها',
    email: "maha@gmail.com",
    password: 'ma123',
  ),
  Users(
    id: '5',
    name: 'عبدالله',
    email: "ab@gmail.com",
    password: 'a1234',
  ),
  Users(
    id: '6',
    name: 'عبدالعزيز',
    email: "az@gmail.com",
    password: 'az1234',
  ),
  Users(
    id: '7',
    name: 'يوسف',
    email: "y1@gmail.com",
    password: 'y1234',
  ),
  Users(
    id: '8',
    name: 'احمد',
    email: "ahmad@gmail.com",
    password: 'a111',
  ),
];
