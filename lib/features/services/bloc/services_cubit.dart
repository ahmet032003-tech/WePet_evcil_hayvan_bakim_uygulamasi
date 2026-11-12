import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesState {
  final bool hasActiveServices;

  const ServicesState({this.hasActiveServices = false});
}

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(const ServicesState());

  void onCreatePetProfileTap() {
    emit(const ServicesState(hasActiveServices: false));
  }
}

