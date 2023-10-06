import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ScrollBloc extends Bloc<ScrollEvent, ScrollState> {
  ScrollBloc() : super(const ScrollState(titleVisible: true)) {
    on<ScrollContentScrolled>(_onContentScrolled);
  }

  void _onContentScrolled(
    ScrollContentScrolled event,
    Emitter<ScrollState> emit,
  ) {
    emit(state.copyWith(titleVisible: event.titleVisible));
  }
}

final class ScrollState extends Equatable {
  const ScrollState({required this.titleVisible});

  /// Indicates if the note title is visible.
  final bool titleVisible;

  ScrollState copyWith({bool? titleVisible}) {
    return ScrollState(titleVisible: titleVisible ?? this.titleVisible);
  }

  @override
  List<Object?> get props => [titleVisible];
}

sealed class ScrollEvent extends Equatable {
  const ScrollEvent();

  @override
  List<Object?> get props => [];
}

/// Screen content was scrolled.
final class ScrollContentScrolled extends ScrollEvent {
  const ScrollContentScrolled({required this.titleVisible});

  /// Indicates if the note title is visible.
  final bool titleVisible;

  @override
  List<Object?> get props => [titleVisible];
}
