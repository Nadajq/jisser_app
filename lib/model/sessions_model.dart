
class Sessions {
  final String sessionId;
  final String specialistname;
  final String userName;
  final String sessionDate;
  final String sessionTime;
  final String duration;
  final bool sessionState;
  final bool active;

  Sessions(
      {required this.sessionId,
      required this.specialistname,
      required this.userName,
      required this.sessionDate,
      required this.sessionTime,
      required this.duration,
        required this.active,
        this.sessionState = false,});
}
List<Sessions> sessionsList =[
  Sessions(
      sessionId: 's1',
      specialistname: "احمد", // The ID of the selected specialist,
      userName: 'محمد',
      sessionDate: '2025-02-20', // The date the user selects
      sessionTime:  "5:00", // The time the user selected
      duration: "30 د",
    active: true,// The selected duration
  ),
  Sessions(
    sessionId: 's1',
    specialistname: "احمد", // The ID of the selected specialist,
    userName: 'محمد',
    sessionDate: '2025-02-20', // The date the user selects
    sessionTime:  "5:00", // The time the user selected
    duration: "30 د",
    active: true,// The selected duration
  ),
  Sessions(
    sessionId: 's1',
    specialistname: "احمد", // The ID of the selected specialist,
    userName: 'محمد',
    sessionDate: '2025-02-20', // The date the user selects
    sessionTime:  "5:00", // The time the user selected
    duration: "30 د",
    active: false,// The selected duration
  ),
  Sessions(
    sessionId: 's1',
    specialistname: "احمد", // The ID of the selected specialist,
    userName: 'محمد',
    sessionDate: '2025-02-20', // The date the user selects
    sessionTime:  "5:00", // The time the user selected
    duration: "30 د",
    active: true,// The selected duration
  ),
  Sessions(
    sessionId: 's1',
    specialistname: "احمد", // The ID of the selected specialist,
    userName: 'محمد',
    sessionDate: '2025-02-20', // The date the user selects
    sessionTime:  "5:00", // The time the user selected
    duration: "30 د",
    active: true,// The selected duration
  ),
  Sessions(
    sessionId: 's1',
    specialistname: "احمد", // The ID of the selected specialist,
    userName: 'محمد',
    sessionDate: '2025-02-20', // The date the user selects
    sessionTime:  "5:00", // The time the user selected
    duration: "30 د",
    active: false,// The selected duration
  ),
  Sessions(
    sessionId: 's1',
    specialistname: "احمد", // The ID of the selected specialist,
    userName: 'محمد',
    sessionDate: '2025-02-20', // The date the user selects
    sessionTime:  "5:00", // The time the user selected
    duration: "30 د",
    active: false,// The selected duration
  ),
  Sessions(
    sessionId: 's1',
    specialistname: "احمد", // The ID of the selected specialist,
    userName: 'محمد',
    sessionDate: '2025-02-20', // The date the user selects
    sessionTime:  "5:00", // The time the user selected
    duration: "30 د",
    active: true,// The selected duration
  ),
];