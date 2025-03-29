import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisser_app/generated/l10n.dart';
import 'package:jisser_app/model/specialist_model.dart';
import 'package:jisser_app/model/users_model.dart';
import 'package:jisser_app/view/chat_page/view_model/cubit/rating_cubit.dart';
import 'package:jisser_app/view/user_home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RatingPage extends StatelessWidget {
  final Specialist specialist;
  final Users user;
  const RatingPage({super.key, required this.specialist, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingCubit, RatingState>(
      builder: (context, state) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/waiting_logo.png'),
                 Text(
                  textAlign: TextAlign.center,
                  S.of(context).please_rate_session,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 160, 207)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: BlocProvider.of<RatingCubit>(context)
                        .ratings
                        .map((e) => GestureDetector(
                              onTap: () {
                                BlocProvider.of<RatingCubit>(context)
                                    .setRating(e);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Flexible(
                                  child: Icon(
                                    BlocProvider.of<RatingCubit>(context)
                                                .rating >=
                                            e
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: BlocProvider.of<RatingCubit>(context)
                                                .rating >=
                                            e
                                        ? Colors.yellow
                                        : Colors.grey,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[500],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: const Size(double.infinity, 50),
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      final supabase = Supabase.instance.client;
                      final rating = BlocProvider.of<RatingCubit>(context).rating;
                  
                      try {
                        await supabase
                            .from('specialists')
                            .update({'rating': rating + 1}).eq('id', specialist.id);
                  
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserHomePage(
                                      user: user,
                                    )));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text(S.of(context).there_was_an_error_updating_rating),
                          ),
                        );
                      }
                    },
                    child:  Text(S.of(context).send),
                  ),
                )
              ],
            ),
          ),
        ));
      },
    );
  }
}
