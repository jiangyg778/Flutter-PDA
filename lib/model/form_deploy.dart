class FormDeploy {
  String label;
  String placeholder;
  int cnpId;
  String workBills;
  String keyCode;
  int inputModel;
  bool isRequired;
  String field;
  String verifyMsg;
  String type;

  FormDeploy(
      {this.label,
        this.placeholder,
        this.cnpId,
        this.workBills,
        this.keyCode,
        this.inputModel,
        this.isRequired,
        this.field,
        this.verifyMsg,
        this.type});

  FormDeploy.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    placeholder = json['placeholder'];
    cnpId = json['cnpId'];
    workBills = json['workBills'];
    keyCode = json['keyCode'];
    inputModel = json['inputModel'];
    isRequired = json['isRequired'];
    field = json['field'];
    verifyMsg = json['verifyMsg'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['placeholder'] = this.placeholder;
    data['cnpId'] = this.cnpId;
    data['workBills'] = this.workBills;
    data['keyCode'] = this.keyCode;
    data['inputModel'] = this.inputModel;
    data['isRequired'] = this.isRequired;
    data['field'] = this.field;
    data['verifyMsg'] = this.verifyMsg;
    data['type'] = this.type;
    return data;
  }
}
