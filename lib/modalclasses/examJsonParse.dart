class ExamJsonParse{
  exam? examJsonParse;
  ExamJsonParse({required Map map})
  {
    exam e1=exam(map: map['data'][0]);
    examJsonParse=e1;
  }
}
class exam {
  String? examName;
  String? applyDate;
  String? lastApplyDate;
  String? examDate;
  String? educationQualification;
  String? minAge;
  String? maxAge;
  String? urobcFees;
  String? scstpwdFees;
  String? paymentMethod;
  String? selectionProcess;
  String? oldNotificationLink;
  String? onlineApplyLink;
  String? newNotificationLink;
  String? officialWebsiteLink;

  exam({required Map map})
  {
    examName=map['exam_name'];
    applyDate=map['apply_date'];
    lastApplyDate=map['last_apply_date'];
    examDate=map['exam_date'];
    educationQualification=map['education_qualification'];
    minAge=map['min_age'];
    maxAge=map['max_age'];
    urobcFees=map['urobc_fees'];
    scstpwdFees=map['scstpwd_fees'];
    paymentMethod=map['payment_method'];
    selectionProcess=map['selection_process'];
    oldNotificationLink=map['old_notification_link'];
    onlineApplyLink=map['online_apply_link'];
    newNotificationLink=map['new_notification_link'];
    officialWebsiteLink=map['official_website_link'];
  }
}