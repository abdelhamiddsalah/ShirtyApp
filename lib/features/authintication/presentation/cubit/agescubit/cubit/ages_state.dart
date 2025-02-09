part of 'ages_cubit.dart';

sealed class AgesState extends Equatable {
  const AgesState();

  @override
  List<Object> get props => [];
}

final class AgesInitial extends AgesState {}

final class AgesLoading extends AgesState {}

final class AgesLoaded extends AgesState {
  final List<QueryDocumentSnapshot> list;
  const AgesLoaded({required this.list});
}

final class AgesError extends AgesState {
  final String message;
  const AgesError({required this.message});
}
