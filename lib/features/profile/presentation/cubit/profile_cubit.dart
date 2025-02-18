import 'package:bloc/bloc.dart';
import 'package:clothshop/features/profile/domain/entities/user_entity.dart';
import 'package:clothshop/features/profile/domain/usecases/profile_usecase.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase profileUsecase;
  ProfileCubit(this.profileUsecase) : super(ProfileInitial());

  Future<void> getUserData(String userId) async {
    emit(ProfileLoading());
    final result = await profileUsecase.getUserData(userId);
    result.fold((l) => emit(ProfileError(l.message)), (r) => emit(ProfileLoaded(r)));
  }
}
