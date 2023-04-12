import 'package:churchtick/members/controller/members_controller.dart';
import 'package:churchtick/services/attendance/controller/attendance_controller.dart';
import 'package:churchtick/services/attendance/view/attendance_view.dart';
import 'package:churchtick/services/start_service/controller/start_service_controller.dart';
import 'package:churchtick/utils/date_time.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final time;
  ServiceDetailsScreen(this.time);
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ServiceDetailsController>(context);
    service.openDateService(service.serviceName);

    final attendantProvider =
        Provider.of<AttendanceController>(context, listen: false);

    return Consumer<ServiceDetailsController>(
      builder: (_, service, __) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            StartService.startServiceDialog(service.serviceName);
          },
          child: Text('Start'),
        ),
        appBar: AppBar(
          title: Text(getDateInString(time)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.note_add),
              onPressed: () {},
            )
          ],
        ),
        body: WatchBoxBuilder(
          box: Hive.box(service.serviceName),
          builder: (context, box) => Hive.box(service.serviceName).isEmpty
              ? Center(
                  child: Text('No Service Started'),
                )
              : ListView.builder(
                  itemCount: Hive.box(service.serviceName).length,
                  itemBuilder: (context, index) {
                    var box = Hive.box(service.serviceName).getAt(index);
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AttendancePage(
                                  '${service.serviceName}_${box[kName]}');
                            },
                          ),
                        );
                        // Get.to();
                        attendantProvider.getServiceName(box[kName]);
                      },
                      title: Text(
                        box[kName],
                      ),
                      subtitle:
                          Text(getDateInStringWithSeconds(box[kReadableTime])),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          StartService.deleteServiceDialog(service.serviceName,
                              index, '${service.serviceName}_${box[kName]}');
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
