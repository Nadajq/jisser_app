import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/auth/auth_service.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/view/specialist/booking_list_page.dart';
import 'package:jisser_app/view/user_login_page.dart';
import 'package:intl/intl.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SchedulePage extends StatefulWidget {
  final Specialist specialist;
  const SchedulePage({super.key, required this.specialist});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime? selectedDate;
  List<TimeOfDay?> selectedTimes = List.filled(3, null);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.indigo,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimes[index] ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.indigo,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Check if this time is already selected in another slot
      bool isDuplicate = false;
      for (int i = 0; i < selectedTimes.length; i++) {
        if (i != index &&
            selectedTimes[i] != null &&
            _compareTime(selectedTimes[i]!, picked) == 0) {
          isDuplicate = true;
          break;
        }
      }

      if (isDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).this_time_is_already_booked),
          ),
        );
      } else {
        setState(() {
          selectedTimes[index] = picked;
        });
      }
    }
  }

  int _compareTime(TimeOfDay t1, TimeOfDay t2) {
    final int t1Minutes = t1.hour * 60 + t1.minute;
    final int t2Minutes = t2.hour * 60 + t2.minute;
    return t1Minutes.compareTo(t2Minutes);
  }

  Future<void> _saveSchedule() async {
    if (selectedDate == null) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).please_select_date,
      );
      return;
    }

    bool hasAtLeastOneTime = false;
    print(hasAtLeastOneTime);
    List<String> formattedTimes = [];

    // Format selected times and check if at least one is selected
    for (TimeOfDay? time in selectedTimes) {
      if (time != null) {
        hasAtLeastOneTime = true;
        // Format time as string (e.g., "14:30")
        String formattedTime =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
        formattedTimes.add(formattedTime);
      }
    }

    if (formattedTimes.length != 3) {
      CustomSnackBar.snackBarwidget(
        context: context,
        color: Colors.red,
        text: S.of(context).you_must_select_3_different_times,
      );
      return;
    }

    try {
      // Format date as string (e.g., "2024-03-20")
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

      // Update the specialist's record in the database
      await Supabase.instance.client.from('specialists').update({
        'session_times': formattedTimes,
        'date': formattedDate,
      }).eq('id',
          widget.specialist.id); // Use the specialist's ID from the widget

      if (mounted) {
        CustomSnackBar.snackBarwidget(
          context: context,
          color: Colors.green,
          text: S.of(context).successfully_saved_schedule,
        );

        // Optionally navigate to booking list page or refresh the current page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BookingListPage(specialist: widget.specialist),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        if (e.toString().contains("Connection timed out")) {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).check_your_internet_connection,
          );
        } else {
          CustomSnackBar.snackBarwidget(
            context: context,
            color: Colors.red,
            text: S.of(context).there_was_an_error_saving_schedule,
          );
        }
        print('Error saving schedule: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLangaugeCubit, ChangeLangaugeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/jisserLogo.jpeg",
                  height: 30,
                )
              ],
            ),
            actions: [
              Container(
                padding: const EdgeInsets.all(7),
                child: PopupMenuButton<int>(
                  icon: const Icon(Icons.menu, color: Colors.blueAccent),
                  offset: const Offset(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: ListTile(
                        leading: const Icon(Icons.mail, color: Colors.blueAccent),
                        title: Column(
                          children: [
                            Text(S.of(context).contact_us,
                                style: const TextStyle(fontSize: 13)),
                            GestureDetector(
                              onTap: () async {
                                await Clipboard.setData(
                                    const ClipboardData(text: "jisser@gmail.com"));

                                CustomSnackBar.snackBarwidget(
                                    context: context,
                                    color: Colors.green,
                                    text: S.of(context).coping);
                              },
                              child: const Text("jisser@gmail.com",
                                  style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                        visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -2),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        title: Row(
                          children: [
                            const Icon(Icons.language,
                                color: Colors.blueAccent, size: 20),
                            const SizedBox(width: 5),
                            Text(S.of(context).change_language,
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        onTap: () {
                          BlocProvider.of<ChangeLangaugeCubit>(context)
                              .changeLangauge();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: ListTile(
                        title: Row(
                          children: [
                            const Icon(Icons.exit_to_app,
                                color: Color(0xfff90606), size: 20),
                            const SizedBox(width: 5),
                            Text(S.of(context).logout,
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        onTap: () {
                          AuthService().signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserLoginPage()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    S.of(context).time_table,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF08174A),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Date Picker
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      selectedDate == null
                          ? S.of(context).choose_date
                          : '${S.of(context).date}: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Three Time Slots
                ...List.generate(
                    3,
                        (index) => Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () => _selectTime(context, index),
                            child: Text(
                              selectedTimes[index] == null
                                  ? '${S.of(context).choose_time} ${index + 1}'
                                  : '${S.of(context).time} ${index + 1}: ${selectedTimes[index]!.format(context)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )),

                const SizedBox(height: 20),

                // Save Button
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: _saveSchedule,
                    child: Text(
                      S.of(context).save,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SchedulePage(
                            specialist: widget.specialist,
                          )),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        color: const Color(0xFF08174A),
                        "assets/table1.png",
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        S.of(context).time_table,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF08174A),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookingListPage(specialist: widget.specialist)),
                    );
                  },
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.asset(
                          color: const Color(0xFF08174A),
                          "assets/table2.png",
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Text(
                        S.of(context).booking_list,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF08174A),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
