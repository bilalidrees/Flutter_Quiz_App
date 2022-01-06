import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:googly/src/model/asset_model.dart';
import 'package:googly/src/repo/repository.dart';
import 'package:googly/src/shared.dart';

class PostProvider with ChangeNotifier{
  final RepoImplementation _repo = RepoImplementation();
  PostProvider(){
    getPost();
  }
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  Either<Failure, AssetModel>? _post;
  Either<Failure, AssetModel> get  post=>_post!;
  void _setPost(Either<Failure, AssetModel> post) {
    _post = post;
    notifyListeners();
  }

  Future<void> getPost()async{
    _setState(NotifierState.loading);
    await _repo.getAssetModel().then((value) => _setPost(value));
    _setState(NotifierState.loaded);
  }
}