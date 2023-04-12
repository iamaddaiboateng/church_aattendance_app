import 'package:churchtick/core/widgets/column_card.dart';
import 'package:churchtick/core/widgets/costum_text_field.dart';
import 'package:churchtick/core/widgets/costum_text_form_field.dart';
import 'package:churchtick/members/controller/members_controller.dart';
import 'package:churchtick/models/members_model.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

TextEditingController nameController = TextEditingController();
TextEditingController contactController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController spouseController = TextEditingController();
TextEditingController noChildController = TextEditingController();
TextEditingController occupationController = TextEditingController();
TextEditingController otherHouseHoldController = TextEditingController();
TextEditingController contactPersonController = TextEditingController();

class AddSingleUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final lastNumber = Provider.of<ServiceDetailsController>(context);

    print(lastNumber.newUserId);

    return Consumer<ServiceDetailsController>(
      builder: (_, service, __) {
        return ModalProgressHUD(
          inAsyncCall: service.inProgress,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Add Single Member'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    MemberModel model = MemberModel(
                        id: service.memberBox.length + 1,
                        name: nameController.text,
                        contact: contactController.text,
                        memberStatus: service.memberStatusLabel,
                        gender: service.genderStatusLabel,
                        occupation: occupationController.text ?? '',
                        noChildren: noChildController.text ?? "",
                        maritalStatus: service.marriage,
                        bibleStudies: service.memberCell,
                        cell: service.memberCell,
                        dateOfBirth: service.date,
                        nameOfSpouse: spouseController.text,
                        otherHouseHold: otherHouseHoldController.text ?? '',
                        contactPerson: contactPersonController.text ?? '',
                        location: locationController.text);
                    if (formKey.currentState.validate())
                      service.addSingleMembers(
                          model,
                          nameController,
                          contactController,
                          locationController,
                          spouseController,
                          noChildController,
                          occupationController,
                          otherHouseHoldController,
                          contactPersonController);
                  },
                )
              ],
            ),
            body: Form(
              key: formKey,
              child: ListView(
                key: PageStorageKey<String>('form'),
                padding: EdgeInsets.all(10.0),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.teal,
                        size: 20.0,
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          textCapitalization: TextCapitalization.words,
                          color: Colors.teal,
                          hintTitle: kName,
                          labelTitle: kName,
                          controller: nameController,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Colors.teal,
                        size: 20.0,
                      ),
                      Expanded(
                        child: CustomTextField(
                          textInputType: TextInputType.phone,
                          color: Colors.teal,
                          hintTitle: kContact,
                          labelTitle: kContact,
                          controller: contactController,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.teal,
                        size: 20.0,
                      ),
                      Expanded(
                        child: CustomTextField(
                          color: Colors.teal,
                          hintTitle: kLocation,
                          labelTitle: kLocation,
                          controller: locationController,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RaisedButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Text(service.date),
                      onPressed: () {
                        service.pickDate(context);
                      },
                    ),
                  ),
                  ColumnCard(
                    rowChildOne: Text('Membership Status'),
                    child: RadioButtonGroup(
                      picked: service.memberStatusLabel,
                      labels: service.membershipLabels,
                      onChange: (String label, int index) {
                        service.changeMemberShipStatus(label);
                      },
                    ),
                  ),
                  ColumnCard(
                    rowChildOne: Text('Select Gender'),
                    child: RadioButtonGroup(
                      picked: service.genderStatusLabel,
                      labels: service.genderLabels,
                      onChange: (String label, int index) {
                        service.changeGenderStatus(label);
                      },
                    ),
                  ),
                  ColumnCard(
                    rowChildOne: Text('Select Cell'),
                    child: RadioButtonGroup(
                      picked: service.memberCell,
                      labels: service.cells,
                      onChange: (String label, int index) {
                        service.selectCell(label);
                      },
                    ),
                  ),
                  ColumnCard(
                    rowChildOne: Text('Marital Status'),
                    child: RadioButtonGroup(
                      picked: service.marriage,
                      labels: service.marriageStatus,
                      onChange: (String label, int index) {
                        service.setMaritalStatus(label);
                      },
                    ),
                  ),
                  CustomTextField(
                    controller: spouseController,
                    hintTitle: kNameOfSpouse.toUpperCase(),
                  ),
                  CustomTextField(
                    controller: noChildController,
                    textInputType: TextInputType.number,
                    hintTitle: kNoChildren.toUpperCase(),
                  ),
                  CustomTextField(
                    controller: occupationController,
                    hintTitle: kOccupation.toUpperCase(),
                  ),
                  CustomTextField(
                    controller: otherHouseHoldController,
                    hintTitle: kOtherHouseHold.toUpperCase(),
                  ),
                  CustomTextField(
                    controller: contactPersonController,
                    hintTitle: kContactPerson.toUpperCase(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
