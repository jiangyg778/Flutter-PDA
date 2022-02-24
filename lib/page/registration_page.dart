import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bili_app/model/form_deploy.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_input.dart';
import 'package:flutter_easy_permission/constants.dart';
import 'package:flutter_easy_permission/flutter_easy_permission.dart';
import 'package:flutter_scankit/flutter_scankit.dart';
import 'customized_view.dart';

//权限
const _permissionGroup = const [PermissionGroup.Camera, PermissionGroup.Photos];

//权限
const _permissions = const [
  Permissions.READ_EXTERNAL_STORAGE,
  Permissions.CAMERA
];

///注册页面
class RegistrationPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;

  const RegistrationPage({Key key, this.onJumpToLogin}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  List<FormDeploy> dataList = []; //接口返回的配置信息
  Map dataForm = {}; //表达提交的数据
  FlutterScankit scanKit;
  String code = "123";
  bool isCustom;

  @override
  void initState() {
    super.initState();
    final data = [
      {
        "label": "仓库编码",
        "placeholder": '请输入仓库编码',
        "cnpId": 1,
        "workBills": "作业单据",
        "keyCode": "222",
        "inputModel": 0,
        "isRequired": true,
        "field": "warehouse",
        "verifyMsg": "仓库编码不能为空"
      },
      {
        "label": "商家名称",
        "placeholder": '请输入仓库编码',
        "cnpId": 1,
        "workBills": "作业单据",
        "keyCode": "222",
        "inputModel": 0,
        "isRequired": false,
        "field": "merchant",
        "verifyMsg": "仓库编码不能为空"
      },
      {
        "label": "商家名称",
        "placeholder": '请输入仓库编码',
        "cnpId": 1,
        "workBills": "作业单据",
        "keyCode": "222",
        "inputModel": 0,
        "isRequired": false,
        "field": "merchant",
        "verifyMsg": "仓库编码不能为空"
      },
      {
        "label": "商家名称",
        "placeholder": '请输入仓库编码',
        "cnpId": 1,
        "workBills": "作业单据",
        "keyCode": "222",
        "inputModel": 0,
        "isRequired": false,
        "field": "merchant",
        "verifyMsg": "仓库编码不能为空"
      },
    ];
    // 模拟请求赋值
    setState(() {
      for (var sub in data) {
        dataList.add(FormDeploy.fromJson(sub));
      }
    });
    print("123 ${dataList[0].label}");

    ///
    ///
    scanKit = FlutterScankit();
    scanKit.addResultListen((val) {
      setState(() {
        code = val;
      });
    });

    FlutterEasyPermission().addPermissionCallback(
        onGranted: (requestCode, perms, perm) {
          isCustom ? newPage(context) : startScan();
        },
        onDenied: (requestCode, perms, perm, isPermanent) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("PDA", "登录", widget.onJumpToLogin),
      body: Container(
        child: ListView(
            //自适应键盘弹起，防止遮挡
            children: List.generate(dataList.length, (index) {
          bool isRequired = dataList[index].isRequired;
          return LoginInput(
            "${dataList[index].label}",
            "${dataList[index].placeholder}",
            isRequired: isRequired,
            keyboardType: TextInputType.number,
            lineStretch: true,
            onChanged: (text) {
              // 动态添加字段和值到dataForm
              dataForm.addAll({"${dataList[index].field}": text});
            },
          );
        })),
      ),
      bottomNavigationBar: new BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        height: 40,
                        onPressed: () async {
                          isCustom = false;
                          if (!await FlutterEasyPermission.has(
                              perms: _permissions,
                              permsGroup: _permissionGroup)) {
                            FlutterEasyPermission.request(
                                perms: _permissions,
                                permsGroup: _permissionGroup);
                          } else {
                            startScan();
                          }
                        },
                        disabledColor: primary[50],
                        color: Colors.grey,
                        child: Text('取消',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16))),
                    SizedBox(width: 20),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        height: 40,
                        onPressed: () {
                          checkParams();
                          print("$dataForm,12345");
                        },
                        disabledColor: primary[50],
                        color: Colors.blue,
                        child: Text('提交',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16))),
                    SizedBox(width: 20),
                    Text(code)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> startScan() async {
    try {
      await scanKit.startScan(scanTypes: [ScanTypes.ALL]);
    } on PlatformException {}
  }

  Future<void> newPage(BuildContext context) async {
    var code = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CustomizedView();
    }));

    setState(() {
      this.code = code ?? "";
    });
  }

  void send() async {
    showToast('校验通过');
  }

  bool checkParams() {
    for (var item in dataList) {
      print("${item.field},333333");
      if (item.isRequired) {
        if (dataForm[item.field] != null) {
          if (dataForm[item.field] != '') {
          } else {
            showWarnToast("${item.verifyMsg}");
            return false;
          }
        } else {
          showWarnToast("${item.verifyMsg}");
          return false;
        }
      }
    }
    send();
  }
}
