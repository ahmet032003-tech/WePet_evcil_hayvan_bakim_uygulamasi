import '../models/reservation_model.dart';

abstract class ReservationState {
  const ReservationState();
}

class ReservationInitial extends ReservationState {
  const ReservationInitial();
}

class ReservationLoading extends ReservationState {
  const ReservationLoading();
}

class ReservationLoaded extends ReservationState {
  final List<ReservationModel> activeReservations;
  final List<ReservationModel> completedReservations;

  const ReservationLoaded({
    required this.activeReservations,
    required this.completedReservations,
  });

  ReservationLoaded copyWith({
    List<ReservationModel>? activeReservations,
    List<ReservationModel>? completedReservations,
  }) {
    return ReservationLoaded(
      activeReservations: activeReservations ?? this.activeReservations,
      completedReservations:
          completedReservations ?? this.completedReservations,
    );
  }
}

