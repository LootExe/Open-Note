import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ScrollBloc extends Bloc<ScrollEvent, ScrollState> {
  ScrollBloc() : super(const ScrollState(titleVisible: true)) {
    on<ScrollContentScrolled>(_onContentScrolled);
  }

  void _onContentScrolled(
      ScrollContentScrolled event, Emitter<ScrollState> emit) {
    emit(state.copyWith(titleVisible: event.titleVisible));
  }
}

class ScrollState extends Equatable {
  /// Indicates if the note title is visible.
  final bool titleVisible;

  @override
  List<Object?> get props => [titleVisible];

  const ScrollState({required this.titleVisible});

  ScrollState copyWith({bool? titleVisible}) {
    return ScrollState(titleVisible: titleVisible ?? this.titleVisible);
  }
}

abstract class ScrollEvent extends Equatable {
  const ScrollEvent();
}

/// Screen content was scrolled.
class ScrollContentScrolled extends ScrollEvent {
  /// Indicates if the note title is visible.
  final bool titleVisible;

  @override
  List<Object?> get props => [titleVisible];

  const ScrollContentScrolled(this.titleVisible);
}
