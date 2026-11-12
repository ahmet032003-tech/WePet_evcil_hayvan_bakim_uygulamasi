import '../../../core/models/service_item_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<ServiceItemModel> services;
  final ServiceItemModel? selectedService;
  final String? lastReservationSummary;

  const HomeLoaded({
    required this.services,
    this.selectedService,
    this.lastReservationSummary,
  });

  HomeLoaded copyWith({
    List<ServiceItemModel>? services,
    ServiceItemModel? selectedService,
    String? lastReservationSummary,
  }) {
    return HomeLoaded(
      services: services ?? this.services,
      selectedService: selectedService ?? this.selectedService,
      lastReservationSummary:
          lastReservationSummary ?? this.lastReservationSummary,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
