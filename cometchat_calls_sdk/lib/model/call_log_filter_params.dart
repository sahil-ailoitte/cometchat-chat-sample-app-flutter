class CallLogFilterParams {
  int perPage = -1;
  int page = -1;
  String? mode;
  String? type;
  String? status;
  String? direction;
  bool hasRecordings = false;
  String? uid;
  String? guid;

  void setDirection(String direction) {
    this.direction = direction;
  }

  String? getStatus() {
    return status;
  }

  void setStatus(String status) {
    this.status = status;
  }

  void setType(String type) {
    this.type = type;
  }

  void setPerPage(int perPage) {
    this.perPage = perPage;
  }

  void setPage(int page) {
    this.page = page;
  }

  void setMode(String mode) {
    this.mode = mode;
  }

  void setHasRecordings(bool hasRecordings) {
    this.hasRecordings = hasRecordings;
  }

  void setUid(String uid) {
    this.uid = uid;
  }

  void setGuid(String guid) {
    this.guid = guid;
  }

  Map<String, String> toMap() {
    Map<String, String> map = {};
    if (perPage != -1) map['perPage'] = perPage.toString();
    if (page != -1) map['page'] = page.toString();
    if (mode != null) map['mode'] = mode!;
    if (type != null) map['type'] = type!;
    if (status != null) map['status'] = status!;
    if (direction != null) map['direction'] = direction!;
    if (uid != null) map['uid'] = uid!;
    if (guid != null) map['guid'] = guid!;
    if (hasRecordings) {
      map['hasRecording'] = 'true';
    } else {
      map['hasRecording'] = 'false';
    }
    return map;
  }


}