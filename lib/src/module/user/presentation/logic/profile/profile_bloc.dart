import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserInfo getUserInfo;
  final UpdateUserName updateUserName;
  final UpdateUserPhoto updateUserPhoto;
  ProfileBloc({
    required this.getUserInfo,
    required this.updateUserName,
    required this.updateUserPhoto,
  }) : super(LoadingProfileState()) {
    on<GetUserInfoEvent>(_getUserInfo);
    on<UpdateUserNameEvent>(_updateUserName);
    on<UpdateUserPhotoEvent>(_updateUserPhoto);
    on<InitialUserInfoEvent>(_initialUserInfo);
  }

  void _initialUserInfo(
      InitialUserInfoEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInitial());
  }

  void _getUserInfo(GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    emit(LoadingProfileState());
    final userInfo = await getUserInfo(
      GetUserInfoParams(
        userId: event.userId,
      ),
    );
    userInfo.fold(
      (error) => emit(ProfileFailureState(error)),
      (user) => emit(LoadedUserProfileState(user)),
    );
  }

  void _updateUserName(
      UpdateUserNameEvent event, Emitter<ProfileState> emit) async {
    emit(LoadingProfileState());
    final isUpdated = await updateUserName(
      UpdateUserNameParams(
        userId: event.userId,
        userName: event.userName,
      ),
    );
    isUpdated.fold(
      (error) => emit(ProfileFailureState(error)),
      (isUpdated) => emit(UpdatedUserNameState(isUpdated)),
    );
  }

  void _updateUserPhoto(
      UpdateUserPhotoEvent event, Emitter<ProfileState> emit) async {
    emit(LoadingProfileState());
    final isUpdated = await updateUserPhoto(
      UpdateUserPhotoParams(
        userId: event.userId,
        userPhotoUrl: event.userPhotoUrl,
      ),
    );
    isUpdated.fold(
      (error) => emit(ProfileFailureState(error)),
      (isUpdated) => emit(UpdatedUserPhotoState(isUpdated)),
    );
  }
}
