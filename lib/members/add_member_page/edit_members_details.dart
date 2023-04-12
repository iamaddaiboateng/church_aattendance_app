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

class EditMembersDetailsPage extends StatefulWidget {
  final MemberModel model;

  EditMembersDetailsPage(this.model);

  @override
  _EditMembersDetailsPageState createState() => _EditMembersDetailsPageState();
}

class _EditMembersDetailsPageState extends State<EditMembersDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nameController.text = widget.model.name;
      contactController.text = widget.model.contact;
      locationController.text = widget.model.location;
      spouseController.text = widget.model.nameOfSpouse;
      noChildController.text = widget.model.noChildren;
      occupationController.text = widget.model.occupation;
      otherHouseHoldController.text = widget.model.otherHouseHold;
      contactPersonController.text = widget.model.contactPerson;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final member = Provider.of<ServiceDetailsController>(context);
    member.changeGenderStatus(widget.model.gender);
    member.changeMemberShipStatus(widget.model.memberStatus);
    member.setMaritalStatus(widget.model.maritalStatus);
    member.selectBibleStudy(widget.model.bibleStudies);

    return Consumer<ServiceDetailsController>(
      builder: (_, service, __) {
        return ModalProgressHUD(
          inAsyncCall: service.inProgress,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Edit Details'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    print(service.newUserId);

                    MemberModel model = MemberModel(
                        id: widget.model.id,
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
                      service.editMembersDetails(
                        model: model,
                        nameController: nameController,
                        contactController: contactController,
                        locationController: locationController,
                        spouseController: spouseController,
                        noChildController: noChildController,
                        contactPersonController: contactPersonController,
                        occupationController: occupationController,
                        otherHouseHoldController: otherHouseHoldController,
                      );
                  },
                )
              ],
            ),
            body: Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  CustomTextFormField(
                    textCapitalization: TextCapitalization.words,
                    color: Colors.teal,
                    hintTitle: kName,
                    labelTitle: kName,
                    controller: nameController,
                  ),
                  CustomTextField(
                    textInputType: TextInputType.phone,
                    color: Colors.teal,
                    hintTitle: kContact,
                    labelTitle: kContact,
                    controller: contactController,
                  ),
                  CustomTextField(
                    color: Colors.teal,
                    hintTitle: kLocation,
                    labelTitle: kLocation,
                    controller: locationController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RaisedButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Text(widget.model.dateOfBirth),
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
                      picked: service.bibleStudy,
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
