import 'package:dartz/dartz.dart';
import 'package:googly/src/model/asset_model.dart';
import 'package:googly/src/resource/remote_data_source.dart';
import '../shared.dart';

abstract class Repository {
  Future<Either<Failure, AssetModel>> getAssetModel();
}

class RepoImplementation extends Repository{
  final RemoteDataSourceImp _remote = RemoteDataSourceImp();
  RepoImplementation();
  @override
  Future<Either<Failure, AssetModel>> getAssetModel() {
    return Task(() => _remote.getAssetModelFromApi())
        .attempt()
        .map(
            // Grab only the *left* side of Either<Object, Post>
            (either) => either.leftMap((obj) {
                  // Cast the Object into a Failure
                  return obj as Failure;
                }))
        .run();
  }
}