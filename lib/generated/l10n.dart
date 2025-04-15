// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `jisser`
  String get jisser {
    return Intl.message('jisser', name: 'jisser', desc: '', args: []);
  }

  /// `login`
  String get login_in {
    return Intl.message('login', name: 'login_in', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `password`
  String get password {
    return Intl.message('password', name: 'password', desc: '', args: []);
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `You don't have an account?`
  String get you_dont_have_an_account {
    return Intl.message(
      'You don\'t have an account?',
      name: 'you_dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Created account`
  String get create_account {
    return Intl.message(
      'Created account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Login as Specialist`
  String get login_as_specialist {
    return Intl.message(
      'Login as Specialist',
      name: 'login_as_specialist',
      desc: '',
      args: [],
    );
  }

  /// `Login as Admin`
  String get login_as_admin {
    return Intl.message(
      'Login as Admin',
      name: 'login_as_admin',
      desc: '',
      args: [],
    );
  }

  /// `there was an error, try again later`
  String get there_was_an_error_try_again_later {
    return Intl.message(
      'there was an error, try again later',
      name: 'there_was_an_error_try_again_later',
      desc: '',
      args: [],
    );
  }

  /// `check your internet connection`
  String get check_your_internet_connection {
    return Intl.message(
      'check your internet connection',
      name: 'check_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `your email or password is incorrect`
  String get your_email_or_password_is_incorrect {
    return Intl.message(
      'your email or password is incorrect',
      name: 'your_email_or_password_is_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `this email is not registered`
  String get thsi_email_is_not_registered {
    return Intl.message(
      'this email is not registered',
      name: 'thsi_email_is_not_registered',
      desc: '',
      args: [],
    );
  }

  /// `login successfully`
  String get login_successfully {
    return Intl.message(
      'login successfully',
      name: 'login_successfully',
      desc: '',
      args: [],
    );
  }

  /// `please enter password`
  String get please_enter_password {
    return Intl.message(
      'please enter password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `please enter email`
  String get please_enter_email {
    return Intl.message(
      'please enter email',
      name: 'please_enter_email',
      desc: '',
      args: [],
    );
  }

  /// `please enter username`
  String get please_enter_username {
    return Intl.message(
      'please enter username',
      name: 'please_enter_username',
      desc: '',
      args: [],
    );
  }

  /// `please enter confirm password`
  String get please_enter_confirm_password {
    return Intl.message(
      'please enter confirm password',
      name: 'please_enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `the password does not match`
  String get the_password_does_not_match {
    return Intl.message(
      'the password does not match',
      name: 'the_password_does_not_match',
      desc: '',
      args: [],
    );
  }

  /// `change language`
  String get change_language {
    return Intl.message(
      'change language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get create_new_account {
    return Intl.message(
      'Create account',
      name: 'create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `user name`
  String get user_name {
    return Intl.message('user name', name: 'user_name', desc: '', args: []);
  }

  /// `You don't have an account in jisser?`
  String get you_dont_have_an_account_in_jisser {
    return Intl.message(
      'You don\'t have an account in jisser?',
      name: 'you_dont_have_an_account_in_jisser',
      desc: '',
      args: [],
    );
  }

  /// `this email is not registered as specialist`
  String get this_email_is_not_registered_as_specialist {
    return Intl.message(
      'this email is not registered as specialist',
      name: 'this_email_is_not_registered_as_specialist',
      desc: '',
      args: [],
    );
  }

  /// `Create specialist account`
  String get create_specialist_account {
    return Intl.message(
      'Create specialist account',
      name: 'create_specialist_account',
      desc: '',
      args: [],
    );
  }

  /// `there was an error selecting file`
  String get there_was_an_error_selecting_file {
    return Intl.message(
      'there was an error selecting file',
      name: 'there_was_an_error_selecting_file',
      desc: '',
      args: [],
    );
  }

  /// `there was an error selecting image`
  String get there_was_an_error_selecting_image {
    return Intl.message(
      'there was an error selecting image',
      name: 'there_was_an_error_selecting_image',
      desc: '',
      args: [],
    );
  }

  /// `please select specialization`
  String get please_select_specialization {
    return Intl.message(
      'please select specialization',
      name: 'please_select_specialization',
      desc: '',
      args: [],
    );
  }

  /// `please select qualification`
  String get please_select_qualification {
    return Intl.message(
      'please select qualification',
      name: 'please_select_qualification',
      desc: '',
      args: [],
    );
  }

  /// `please enter experience`
  String get please_enter_experience {
    return Intl.message(
      'please enter experience',
      name: 'please_enter_experience',
      desc: '',
      args: [],
    );
  }

  /// `please upload personal file`
  String get please_upload_personal_file {
    return Intl.message(
      'please upload personal file',
      name: 'please_upload_personal_file',
      desc: '',
      args: [],
    );
  }

  /// `please upload personal image`
  String get please_upload_personal_image {
    return Intl.message(
      'please upload personal image',
      name: 'please_upload_personal_image',
      desc: '',
      args: [],
    );
  }

  /// `this email is already registered`
  String get this_email_is_already_registered {
    return Intl.message(
      'this email is already registered',
      name: 'this_email_is_already_registered',
      desc: '',
      args: [],
    );
  }

  /// `specialization`
  String get specialization {
    return Intl.message(
      'specialization',
      name: 'specialization',
      desc: '',
      args: [],
    );
  }

  /// `qualification`
  String get qualification {
    return Intl.message(
      'qualification',
      name: 'qualification',
      desc: '',
      args: [],
    );
  }

  /// `years of experience`
  String get years_of_experience {
    return Intl.message(
      'years of experience',
      name: 'years_of_experience',
      desc: '',
      args: [],
    );
  }

  /// `upload personal file`
  String get upload_personal_file {
    return Intl.message(
      'upload personal file',
      name: 'upload_personal_file',
      desc: '',
      args: [],
    );
  }

  /// `upload personal image`
  String get upload_personal_image {
    return Intl.message(
      'upload personal image',
      name: 'upload_personal_image',
      desc: '',
      args: [],
    );
  }

  /// `specialists`
  String get specialists {
    return Intl.message('specialists', name: 'specialists', desc: '', args: []);
  }

  /// `No specialists available.`
  String get no_specialists_available {
    return Intl.message(
      'No specialists available.',
      name: 'no_specialists_available',
      desc: '',
      args: [],
    );
  }

  /// `No blogs available.`
  String get no_blogs_available {
    return Intl.message(
      'No blogs available.',
      name: 'no_blogs_available',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message('logout', name: 'logout', desc: '', args: []);
  }

  /// `please select time and duration`
  String get please_select_time_and_duration {
    return Intl.message(
      'please select time and duration',
      name: 'please_select_time_and_duration',
      desc: '',
      args: [],
    );
  }

  /// `the session has been booked successfully!`
  String get the_session_has_been_booked_successfully {
    return Intl.message(
      'the session has been booked successfully!',
      name: 'the_session_has_been_booked_successfully',
      desc: '',
      args: [],
    );
  }

  /// `failed to pay`
  String get failed_to_pay {
    return Intl.message(
      'failed to pay',
      name: 'failed_to_pay',
      desc: '',
      args: [],
    );
  }

  /// `cancelled`
  String get cancelled {
    return Intl.message('cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `there was an error selecting session`
  String get there_was_an_error_selecting_session {
    return Intl.message(
      'there was an error selecting session',
      name: 'there_was_an_error_selecting_session',
      desc: '',
      args: [],
    );
  }

  /// `offer sessions`
  String get offer_sessions {
    return Intl.message(
      'offer sessions',
      name: 'offer_sessions',
      desc: '',
      args: [],
    );
  }

  /// `writing`
  String get writing {
    return Intl.message('writing', name: 'writing', desc: '', args: []);
  }

  /// `session date`
  String get session_date {
    return Intl.message(
      'session date',
      name: 'session_date',
      desc: '',
      args: [],
    );
  }

  /// `session time`
  String get session_time {
    return Intl.message(
      'session time',
      name: 'session_time',
      desc: '',
      args: [],
    );
  }

  /// `session duration`
  String get session_duration {
    return Intl.message(
      'session duration',
      name: 'session_duration',
      desc: '',
      args: [],
    );
  }

  /// `book session`
  String get book_session {
    return Intl.message(
      'book session',
      name: 'book_session',
      desc: '',
      args: [],
    );
  }

  /// `list of customer bookings`
  String get list_of_customer_bookings {
    return Intl.message(
      'list of customer bookings',
      name: 'list_of_customer_bookings',
      desc: '',
      args: [],
    );
  }

  /// `client Name`
  String get client_name {
    return Intl.message('client Name', name: 'client_name', desc: '', args: []);
  }

  /// `there is no booking`
  String get there_is_no_booking {
    return Intl.message(
      'there is no booking',
      name: 'there_is_no_booking',
      desc: '',
      args: [],
    );
  }

  /// `time table`
  String get time_table {
    return Intl.message('time table', name: 'time_table', desc: '', args: []);
  }

  /// `booking list`
  String get booking_list {
    return Intl.message(
      'booking list',
      name: 'booking_list',
      desc: '',
      args: [],
    );
  }

  /// `this time is already booked`
  String get this_time_is_already_booked {
    return Intl.message(
      'this time is already booked',
      name: 'this_time_is_already_booked',
      desc: '',
      args: [],
    );
  }

  /// `please select date`
  String get please_select_date {
    return Intl.message(
      'please select date',
      name: 'please_select_date',
      desc: '',
      args: [],
    );
  }

  /// `you must select 3 different times`
  String get you_must_select_3_different_times {
    return Intl.message(
      'you must select 3 different times',
      name: 'you_must_select_3_different_times',
      desc: '',
      args: [],
    );
  }

  /// `successfully saved schedule`
  String get successfully_saved_schedule {
    return Intl.message(
      'successfully saved schedule',
      name: 'successfully_saved_schedule',
      desc: '',
      args: [],
    );
  }

  /// `there was an error saving schedule`
  String get there_was_an_error_saving_schedule {
    return Intl.message(
      'there was an error saving schedule',
      name: 'there_was_an_error_saving_schedule',
      desc: '',
      args: [],
    );
  }

  /// `choose date`
  String get choose_date {
    return Intl.message('choose date', name: 'choose_date', desc: '', args: []);
  }

  /// `date`
  String get date {
    return Intl.message('date', name: 'date', desc: '', args: []);
  }

  /// `choose time`
  String get choose_time {
    return Intl.message('choose time', name: 'choose_time', desc: '', args: []);
  }

  /// `time`
  String get time {
    return Intl.message('time', name: 'time', desc: '', args: []);
  }

  /// `save`
  String get save {
    return Intl.message('save', name: 'save', desc: '', args: []);
  }

  /// `confirm delete`
  String get confirm_delete {
    return Intl.message(
      'confirm delete',
      name: 'confirm_delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this user?`
  String get are_you_sure_you_want_to_delete_this_user {
    return Intl.message(
      'Are you sure you want to delete this user?',
      name: 'are_you_sure_you_want_to_delete_this_user',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message('cancel', name: 'cancel', desc: '', args: []);
  }

  /// `deteled successfully`
  String get deteled_successfully {
    return Intl.message(
      'deteled successfully',
      name: 'deteled_successfully',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message('delete', name: 'delete', desc: '', args: []);
  }

  /// `users`
  String get users {
    return Intl.message('users', name: 'users', desc: '', args: []);
  }

  /// `sessions`
  String get sessions {
    return Intl.message('sessions', name: 'sessions', desc: '', args: []);
  }

  /// `blogs`
  String get blogs {
    return Intl.message('blogs', name: 'blogs', desc: '', args: []);
  }

  /// `users management`
  String get manage_users {
    return Intl.message(
      'users management',
      name: 'manage_users',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message('search', name: 'search', desc: '', args: []);
  }

  /// `specialists management`
  String get manage_specialists {
    return Intl.message(
      'specialists management',
      name: 'manage_specialists',
      desc: '',
      args: [],
    );
  }

  /// `specialist name`
  String get specialist_name {
    return Intl.message(
      'specialist name',
      name: 'specialist_name',
      desc: '',
      args: [],
    );
  }

  /// `status`
  String get status {
    return Intl.message('status', name: 'status', desc: '', args: []);
  }

  /// `edit`
  String get edit {
    return Intl.message('edit', name: 'edit', desc: '', args: []);
  }

  /// `sessions management`
  String get manage_sessions {
    return Intl.message(
      'sessions management',
      name: 'manage_sessions',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this blog?`
  String get are_you_sure_you_want_to_delete_this_blog {
    return Intl.message(
      'Are you sure you want to delete this blog?',
      name: 'are_you_sure_you_want_to_delete_this_blog',
      desc: '',
      args: [],
    );
  }

  /// `blogs management`
  String get manage_blogs {
    return Intl.message(
      'blogs management',
      name: 'manage_blogs',
      desc: '',
      args: [],
    );
  }

  /// `title`
  String get blog_title {
    return Intl.message('title', name: 'blog_title', desc: '', args: []);
  }

  /// `active`
  String get active {
    return Intl.message('active', name: 'active', desc: '', args: []);
  }

  /// `not active`
  String get not_active {
    return Intl.message('not active', name: 'not_active', desc: '', args: []);
  }

  /// `successfully updated`
  String get successfully_updated {
    return Intl.message(
      'successfully updated',
      name: 'successfully_updated',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch PDF`
  String get could_not_launch_pdf {
    return Intl.message(
      'Could not launch PDF',
      name: 'could_not_launch_pdf',
      desc: '',
      args: [],
    );
  }

  /// `edit specialist account`
  String get edit_specialist_account {
    return Intl.message(
      'edit specialist account',
      name: 'edit_specialist_account',
      desc: '',
      args: [],
    );
  }

  /// `show qualification file`
  String get show_qualification_file {
    return Intl.message(
      'show qualification file',
      name: 'show_qualification_file',
      desc: '',
      args: [],
    );
  }

  /// `account status`
  String get status_account {
    return Intl.message(
      'account status',
      name: 'status_account',
      desc: '',
      args: [],
    );
  }

  /// `edit blog`
  String get edit_blog {
    return Intl.message('edit blog', name: 'edit_blog', desc: '', args: []);
  }

  /// `publish date`
  String get publish_date {
    return Intl.message(
      'publish date',
      name: 'publish_date',
      desc: '',
      args: [],
    );
  }

  /// `content`
  String get content {
    return Intl.message('content', name: 'content', desc: '', args: []);
  }

  /// `mental disorder...`
  String get mental_disorder {
    return Intl.message(
      'mental disorder...',
      name: 'mental_disorder',
      desc: '',
      args: [],
    );
  }

  /// `add new blog`
  String get add_new_blog {
    return Intl.message(
      'add new blog',
      name: 'add_new_blog',
      desc: '',
      args: [],
    );
  }

  /// `adding`
  String get adding {
    return Intl.message('adding', name: 'adding', desc: '', args: []);
  }

  /// `please wait until session starts`
  String get please_wait_until_session_starts {
    return Intl.message(
      'please wait until session starts',
      name: 'please_wait_until_session_starts',
      desc: '',
      args: [],
    );
  }

  /// `please rate session`
  String get please_rate_session {
    return Intl.message(
      'please rate session',
      name: 'please_rate_session',
      desc: '',
      args: [],
    );
  }

  /// `send`
  String get send {
    return Intl.message('send', name: 'send', desc: '', args: []);
  }

  /// `there was an error updating rating`
  String get there_was_an_error_updating_rating {
    return Intl.message(
      'there was an error updating rating',
      name: 'there_was_an_error_updating_rating',
      desc: '',
      args: [],
    );
  }

  /// `there is no messages`
  String get there_is_no_messages {
    return Intl.message(
      'there is no messages',
      name: 'there_is_no_messages',
      desc: '',
      args: [],
    );
  }

  /// `writing a message...`
  String get writing_a_message {
    return Intl.message(
      'writing a message...',
      name: 'writing_a_message',
      desc: '',
      args: [],
    );
  }

  /// `contact us`
  String get contact_us {
    return Intl.message('contact us', name: 'contact_us', desc: '', args: []);
  }

  /// `coping successfully`
  String get coping {
    return Intl.message(
      'coping successfully',
      name: 'coping',
      desc: '',
      args: [],
    );
  }

  /// `duration`
  String get duration {
    return Intl.message('duration', name: 'duration', desc: '', args: []);
  }

  /// `the account has been created successfully`
  String get the_account_has_been_created_successfully {
    return Intl.message(
      'the account has been created successfully',
      name: 'the_account_has_been_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// ` password must be at least 8 characters long`
  String get password_must_be_at_least_8_characters_long {
    return Intl.message(
      ' password must be at least 8 characters long',
      name: 'password_must_be_at_least_8_characters_long',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passwrod_must_contain_at_least_one_uppercase_letter {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passwrod_must_contain_at_least_one_uppercase_letter',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter`
  String get passwrod_must_contain_at_least_one_lowercase_letter {
    return Intl.message(
      'Password must contain at least one lowercase letter',
      name: 'passwrod_must_contain_at_least_one_lowercase_letter',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get passwrod_must_contain_at_least_one_number {
    return Intl.message(
      'Password must contain at least one number',
      name: 'passwrod_must_contain_at_least_one_number',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get passwrod_must_contain_at_least_one_special_character {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'passwrod_must_contain_at_least_one_special_character',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Are sure you want to delete the account`
  String get are_sure_you_want_to_delete_the_account {
    return Intl.message(
      'Are sure you want to delete the account',
      name: 'are_sure_you_want_to_delete_the_account',
      desc: '',
      args: [],
    );
  }

  /// `add admin`
  String get add_admin {
    return Intl.message('add admin', name: 'add_admin', desc: '', args: []);
  }

  /// `admin added successfully`
  String get admin_added_successfully {
    return Intl.message(
      'admin added successfully',
      name: 'admin_added_successfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
