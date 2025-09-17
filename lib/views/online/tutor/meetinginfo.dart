import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MeetingInfo extends StatefulWidget {
  final String id;
  final String meetingid;
  final String zoomLink;
  final String meetingpass;
  final String meetinghost;
  const MeetingInfo({super.key,required this.id,required this.zoomLink,required this.meetingid, required this.meetingpass,required this.meetinghost});

  @override
  State<MeetingInfo> createState() => _MeetingInfoState();
}

class _MeetingInfoState extends State<MeetingInfo> {
  bool isLoading = false;
  late FocusNode _zoomlink;
  late FocusNode _meetingId;
  late FocusNode _meetingPass;
  late FocusNode _meetingHost;
  TutorRepository repository = TutorRepository();
  String id = '';
  String zoom_link = '';
  String meeting_id = '';
  String meeting_password = '';
  String meeting_hostkey= '';
  void _onFocusChange() {
    setState(() {
      // Redraw the UI when the focus changes
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zoomlink = FocusNode();
    _zoomlink.addListener(_onFocusChange);
    _meetingId = FocusNode();
    _meetingId.addListener(_onFocusChange);
    _meetingPass = FocusNode();
    _meetingPass.addListener(_onFocusChange);
    _meetingHost = FocusNode();
    _meetingHost.addListener(_onFocusChange);
    id = widget.id;
    zoom_link = widget.zoomLink;
    meeting_id = widget.meetingid;
    meeting_password = widget.meetingpass;
    meeting_hostkey = widget.meetinghost;

     reusabletextfieldcontroller.zoomlink.text = zoom_link.isNotEmpty ? zoom_link : "";
  reusabletextfieldcontroller.meetingid.text = meeting_id.isNotEmpty ? meeting_id : "";
  reusabletextfieldcontroller.meetingpass.text = meeting_password.isNotEmpty ? meeting_password : "";
  reusabletextfieldcontroller.meetinghost.text = meeting_hostkey.isNotEmpty ? meeting_hostkey : "";
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _zoomlink.dispose();
    _zoomlink.removeListener(_onFocusChange);
    _meetingId.dispose();
    _meetingId.removeListener(_onFocusChange);
    _meetingPass.dispose();
    _meetingPass.removeListener(_onFocusChange);
    _meetingHost.dispose();
    _meetingHost.removeListener(_onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(context, Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reusableText("Meeting Information",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          reusableOnlineTextField(
                                  context,
                                  reusabletextfieldcontroller.zoomlink,
                                  'Zoom Link',
                                  _zoomlink.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _zoomlink,
                                  () {
                                    _zoomlink.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_meetingId);
                                  },
                                  (val) => zoom_link = val,
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableOnlineTextField(
                                  context,
                                  reusabletextfieldcontroller.meetingid,
                                  'Meeting Id',
                                  _meetingId.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _meetingId,
                                  () {
                                    _meetingId.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_meetingPass);
                                  },
                                  (p0) => meeting_id = p0,
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableOnlineTextField(
                                  context,
                                  reusabletextfieldcontroller.meetingpass,
                                  'Meeting Password',
                                  _meetingPass.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _meetingPass,
                                  () {
                                    _meetingPass.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_meetingHost);
                                  },
                                  (p0) => meeting_password = p0,
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableOnlineTextField(
                                  context,
                                  reusabletextfieldcontroller.meetinghost,
                                  'Meeting hostKey',
                                  _meetingHost.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _meetingHost,
                                  () {
                                    _meetingHost.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_meetingHost);
                                  },
                                  (p0) => meeting_hostkey = p0,
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .02),
                                reusableBtn(context, 'Update', ()async {
                                  setState(() => isLoading = true);

  try {
    await repository.updateMeetingInfo(
      id: id,
      zoomLink: zoom_link,
      meetingId: meeting_id,
      meetingPass: meeting_password,
      meetingHost: meeting_hostkey,
    );

    Utils.snakbarSuccess(context, 'Meeting Info Updated');
    Navigator.pop(context,true);
  } catch (e) {
    Utils.snakbarSuccess(context, 'Error $e');
  }

  setState(() => isLoading = false);
                                }),
        ]
      ),
    ), reusableloadingrow(context, isLoading));
  }
}