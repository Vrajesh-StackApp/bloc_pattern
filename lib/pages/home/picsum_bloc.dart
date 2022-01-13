import 'package:bloc_pattern/data/model/picsum.dart';
import 'package:bloc_pattern/data/services/picsum_repository.dart';
import 'package:bloc_pattern/pages/home/picsum_events.dart';
import 'package:bloc_pattern/pages/home/picsum_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PicsumBloc extends Bloc<PicsumEvents,PicsumStates>{
  final PicsumRepository? picsumRepository;

  PicsumBloc(this.picsumRepository) : assert(picsumRepository != null),super(PicsumEmpty());

  Stream<PicsumStates> mapEventToStates(PicsumEvents picsumEvents)async*{
    if(picsumEvents is FetchPicsum){
      yield PicsumLoading();
      try{
        final Picsum picsum = await picsumRepository!.getPicsum(picsumEvents.pages!,picsumEvents.limit!);
        yield PicsumLoaded(picsum: picsum);
      }catch(error){
        debugPrint("Error ==> $error");
        yield PicsumError();
      }
    }
    else if(picsumEvents is RefreshPicsum){
      try{
        final Picsum picsum = await picsumRepository!.getPicsum(picsumEvents.pages!, picsumEvents.limit!);
        yield PicsumLoaded(picsum: picsum);
      }catch(error){
        debugPrint("Error else ==> $error");
        yield state;
      }
    }
    else if(picsumEvents is ResetPicsum){
      yield PicsumEmpty();
    }
  }
}