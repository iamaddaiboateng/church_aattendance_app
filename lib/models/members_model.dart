import 'package:churchtick/utils/strings.dart';

class MemberModel {
  String name,
      contact,
      location,
      cell,
      memberStatus,
      gender,
      dateOfBirth,
      bibleStudies,
      maritalStatus,
      nameOfSpouse,
      noChildren,
      otherHouseHold,
      contactPerson,
      occupation;
  int id;

  MemberModel(
      {this.name,
      this.contact,
      this.location,
      this.cell = 'unknown',
      this.memberStatus = 'member',
      this.gender,
      this.dateOfBirth,
      this.bibleStudies,
      this.maritalStatus,
      this.nameOfSpouse,
      this.noChildren,
      this.contactPerson,
      this.otherHouseHold,
      this.occupation,
      this.id});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kSName] = this.name;
    map[kSContact] = this.contact;
    map[kSLocation] = this.location;
    map[kCell] = this.cell;
    map[kMemberStatus] = this.memberStatus;
    map[kGender] = this.gender;
    map['id'] = this.id;
    map[kDateOfBirth] = this.dateOfBirth;
    map[kBibleStudies] = this.bibleStudies;
    map[kMarriageStatus] = this.maritalStatus;
    map[kNameOfSpouse] = this.nameOfSpouse;
    map[kNoChildren] = this.noChildren;
    map[kContactPerson] = this.contactPerson;
    map[kOtherHouseHold] = this.otherHouseHold;
    map[kOccupation] = this.occupation;

    return map;
  }

  MemberModel.fromMap(Map map)
      : this.name = map['name'],
        this.location = map['location'],
        this.contact = map['contact'],
        this.cell = map[kCell],
        this.memberStatus = map[kMemberStatus],
        this.gender = map[kGender],
        this.dateOfBirth = map[kDateOfBirth],
        this.bibleStudies = map[kBibleStudies],
        this.maritalStatus = map[kMarriageStatus],
        this.nameOfSpouse = map[kNameOfSpouse],
        this.noChildren = map[kNoChildren],
        this.contactPerson = map[kContactPerson],
        this.otherHouseHold = map[kOtherHouseHold],
        this.occupation = map[kOccupation];
}
