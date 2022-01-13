import 'package:bloc_pattern/data/model/picsum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PicsumStates extends Equatable{
  const PicsumStates();

  @override
  List<Object?> get props => [];
}

class PicsumEmpty extends PicsumStates{}

class PicsumLoading extends PicsumStates{}

class PicsumLoaded extends PicsumStates{
  final Picsum? picsum;

  const PicsumLoaded({@required this.picsum}):assert(picsum != null);

  @override
  List<Object?> get props => [picsum];
}

class PicsumError extends PicsumStates{}