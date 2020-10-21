import 'bloc.dart';

class BlocManager {

  Map<String,dynamic> _blocs;


  static final BlocManager _instance = new BlocManager._();

  factory BlocManager() {
    return _instance;
  }



  BlocManager._() {
    _blocs = Map<String,dynamic>();
  }

  Bloc createBloc<T>({String blocName}) {
    if(blocName!=null) {
      return _blocs[blocName] =  new Bloc<T>();
    }
    return  new Bloc<T>();

  }

}
