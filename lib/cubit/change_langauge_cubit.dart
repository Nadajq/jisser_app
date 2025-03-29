import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_langauge_state.dart';

class ChangeLangaugeCubit extends Cubit<ChangeLangaugeState> {
  ChangeLangaugeCubit() : super(ChangeArabic());

  void changeLangauge() {
    if (state is ChangeArabic) {
      emit(ChangeEnglish());
    } else {
      emit(ChangeArabic());
    }
  }
}
