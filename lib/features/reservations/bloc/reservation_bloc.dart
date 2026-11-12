import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/repositories/auth_repository.dart';
import '../../../core/repositories/reservation_repository.dart';
import '../models/reservation_model.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository _reservationRepo;
  final AuthRepository _authRepo;

  ReservationBloc({
    ReservationRepository? reservationRepo,
    AuthRepository? authRepo,
  })  : _reservationRepo = reservationRepo ?? ReservationRepository(),
        _authRepo = authRepo ?? AuthRepository(),
        super(const ReservationInitial()) {
    on<LoadReservations>(_onLoadReservations);
    on<AddReservation>(_onAddReservation);
    on<CancelReservation>(_onCancelReservation);
    on<CompleteReservation>(_onCompleteReservation);
  }

  Future<void> _onLoadReservations(
    LoadReservations event,
    Emitter<ReservationState> emit,
  ) async {
    final defaultCompleted = [
      ReservationModel(
        id: 'res_past_1',
        serviceTitle: 'Rutin Yürüyüş',
        serviceIcon: Icons.calendar_month_rounded,
        date: DateTime.now().subtract(const Duration(days: 3)),
        timeSlot: '11:00',
        duration: '45 Dakika',
        packageOption: '45 Dakika',
        price: 290.0,
        status: ReservationStatus.completed,
      ),
      ReservationModel(
        id: 'res_past_2',
        serviceTitle: 'Köpek Evde Bakım',
        serviceIcon: Icons.pets_rounded,
        date: DateTime.now().subtract(const Duration(days: 10)),
        timeSlot: '14:00',
        duration: 'Tam Gün Evde Bakım',
        packageOption: 'Tam Gün Evde Bakım',
        price: 650.0,
        status: ReservationStatus.completed,
      ),
    ];

    emit(ReservationLoaded(
      activeReservations: const [],
      completedReservations: defaultCompleted,
    ));
  }

  Future<void> _onAddReservation(
    AddReservation event,
    Emitter<ReservationState> emit,
  ) async {
    final user = _authRepo.currentUser;
    if (user != null) {
      try {
        await _reservationRepo.addReservation(user.uid, event.reservation);
      } catch (_) {}
    }

    final s = state;
    if (s is ReservationLoaded) {
      final updated = [event.reservation, ...s.activeReservations];
      emit(s.copyWith(activeReservations: updated));
    } else {
      emit(ReservationLoaded(
        activeReservations: [event.reservation],
        completedReservations: const [],
      ));
    }
  }

  Future<void> _onCancelReservation(
    CancelReservation event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      await _reservationRepo.cancelReservation(event.id);
    } catch (_) {}

    final s = state;
    if (s is ReservationLoaded) {
      final updated = s.activeReservations.where((r) => r.id != event.id).toList();
      emit(s.copyWith(activeReservations: updated));
    }
  }

  Future<void> _onCompleteReservation(
    CompleteReservation event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      await _reservationRepo.updateReservationStatus(
        event.id,
        ReservationStatus.completed,
      );
    } catch (_) {}

    final s = state;
    if (s is ReservationLoaded) {
      final target = s.activeReservations.firstWhere((r) => r.id == event.id);
      final updatedActive = s.activeReservations.where((r) => r.id != event.id).toList();
      final updatedCompleted = [
        target.copyWith(status: ReservationStatus.completed),
        ...s.completedReservations,
      ];
      emit(s.copyWith(
        activeReservations: updatedActive,
        completedReservations: updatedCompleted,
      ));
    }
  }
}
