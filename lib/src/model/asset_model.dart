class AssetModel {
  List<String>? images;
  List<String>? video;

  AssetModel({this.images, this.video});

  AssetModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    video = json['video'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['video'] = this.video;
    return data;
  }
}
