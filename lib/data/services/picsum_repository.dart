import 'package:bloc_pattern/data/model/picsum.dart';
import 'package:bloc_pattern/data/services/picsum_client.dart';
import 'package:flutter/cupertino.dart';

class PicsumRepository{
  PicsumClient? picsumClient;

  PicsumRepository({@required this.picsumClient}):assert(picsumClient != null);

  Future<Picsum> getPicsum(int page,int limit){
    return picsumClient!.getPicsum(page, limit);
  }
}