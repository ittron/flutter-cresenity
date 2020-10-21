import 'bloc.dart';
import 'bloc_result.dart';

class BlocState<T> {
  String state;
  BlocResult<T> result;
  Bloc bloc;

  BlocState(String state, BlocResult<T> result, Bloc bloc) {
    this.state = state;
    this.result = result;
    this.bloc = bloc;
  }

}
