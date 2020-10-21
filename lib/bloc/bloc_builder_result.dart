
import 'package:flutter/material.dart';
import 'bloc_state.dart';



class BlocBuilderResult {
  BlocState _mageState;

  BuildContext _context;
  BlocBuilderResult(BuildContext context, BlocState state ) {
    this._context = context;
    this._mageState = state;

  }

  get state => _mageState?.state;
  get value => _mageState?.result?.value;
  get context => _context;
}
