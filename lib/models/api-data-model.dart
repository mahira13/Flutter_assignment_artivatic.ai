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
        title: json["title"] ?? "NA",
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
        title: json["title"] ?? "NA",
        description: json["description"] ?? "NA",
        imageHref: json["imageHref"] ?? "NA",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "imageHref": imageHref,
      };
}
