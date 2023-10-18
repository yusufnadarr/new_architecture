import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/models/user_model.dart';
import 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(InitialState());

  UserModel? user;

  Future<void> controlUser() async {
    await Future.delayed(const Duration(seconds: 1));
    user = UserModel(id: 5);
    if (user != null) {
      emit(LoggedState());
    } else {
      emit(LoginState());
    }
  }
}
