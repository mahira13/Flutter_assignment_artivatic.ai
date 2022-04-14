import 'dart:convert';

ApiDataModel sampleModelFromJson(String str) =>
    ApiDataModel.fromJson(json.decode(str));

String sampleModelToJson(ApiDataModel data) => json.encode(data.toJson());

class ApiDataModel {
  ApiDataModel({
    required this.title,
    required this.rows,
  });

  String title;
  List<RowData> rows;

  factory ApiDataModel.fromJson(Map<String, dynamic> json) => ApiDataModel(
        title: json["title"]==null? "NA" :json["title"],
        rows: List<RowData>.from(json["rows"].map((x) => RowData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class RowData {
  RowData({
    required this.title,
    required this.description,
    required this.imageHref,
  });

  String title;
  String description;
  String imageHref;

  factory RowData.fromJson(Map<String, dynamic> json) => RowData(
        title: json["title"] == null ? "NA" : json["title"],
        description: json["description"] == null ? "NA" : json["description"],
        imageHref: json["imageHref"] == null ? "" : json["imageHref"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "imageHref": imageHref,
      };
}
