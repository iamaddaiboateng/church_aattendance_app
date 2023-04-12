import 'package:churchtick/home/controller/service_home_controlle.dart';
import 'package:churchtick/info/home_page_with_data.dart';
import 'package:churchtick/members/controller/members_controller.dart';
import 'package:churchtick/members/view/all_member_page.dart';
import 'package:churchtick/services/attendance/controller/attendance_controller.dart';
import 'package:churchtick/services/service_details/service_details_screen.dart';
import 'package:churchtick/utils/date_time.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.lazyBox(kServiceDate).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceDetailsController>(context);
    final attendanceProvider =
        Provider.of<AttendanceController>(context, listen: false);

    return FutureBuilder(
        future: Hive.openLazyBox(kServiceDate),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(
              child: Container(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(),
              ),
            );
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                ServiceHome().addServiceDialog();
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text(kHomePage),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.people),
                  onPressed: () {
                    Get.to(AllMembers());
                  },
                )
              ],
            ),
            body: ValueListenableBuilder(
              valueListenable: Hive.lazyBox(kServiceDate).listenable(),
              builder: (context, LazyBox lazyBox, _) {
                return lazyBox.isEmpty
                    ? HomePageWithDataInfo()
                    : ListView.builder(
                        itemCount: lazyBox.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              onTap: () async {
                                var map = await lazyBox.getAt(index);
                                serviceProvider
                                    .getServiceName(map[kActualTime]);
                                attendanceProvider.getServiceDateDetail(
                                    getDateInString(map[kReadableTime]));
                                serviceProvider.getServiceTotalAttendanceName(
                                    map[kActualTime]);
                                Get.to(FutureBuilder(
                                    future: Hive.openBox(
                                        serviceProvider.serviceName),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null)
                                        return Center(
                                          child: Container(
                                              height: 50.0,
                                              width: 50.0,
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      return ServiceDetailsScreen(
                                          map[kReadableTime]);
                                    }));
                              },
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  ServiceHome().removeServiceDialog(index);
                                },
                              ),
                              title: FutureBuilder(
                                  future: lazyBox.getAt(index),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return LinearProgressIndicator();
                                    }
                                    return ListTile(
                                      title: Text(
                                        getDateInString(
                                            snapshot.data[kReadableTime]),
                                      ),
                                      subtitle:
                                          Text(snapshot.data[kActualTime]),
                                    );
                                  }),
                            ),
                          );
                        },
                      );
              },
            ),
          );
        });
  }
}
