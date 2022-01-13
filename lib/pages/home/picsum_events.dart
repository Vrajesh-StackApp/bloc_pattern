import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PicsumEvents extends Equatable{
  const PicsumEvents();
}

class FetchPicsum extends PicsumEvents{
  final int? pages;
  final int? limit;

  const FetchPicsum(this.pages, this.limit):assert(pages != null,limit != null);

  @override
  List<Object?> get props => [pages,limit];
}

class RefreshPicsum extends PicsumEvents{
  final int? pages;
  final int? limit;

  const RefreshPicsum({@required this.pages,@required this.limit}):assert(pages != null,limit != null);

  @override
  List<Object?> get props => [pages,limit];
}

class ResetPicsum extends PicsumEvents{
  @override
  List<Object?> get props => [];
}