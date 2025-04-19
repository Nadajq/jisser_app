import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/auth/auth_service.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/sessions_model.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/model/users_model.dart';
import 'package:jisser_app/view/chat_page/chat_page.dart';
import 'package:jisser_app/view/specialist/schedule_page.dart';
import 'package:jisser_app/view/specialist/specialist_login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingListPage extends StatefulWidget {
  final Specialist specialist;
  const BookingListPage({super.key, required this.specialist});

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  final _supabase = Supabase.instance.client;
  List<Sessions> sessions = [];
  List<Users> users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      final response = await _supabase
          .from('sessions')
          .select('''
            *,
            userrs!user_id (
              id,
              name,
              email
            )
          ''')
          .eq('specialist_id', widget.specialist.id)
          .order('session_date', ascending: false)
          .order('session_time', ascending: true);

      List<Sessions> sessionsList = [];
      List<Users> usersList = [];

      for (var data in response) {
        final userData = data['userrs'] as Map<String, dynamic>;
        Users user = Users(
          id: userData['id']?.toString() ?? '',
          name: userData['name']?.toString() ?? 'Unknown User',
          email: userData['email']?.toString() ?? '',
          password: '',
        );
        usersList.add(user);

        Sessions session = Sessions(
          sessionId: data['id']?.toString() ?? '',
          specialistId: data['specialist_id']?.toString() ?? '',
          userId: data['user_id']?.toString() ?? '',
          sessionDate: data['session_date'] ?? '',
          sessionTime: data['session_time'] ?? '',
          duration: data['duration'] ?? '',
          active: data['active'] ?? false,
          chatId: data['chat_id']?.toString(),
        );

        sessionsList.add(session);
      }

      setState(() {
        sessions = sessionsList;
        users = usersList;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading bookings: $e');
      setState(() => _isLoading = false);
    }
  }

  showDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(S.of(context).confirm_delete),
            content:
            Text(S.of(context).are_sure_you_want_to_delete_the_account),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).cancel),
              ),
              TextButton(
                onPressed: () async {
                  await Supabase.instance.client
                      .from('specialists')
                      .delete()
                      .eq('id', widget.specialist.id);
                  AuthService().signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const SpecialistLoginPage()));
                },
                child: Text(S.of(context).delete,
                    style: const TextStyle(color: Colors.red)),
              ),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLangaugeCubit, ChangeLangaugeState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset("assets/jisserLogo.jpeg", height: 30)],
              ),
              actions: [
                Container(
                  padding: const EdgeInsets.all(7),
                  child: PopupMenuButton<int>(
                    icon: const Icon(Icons.menu, color: Colors.blueAccent),
                    offset: const Offset(0, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: ListTile(
                          trailing:
                          const Icon(Icons.mail, color: Colors.blueAccent),
                          title: const Text("jisser@gmail.com",
                              style: TextStyle(fontSize: 13)),
                          visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -2),
                          onTap: () => Navigator.pop(context),
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
                            textDirection: TextDirection.rtl,
                            children: [
                              const Icon(Icons.exit_to_app,
                                  color: Colors.red, size: 20),
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
                                    builder: (context) =>
                                    const SpecialistLoginPage()));
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 3,
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
                            showDialogBox(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              elevation: 0.0,
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    S.of(context).list_of_customer_bookings,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color(0xFF08174A)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                    padding: const EdgeInsets.all(4),
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(S.of(context).client_name),
                        Text(S.of(context).session_duration),
                        Text(S.of(context).session_time),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : sessions.isEmpty
                        ? Center(
                        child: Text(
                          S.of(context).there_is_no_booking,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xFF08174A),
                          ),
                        ))
                        : ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.withOpacity(0.8),
                          thickness: 4,
                          height: 5,
                          endIndent: 25,
                          indent: 25,
                        );
                      },
                      itemCount: sessions.length,
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        final user = users[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    user: user,
                                    specialist: widget.specialist,
                                    session: session,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                    width: 70,
                                    height: 70,
                                    'assets/user.png'),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(user.name),
                                      Text(session.duration),
                                      Text(session.sessionTime),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                          builder: (context) =>
                              SchedulePage(specialist: widget.specialist),
                        ),
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
                              color: Color(0xFF08174A)),
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
                              BookingListPage(specialist: widget.specialist),
                        ),
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
                              color: Color(0xFF08174A)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
