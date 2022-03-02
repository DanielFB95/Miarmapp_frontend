class CreatePostResponse {
  CreatePostResponse({
    required this.id,
    required this.message,
    required this.file,
    required this.resizedFile,
    required this.userFullName,
    required this.username,
    required this.userAvatar,
  });
  late final String id;
  late final String message;
  late final String file;
  late final String resizedFile;
  late final String userFullName;
  late final String username;
  late final String userAvatar;

  CreatePostResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    file = json['file'];
    resizedFile = json['resizedFile'];
    userFullName = json['userFullName'];
    username = json['username'];
    userAvatar = json['userAvatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['message'] = message;
    _data['file'] = file;
    _data['resizedFile'] = resizedFile;
    _data['userFullName'] = userFullName;
    _data['username'] = username;
    _data['userAvatar'] = userAvatar;
    return _data;
  }
}
