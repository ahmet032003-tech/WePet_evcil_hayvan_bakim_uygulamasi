import 'package:flutter_bloc/flutter_bloc.dart';

class ShopState {
  final bool isRewardClaimed;

  const ShopState({this.isRewardClaimed = false});
}

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(const ShopState());

  void claimWelcomeReward() {
    emit(const ShopState(isRewardClaimed: true));
  }
}

