part of 'rating_cubit.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}

final class RatingSet extends RatingState {}
