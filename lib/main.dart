import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jisser_app/auth/auth_gate.dart';
import 'package:jisser_app/cubit/change_langauge_cubit.dart';
import 'package:jisser_app/view/logo_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'control/Stripe_keys.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //stripe setup
  Stripe.publishableKey = Publishablekey;
  await Stripe.instance.applySettings();
  //supabase setup
  await Supabase.initialize(
    url: "https://tzexpthdyjekssuvszjm.supabase.co",
    anonKey:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR6ZXhwdGhkeWpla3NzdXZzemptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEzNzc2NTQsImV4cCI6MjA1Njk1MzY1NH0.atSkq2E3bdY6bDXgsPzCCCyIt3IUMhUsNixoRT9zZdc",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeLangaugeCubit(),
      child: BlocBuilder<ChangeLangaugeCubit, ChangeLangaugeState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state is ChangeEnglish ? const Locale('en') : const Locale('ar'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const logoPage(
              child: AuthGate(),
            ),
          );
        },
      ),
    );
  }
}
