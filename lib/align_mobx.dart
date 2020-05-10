import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'align_mobx.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  Alignment value = Alignment(0.0, 3.0);
}
