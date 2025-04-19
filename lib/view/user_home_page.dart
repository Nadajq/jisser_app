import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/auth/auth_service.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/users_model.dart';
import 'package:jisser_app/services/blogs_service.dart';
import 'package:jisser_app/view/blog_info_page.dart';
import 'package:jisser_app/view/specialist_info_page.dart';
import 'package:jisser_app/view/center_info_page.dart';
import 'package:jisser_app/model/blogs_model.dart';
import 'package:jisser_app/model/center_model.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/services/center_service.dart';
import 'package:jisser_app/services/specialist_service.dart';
import 'package:jisser_app/view/user_login_page.dart';
import 'package:jisser_app/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserHomePage extends StatefulWidget {
  final Users user;
  const UserHomePage({super.key, required this.user});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CenterService _centerService = CenterService();
  final SpecialistService _specialistService = SpecialistService();
  final BlogService _blogService = BlogService(); // Add BlogService

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocBuilder<ChangeLangaugeCubit, ChangeLangaugeState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
                    textDirection: TextDirection.rtl,
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
                            builder: (context) => const UserLoginPage()));
                    Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: ListTile(
                  title: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Icon(Icons.delete,
                          color: Color(0xfff90606), size: 20),
                      const SizedBox(width: 5),
                      Text(S.of(context).delete_account,
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
    );
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
                  try {
                    final sessionsResponse = await Supabase.instance.client
                        .from('sessions')
                        .select('id')
                        .eq('user_id', widget.user.id);
                    final sessionIds = sessionsResponse
                        .map((session) => session['id'])
                        .toList();

                    if (sessionIds.isNotEmpty) {
                      await Supabase.instance.client
                          .from('messages')
                          .delete()
                          .inFilter('session_id', sessionIds);
                    }

                    await Supabase.instance.client
                        .from('sessions')
                        .delete()
                        .eq('user_id', widget.user.id);

                    await Supabase.instance.client
                        .from('userrs')
                        .delete()
                        .eq('id', widget.user.id);

                    AuthService().signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserLoginPage()));
                  } catch (e) {
                    print("Error deleting user: $e");
                  }
                },
                child: Text(S.of(context).delete,
                    style: const TextStyle(color: Colors.red)),
              ),
            ]));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildCentersSection(),
          _buildSpecialistsSection(),
          _buildBlogsSection(), // Updated to fetch blogs from Supabase
        ],
      ),
    );
  }

  Widget _buildCentersSection() {
    return StreamBuilder<List<Centers>>(
      stream: _centerService.getCentersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SizedBox());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No centers available.'));
        } else {
          final centers = snapshot.data!;
          return Column(
            children: [
              const SizedBox(height: 10),
              Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: centers.length,
                    itemBuilder: (context, index) {
                      var center = centers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CenterInfoPage(centers: center),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _buildCenterCard(center),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildCenterCard(Centers center) {
    String url = center.imagePath;
    String fixedUrl = url.replaceFirst("https:/", "https://");
    return Container(
      width: 145,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black26),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: fixedUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 19),
          Align(
            alignment: Alignment.centerRight,
            child: Text(center.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF08174A))),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 17),
              Text(center.location,
                  style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialistsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 20),
        Text(S.of(context).specialists,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF08174A)),
            textAlign: TextAlign.right),
        const SizedBox(height: 10),
        StreamBuilder<List<Specialist>>(
          stream: _specialistService.getSpecialistsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: SizedBox());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(S.of(context).no_specialists_available));
            } else {
              final specialists = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: specialists.map((specialist) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SpecialistInfoPage(
                              specialist: specialist,
                              users: widget.user,
                            ),
                          ),
                        );
                      },
                      child: _buildSpecialistCard(specialist),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildSpecialistCard(Specialist specialist) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: specialist.imageUrl,
                height: 100,
                width: 100,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(specialist.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(specialist.specialty,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          specialist.rating != null
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 14),
              Text("${specialist.rating}.0",
                  style: const TextStyle(fontSize: 12)),
            ],
          )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildBlogsSection() {
    return StreamBuilder<List<Blogs>>(
      stream: _blogService.getBlogsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(S.of(context).no_blogs_available));
        } else {
          final blogs = snapshot.data!;
          return Column(
            children: blogs.map((blog) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogInfoPage(blogs: blog),
                    ),
                  );
                },
                child: _buildInfoCard(blog),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildInfoCard(Blogs blog) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        color: blog.bgcolor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 3,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(blog.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17),
                textAlign: TextAlign.right),
          ),
          const SizedBox(width: 10),
          Image.asset("assets/puzzle.png", height: 50, width: 50),
        ],
      ),
    );
  }
}
