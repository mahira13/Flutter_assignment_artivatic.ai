import 'package:assignment_artivatic/controllers/api-data-controller.dart';
import 'package:assignment_artivatic/models/api-data-model.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _loading = true;
  late List<RowData> rowDataList;
  String appbarTitle = "";
  Future<void> _getData() async {   // function to refresh data
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
      appbarTitle = value.title;   //storing title parameter in api response to appbar title
      rowDataList = value.rows;    // storing rows list in api response to a list
      setState(() {
        _loading = false;          // setting loading=false when data from api is receieved
      });
    });
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
       
      ),
    );
  }
}
