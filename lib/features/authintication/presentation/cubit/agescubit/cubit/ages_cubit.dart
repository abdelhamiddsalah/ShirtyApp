import 'package:bloc/bloc.dart';
import 'package:clothshop/features/authintication/domain/usecases/ages_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'ages_state.dart';

class AgesCubit extends Cubit<AgesState> {
  final AgesUsecase ages;
  AgesCubit(this.ages) : super(AgesInitial());

  Future<void> getAges() async {
    emit(AgesLoading());
    final result = await ages.call(ages);
    result.fold(
      (failure) => emit(AgesError(message: failure.message)),
      (ages) => emit(AgesLoaded(list: ages)),
    );
  }
}
