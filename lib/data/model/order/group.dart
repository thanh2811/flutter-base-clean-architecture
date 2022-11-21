import 'dart:convert';

List<Group> groupFromJson(String str) =>
    List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Group {
  Group({
    this.employeeId,
    this.unitTreeGroupId,
    this.unitTreeGroup,
  });

  String? employeeId;
  String? unitTreeGroupId;
  UnitTreeGroup? unitTreeGroup;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        employeeId: json["employeeId"],
        unitTreeGroupId: json["unitTreeGroupId"],
        unitTreeGroup: UnitTreeGroup.fromJson(json["unitTreeGroup"]),
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "unitTreeGroupId": unitTreeGroupId,
        "unitTreeGroup": unitTreeGroup!.toJson(),
      };
}

class UnitTreeGroup {
  UnitTreeGroup({
    this.unitTreeGroupCode,
    this.name,
    this.workScheduleType,
    this.type,
    this.supervise,
    this.isLeaf,
    this.quantityChildrenOfNode,
    this.heightOfNode,
    this.levelOfNode,
    this.employeeUnitTreeGroup,
    this.id,
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.parentNodeId,
  });

  String? unitTreeGroupCode;
  String? name;
  int? workScheduleType;
  int? type;
  bool? supervise;
  bool? isLeaf;
  int? quantityChildrenOfNode;
  int? heightOfNode;
  int? levelOfNode;
  List<dynamic>? employeeUnitTreeGroup;
  String? id;
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  String? parentNodeId;

  factory UnitTreeGroup.fromJson(Map<String, dynamic> json) => UnitTreeGroup(
        unitTreeGroupCode: json["unitTreeGroup_Code"],
        name: json["name"],
        workScheduleType: json["workScheduleType"],
        type: json["type"],
        supervise: json["supervise"],
        isLeaf: json["isLeaf"],
        quantityChildrenOfNode: json["quantityChildrenOfNode"],
        heightOfNode: json["heightOfNode"],
        levelOfNode: json["levelOfNode"],
        employeeUnitTreeGroup:
            List<dynamic>.from(json["employeeUnitTreeGroup"].map((x) => x)),
        id: json["id"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        parentNodeId: json["parentNodeId"],
      );

  Map<String, dynamic> toJson() => {
        "unitTreeGroup_Code": unitTreeGroupCode,
        "name": name,
        "workScheduleType": workScheduleType,
        "type": type,
        "supervise": supervise,
        "isLeaf": isLeaf,
        "quantityChildrenOfNode": quantityChildrenOfNode,
        "heightOfNode": heightOfNode,
        "levelOfNode": levelOfNode,
        "employeeUnitTreeGroup":
            List<dynamic>.from(employeeUnitTreeGroup!.map((x) => x)),
        "id": id,
        "createdBy": createdBy,
        "createdDate": createdDate!.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate!.toIso8601String(),
        "parentNodeId": parentNodeId,
      };
}
