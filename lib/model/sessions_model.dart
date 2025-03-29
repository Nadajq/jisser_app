import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/model/users_model.dart';

class Sessions {
  final String sessionId;
  final String specialistId;
  final String userId;
  final String sessionDate;
  final String sessionTime;
  final String duration;
  final bool active;
  final String? chatId; // Make it optional

  Sessions({
    required this.sessionId,
    required this.specialistId,
    required this.userId,
    required this.sessionDate,
    required this.sessionTime,
    required this.duration,
    required this.active,
    this.chatId,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) {
    return Sessions(
      sessionId: json['id'].toString(),
      specialistId: json['specialist_id'].toString(),
      userId: json['user_id'].toString(),
      sessionDate: json['session_date'],
      sessionTime: json['session_time'],
      duration: json['duration'],
      active: json['active'] ?? false,
      chatId: json['chat_id']?.toString(),
    );
  }

  String getSpecialistName(List<Specialist> specialists) {
    final specialist = specialists.firstWhere(
          (s) => s.id == specialistId,
      orElse: () => Specialist(
          id: '',
          name: 'Unknown',
          specialty: '',
          imageUrl: '',
          pdfUrl: '',
          email: '',
          qualification: '',
          yearsOfExperience: '',
          rating: 0,
          sessionTimes: [],
          date: '',
          sessionDurations: []),
    );
    return specialist.name;
  }

  String getUserName(List<Users> users) {
    final user = users.firstWhere(
          (u) => u.id == userId,
      orElse: () => Users(id: '', name: 'Unknown', email: '', password: ''),
    );
    return user.name;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': sessionId,
      'specialist_id': specialistId,
      'user_id': userId,
      'session_date': sessionDate,
      'session_time': sessionTime,
      'duration': duration,
      'active': active,
      'chat_id': chatId,
    };
  }
}

//   // Function to get specialist name based on their ID
//   String getSpecialistName(List<Specialist> specialists) {
//     final specialist = specialists.firstWhere((s) => s.id == specialistId,
//         orElse: () => Specialist(
//             id: '',
//             name: 'غير متوفر',
//             imageUrl: '',
//             pdfUrl: '',
//             email: '',
//             specialty: '',
//             qualification: '',
//             yearsOfExperience: '',
//             rating: 0,
//             sessionTimes: [],
//             date: '',
//             sessionDurations: []));
//     return specialist.name;
//   }

//   // Function to get user name based on userId (you can implement this similarly)
//   String getUserName(List<Users> users) {
//     final user = users.firstWhere((u) => u.id == userId,
//         orElse: () =>
//             Users(id: '', name: 'غير متوفر', email: '', password: ''));
//     return user.name;
//   }

// }

// List<Sessions> sessionsList = [
//   Sessions(
//     sessionId: '1',
//     specialistId: 'sp1',
//     userId: '3',
//     sessionDate: '2025-02-20',
//     sessionTime: "5:00",
//     duration: "30 د",
//   ),
//   Sessions(
//     sessionId: 's2',
//     specialistId: 'sp2',
//     userId: '1',
//     sessionDate: '2025-02-21',
//     sessionTime: "6:00",
//     duration: "1 ساعة",
//   ),
//   Sessions(
//     sessionId: 's3',
//     specialistId: 'sp3',
//     userId: '5',
//     sessionDate: '2025-02-22',
//     sessionTime: "4:30",
//     duration: "30 د",
//   ),
//   Sessions(
//     sessionId: 's4',
//     specialistId: 'sp4',
//     userId: '6',
//     sessionDate: '2025-02-22',
//     sessionTime: "4:30",
//     duration: "30 د",
//   ),
// ];
