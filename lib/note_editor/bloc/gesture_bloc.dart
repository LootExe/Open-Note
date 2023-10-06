import 'package:bloc/bloc.dart';

// TODO(Frank): Try to convert to cubit
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

final class GestureState {
  const GestureState();
}

sealed class GestureEvent {
  const GestureEvent();
}

/// Screen was tapped.
final class GestureScreenTapped extends GestureEvent {
  const GestureScreenTapped();
}
