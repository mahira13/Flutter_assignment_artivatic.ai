import 'package:assignment_artivatic/controllers/api-data-controller.dart';
import 'package:assignment_artivatic/models/api-data-model.dart';
import 'package:assignment_artivatic/views/shimmer/shimmer-widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool loading = true;
  late List<RowData> rowDataList;
  String appbarTitle = "";
  Future<void> _getData() async {
    // function to refresh data
    rowDataList.clear();
    await getApiData();
  }

  @override
  void initState() {
    super.initState();
    rowDataList = [];
    getApiData(); //calling function to call api to get data
  }

//function to call controller class
  getApiData() {
    ApiDataController().getDataList().then((value) {
      appbarTitle =
          value.title; //storing title parameter in api response to appbar title
      rowDataList = value.rows; // storing rows list in api response to a list
      value.rows.map((e) => cacheImages(context, e.imageHref)).toList();
      setState(() {
        loading =
            false; // setting loading=false when data from api is receieved
      });
    });
  }

  Future cacheImages(BuildContext context, String imgURL) =>
      precacheImage(CachedNetworkImageProvider(imgURL), context);

  Widget defaultPlaceholderImage() {
    ///default image to show when network image is unavailable
    return SizedBox(
        height: 150,
        width: 200,
        child: Image.asset("assets/images/noimage.png"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            appbarTitle,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: loading == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return CustomShimmerWidget();
                    }),
              ) //showing progress indicator until response from api is received
            : rowDataList.isEmpty
                ? const Center(
                    child: Text('Nothing to show!'),
                  )
                : RefreshIndicator(
                    onRefresh:
                        _getData, //calling refresh function to get updated data from api
                    child: ListView.builder(
                      itemCount: rowDataList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.all(8),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rowDataList[index].title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 4, 0, 8),
                                  child: Text(rowDataList[index].description,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[700])),
                                ),
                                rowDataList[index].imageHref == "NA"
                                    ? defaultPlaceholderImage()
                                    : CachedNetworkImage(
                                        imageUrl: rowDataList[index].imageHref,
                                        placeholder: (context, url) =>
                                            defaultPlaceholderImage(),
                                        errorWidget: (context, url, error) =>
                                            defaultPlaceholderImage(),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
