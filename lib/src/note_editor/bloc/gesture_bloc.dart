import 'package:bloc/bloc.dart';

class GestureBloc extends Bloc<GestureEvent, GestureState> {
  GestureBloc() : super(const GestureState()) {
    on<GestureScreenTapped>(_onScreenTapped);
  }

  void _onScreenTapped(GestureScreenTapped event, Emitter<GestureState> emit) {
    // Can't use const because emit needs to compare state objects.
    // ignore: prefer_const_constructors
    emit(GestureState());
  }
}

class GestureState {
  const GestureState();
}

abstract class GestureEvent {
  const GestureEvent();
}

/// Screen was tapped.
class GestureScreenTapped extends GestureEvent {
  const GestureScreenTapped();
}
