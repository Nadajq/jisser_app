import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/sessions_model.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/model/users_model.dart';
import 'package:jisser_app/view/chat_page/rating_page.dart';
import 'package:jisser_app/view/chat_page/view_model/cubit/rating_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatefulWidget {
  final Users user;
  final Specialist specialist;
  final Sessions session;

  const ChatPage({
    super.key,
    required this.user,
    required this.specialist,
    required this.session,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _supabase = Supabase.instance.client;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isSpecialistView = false;
  late Stream<List<Map<String, dynamic>>> _messagesStream;

  @override
  void initState() {
    super.initState();
    isSpecialistView = _supabase.auth.currentUser?.id == widget.specialist.id;
    _initializeChat();
  }

  void _initializeChat() {
    try {
      print('Initializing chat for session: ${widget.session.sessionId}');

      // Enable real-time subscription for the messages table
      _messagesStream = _supabase
          .from('messages')
          .stream(primaryKey: ['id'])
          .eq('session_id', widget.session.sessionId)
          .order('date', ascending: false)
          .map((events) {
            print('Received messages: ${events.length}');
            return events;
          });
    } catch (e) {
      print('Chat initialization error: $e');
      _messagesStream = Stream.value([]);
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    try {
      final message = {
        'session_id': widget.session.sessionId,
        'sender_id': isSpecialistView ? widget.specialist.id : widget.user.id,
        'message': _messageController.text.trim(),
        'date': DateTime.now().toIso8601String(),
        'session_time': widget.session.sessionTime,
        'session_duration': widget.session.duration,
      };

      print('Sending message: $message');

      await _supabase.from('messages').insert(message);
      _messageController.clear();

      await Future.delayed(const Duration(milliseconds: 100));
      _scrollToBottom();
    } catch (e) {
      print('Error sending message: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().contains('Invalid session ID')
                  ? 'خطأ في معرف الجلسة'
                  : 'حدث خطأ في إرسال الرسالة',
            ),
          ),
        );
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ChatAppBar(
            sessions: widget.session,
            user: widget.user,
            specialist: widget.specialist,
            userName:
                isSpecialistView ? widget.user.name : widget.specialist.name,
            imageUrl:
                isSpecialistView ? "" : (widget.specialist.imageUrl ?? ""),
            isSpecialistView: isSpecialistView,
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data ?? [];

                if (messages.isEmpty) {
                  return Center(
                    child: Text(S.of(context).there_is_no_messages),
                  );
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController
                        .jumpTo(_scrollController.position.minScrollExtent);
                  }
                });
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.only(bottom: 3),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isCurrentUserMessage = isSpecialistView
                        ? message['sender_id'] == widget.specialist.id
                        : message['sender_id'] == widget.user.id;

                    return MessageBubble(
                      message: message['message'],
                      isCurrentUser: isCurrentUserMessage,
                      senderName: isCurrentUserMessage
                          ? (isSpecialistView
                              ? widget.specialist.name
                              : widget.user.name)
                          : (isSpecialistView
                              ? widget.user.name
                              : widget.specialist.name),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: S.of(context).writing_a_message,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    textDirection: TextDirection.rtl,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xffA3C7EB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatAppBar extends StatelessWidget {
  final String userName;
  final String imageUrl;
  final bool isSpecialistView;
  final Specialist specialist;
  final Users user;
  final Sessions sessions;

  const ChatAppBar({
    super.key,
    required this.userName,
    required this.imageUrl,
    required this.isSpecialistView,
    required this.specialist,
    required this.user,
    required this.sessions,
  });

  Future<void> _deactivateSession(
      Sessions sessionId, BuildContext context) async {
    try {
      // Update the session in Supabase
      await Supabase.instance.client
          .from('sessions')
          .update({'active': false}).eq('id', sessionId.sessionId);

      // Refresh the data
      // await _fetchData();

      // Show a success message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('تم تعطيل الجلسة بنجاح')),
      // );
    } catch (e) {
      // Show an error message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('فشل في تعطيل الجلسة: $e')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
      width: double.infinity,
      height: 120,
      decoration: const BoxDecoration(
        color: Color(0xffE9EEF1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (imageUrl.isNotEmpty) {
                _deactivateSession(sessions, context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => RatingCubit(),
                              child: RatingPage(
                                specialist: specialist,
                                user: user,
                              ),
                            )));
              } else {
                Navigator.pop(context);
              }
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.blue[400],
              size: 40,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              CircleAvatar(
                radius: 30,
                backgroundImage: isSpecialistView || imageUrl.isEmpty
                    ? const AssetImage('assets/user.png') as ImageProvider
                    : NetworkImage(imageUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String senderName;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
            minWidth: MediaQuery.of(context).size.width * 0.1,
          ),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isCurrentUser
                ? const Color(0xffE9EEF1)
                : const Color(0xffA3C7EB),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(35),
              topRight: const Radius.circular(35),
              bottomLeft: Radius.circular(isCurrentUser ? 35 : 0),
              bottomRight: Radius.circular(isCurrentUser ? 0 : 35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                senderName,
                textAlign: isCurrentUser ? TextAlign.end : TextAlign.start,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
