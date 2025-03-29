import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  int rating = 0;
  List<int> ratings = [
    0,
    1,
    2,
    3,
    4,
  ];
  void setRating(int value) {
    rating = value;
    emit(RatingSet());
  }
}
