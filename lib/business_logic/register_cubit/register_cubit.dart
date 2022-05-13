import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/constants/end_points.dart';
import 'package:web/data/network/responses/login_response.dart';
import 'package:web/data/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterCubitInitial());

   static RegisterCubit get(context) => BlocProvider.of(context);

  LoginResponse? loginResponse;

  Future userRegister({
    required String? name,
    required String? server,
    required String? email,
    required String? password,
    required String? phone,
    required VoidCallback afterSuccess,
    required VoidCallback afterFail,
  }) async {
    emit(RegisterLoadingState());
    await DioHelper.postData(url: register, body: {
      'name' : name,
      'server': server,
      'email': email,
      'password': password,
      'phone' : phone,
    }).then((value) {
      print(value.data);
      final myData = Map<String, dynamic>.from(value.data);
      loginResponse = LoginResponse.fromJson(myData);
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
      //showToast(error.toString());
    });
  }
}
