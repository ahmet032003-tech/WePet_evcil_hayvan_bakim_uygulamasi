import '../../../core/models/service_item_model.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

class SelectService extends HomeEvent {
  final ServiceItemModel service;

  const SelectService(this.service);
}

class CreateReservation extends HomeEvent {
  final ServiceItemModel service;
  final DateTime date;
  final String timeSlot;
  final String packageOption;
  final double price;
  final int durationMinutes;

  const CreateReservation({
    required this.service,
    required this.date,
    required this.timeSlot,
    required this.packageOption,
    required this.price,
    this.durationMinutes = 45,
  });
}
