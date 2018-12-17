// {
// "children":[],
// "courseId":13,
// "id":408,
// "name":"鸿洋",
// "order":190000,
// "parentChapterId":407,
// "userControlSetTop":false,
// "visible":1
// }

class WanWXArticleInfo {
  List<dynamic> children;
  String courseId;
  String id;
  String name;
  String order;
  String parentChapterId;
  bool userControlSetTop;
  String visible;

  WanWXArticleInfo(this.children, this.courseId, this.id, this.name,
      this.order, this.parentChapterId, this.userControlSetTop, this.visible);

  WanWXArticleInfo.fromJson(Map<String, dynamic> json) {
    this.children = json['children'];
    this.courseId = json['courseId'];
    this.id = json['id'];
    this.name = json['name'];
    this.order = json['order'];
    this.parentChapterId = json['parentChapterId'];
    this.userControlSetTop = json['userControlSetTop'];
    this.visible = json['visible'];
  }

  Map<String, dynamic> toJson() => {
    'children': children,
    'courseId': courseId,
    'id': id,
    'name': name,
    'order': order,
    'parentChapterId': parentChapterId,
    'userControlSetTop': userControlSetTop,
    'visible': visible,
  };
}