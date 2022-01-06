import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:googly/src/model/asset_model.dart';
import 'package:googly/src/shared.dart';
import 'package:http/http.dart' as http;


abstract class RemoteDataSource<T> {
  Future<T> getAssetModelFromApi();
}

class RemoteDataSourceImp extends RemoteDataSource<AssetModel> {
  static const api = 'https://cricket.vectracom.com/cricket_quiz/cricket_api.php';

  @override
  Future<AssetModel>  getAssetModelFromApi()async{
    return _getPostFromUrl(api);
  }



  Future<AssetModel> _getPostFromUrl(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });
      return AssetModel.fromJson(jsonDecode(response.body));
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } on http.ClientException {
      throw Failure("http ClientException");
    } on TimeoutException{
      throw Failure("Time Out Exception");
    } on TypeError{
      throw Failure('type Error');
    }
  }
  ///*****************************************************************************/
  Future<AssetModel> _getPostFromUrlTwo(String url) async {
    final http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    }).timeout(Duration(seconds: 5));
    if(response.statusCode==200){
      return AssetModel.fromJson(jsonDecode(response.body));
    }else{
      throw ServerException();
    }
  }
}