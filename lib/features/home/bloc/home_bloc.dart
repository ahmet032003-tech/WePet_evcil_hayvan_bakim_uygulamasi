import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/mock_data.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<SelectService>(_onSelectService);
    on<CreateReservation>(_onCreateReservation);
  }

  void _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) {
    emit(const HomeLoading());
    try {
      const services = MockData.homeServices;
      emit(const HomeLoaded(services: services));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onSelectService(SelectService event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(selectedService: event.service));
    }
  }

  void _onCreateReservation(
    CreateReservation event,
    Emitter<HomeState> emit,
  ) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final summary =
          '${event.service.title} - ${event.date.day}/${event.date.month} ${event.timeSlot} (${event.packageOption})';
      emit(currentState.copyWith(
        selectedService: event.service,
        lastReservationSummary: summary,
      ));
    }
  }
}
