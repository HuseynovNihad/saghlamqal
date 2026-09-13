import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dietitians_event.dart';
part 'dietitians_state.dart';

class DietitiansBloc extends Bloc<DietitiansEvent, DietitiansState> {
  DietitiansBloc() : super(DietitiansInitial()) {
    on<DietitiansEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
