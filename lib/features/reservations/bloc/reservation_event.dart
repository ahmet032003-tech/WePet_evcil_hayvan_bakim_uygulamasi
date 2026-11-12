import '../models/reservation_model.dart';

abstract class ReservationEvent {
  const ReservationEvent();
}

class LoadReservations extends ReservationEvent {
  const LoadReservations();
}

class AddReservation extends ReservationEvent {
  final ReservationModel reservation;

  const AddReservation(this.reservation);
}

class CancelReservation extends ReservationEvent {
  final String id;

  const CancelReservation(this.id);
}

class CompleteReservation extends ReservationEvent {
  final String id;

  const CompleteReservation(this.id);
}

