
class Sessions {
  final String sessionId;
  final String specialistId;
  final String userNameId;
  final String sessionDate;
  final String sessionTime;
  final String duration;
  final bool sessionState;

  Sessions(
      {required this.sessionId,
      required this.specialistId,
      required this.userNameId,
      required this.sessionDate,
      required this.sessionTime,
      required this.duration,
        this.sessionState = false,});
}
List<Sessions> sessionsList =[
  Sessions(
      sessionId: 's1',
      specialistId: "widget.specialist.id", // The ID of the selected specialist,
      userNameId: 'userId',
      sessionDate: '2025-02-20', // The date the user selects
      sessionTime:  "_selectedTime!", // The time the user selected
      duration: "_selectedDuration!", // The selected duration
  ),
];