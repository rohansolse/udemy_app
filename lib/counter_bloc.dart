import 'package:flutter_bloc/flutter_bloc.dart';

// Events
enum CounterEvent { increment, decrement }

// BLoC
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    _setupEventHandlers();
  }

  void _setupEventHandlers() {
    on<CounterEvent>((event, emit) {
      if (event == CounterEvent.increment) {
        emit(state + 1);
      } else if (event == CounterEvent.decrement) {
        emit(state - 1);
      }
    });
  }
}
