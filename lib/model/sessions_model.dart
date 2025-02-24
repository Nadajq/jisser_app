import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/model/users_model.dart';

class Sessions {
  final String sessionId;
  final String specialistId;
  final String userId;
  final String sessionDate;
  final String sessionTime;
  final String duration;
  bool active;

  Sessions({
    required this.sessionId,
    required this.specialistId,
    required this.userId,
    required this.sessionDate,
    required this.sessionTime,
    required this.duration,
    this.active = false, // Default value is false,
  });

  // Function to get specialist name based on their ID
  String getSpecialistName(List<Specialist> specialists) {
    final specialist = specialists.firstWhere((s) => s.id == specialistId,
        orElse: () => Specialist(
            id: '',
            name: 'غير متوفر',
            imageUrl: '',
            email: '',
            password: '',
            specialty: '',
            qualification: '',
            yearsOfExperience: '',
            rating: 0.0,
            sessionTimes: [],
            sessionDurations: []));
    return specialist.name;
  }

  // Function to get user name based on userId (you can implement this similarly)
  String getUserName(List<Users> users) {
    final user = users.firstWhere((u) => u.id == userId,
        orElse: () =>
            Users(id: '', name: 'غير متوفر', email: '', password: ''));
    return user.name;
  }
// Function to get specialist name from ID
/*String getSpecialistName(List<Specialist> specialistsInfo) {
    return specialistsInfo
        .firstWhere(
            (s) => s.id == specialistId,
        orElse: () =>
            Specialist(id: '',
                name: 'غير معروف',
                imageUrl: '',
                specialty: '',
                qualification: '',
                yearsOfExperience: '',
                sessionTimes: [],
                sessionDurations: [],
                email: '',
                password: '',
                rating: 0.0),
    )
        .name;
  }

  // Function to get user name from ID
  String getUserName(List<Users> usersList) {
    return usersList
        .firstWhere((u) => u.id == userId,
        orElse: () => Users(id: '', name: 'غير معروف', email: '', password: ''))
        .name;
  }*/
}

List<Sessions> sessionsList = [
  Sessions(
    sessionId: '1',
    specialistId: 'sp1',
    userId: '3',
    sessionDate: '2025-02-20',
    sessionTime: "5:00",
    duration: "30 د",
  ),
  Sessions(
    sessionId: 's2',
    specialistId: 'sp2',
    userId: '1',
    sessionDate: '2025-02-21',
    sessionTime: "6:00",
    duration: "1 ساعة",
  ),
  Sessions(
    sessionId: 's3',
    specialistId: 'sp3',
    userId: '5',
    sessionDate: '2025-02-22',
    sessionTime: "4:30",
    duration: "30 د",
  ),
  Sessions(
    sessionId: 's4',
    specialistId: 'sp4',
    userId: '6',
    sessionDate: '2025-02-22',
    sessionTime: "4:30",
    duration: "30 د",
  ),
];
