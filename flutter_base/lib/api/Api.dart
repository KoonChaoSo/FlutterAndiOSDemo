// 干货api：https://gank.io/api
// 玩Android api：http://www.wanandroid.com/blog/show/2
class Api {
  ///************************* 干货 *****************************/
  static final String HOST_GANK = "http://gank.io/api/";

  // 数据类型：福利 | Android | iOS | 休息视频 | 拓展资源 | 前端
  // 个数： 数字，大于0
  // 例：http://gank.io/api/data/all/20/2
  static final String GANK_FEED = HOST_GANK + "data/";

  // 搜索
  static final String GANK_SEARCH = HOST_GANK + "query/";

  // 今日干货
  static final String GANK_TODAY = HOST_GANK + "today";

  //https://gank.io/api/data/福利/20/1（页数／页码）
  //{
  // "_id":"5be14edb9d21223dd50660f8",
  // "createdAt":"2018-11-06T08:20:43.656Z",
  // "desc":"2018-11-06",
  // "publishedAt":"2018-11-06T00:00:00.0Z",
  // "source":"web",
  // "type":"\u798f\u5229",
  // "url":"https://ws1.sinaimg.cn/large/0065oQSqgy1fwyf0wr8hhj30ie0nhq6p.jpg",
  // "used":true,
  // "who":"lijinshanmx"
  // }
  static final String GANK_WELFARE = GANK_FEED + "福利/";

  ///****************************** 玩Android *******************************/
  static const String HOST_WAN = "http://www.wanandroid.com/";

  //首页banner
  static const String WAN_BANNER = HOST_WAN + "banner/json";

  //首页文章列表 http://www.wanandroid.com/article/list/0/json
  // 知识体系下的文章http://www.wanandroid.com/article/list/0/json?cid=60
  static const String WAN_ARTICLE_LIST = HOST_WAN + "article/list/";

  //收藏文章列表
  static const String WAN_COLLECT_LIST = HOST_WAN + "lg/collect/list/";

  //搜索
  static const String WAN_QUERY = HOST_WAN + "article/query/";

  //收藏,取消收藏
  static const String WAN_COLLECT = HOST_WAN + "lg/collect/";
  static const String WAN_UNCOLLECT_ORIGINID =
      HOST_WAN + "lg/uncollect_originId/";

  //我的收藏列表中取消收藏
  static const String WAN_UNCOLLECT_LIST = HOST_WAN + "lg/uncollect/";

  //登录,注册
  static const String WAN_LOGIN = HOST_WAN + "user/login";
  static const String WAN_REGISTER = HOST_WAN + "user/register";

  //知识体系
  static const String WAN_TREE = HOST_WAN + "tree/json";

  //公众号数据
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
  static const String WAN_WXARTICLE = HOST_WAN + "wxarticle/chapters/json";

  //{
  // "apkLink":"",
  // "author":"郭霖",
  // "chapterId":409,
  // "chapterName":"郭霖",
  // "collect":false,
  // "courseId":13,
  // "desc":"",
  // "envelopePic":"",
  // "fresh":false,
  // "id":7492,
  // "link":"https://mp.weixin.qq.com/s/It8xSD_XOc7ceClR12ww2Q",
  // "niceDate":"2018-11-09",
  // "origin":"",
  // "projectLink":"",
  // "publishTime":1541692800000,
  // "superChapterId":408,
  // "superChapterName":"公众号",
  // "tags":[{"name":"公众号","url":"/wxarticle/list/409/1"}],
  // "title":"使用Android Studio查看并调试Android源码",
  // "type":0,
  // "userId":-1,
  // "visible":1,
  // "zan":0
  // }

  // http://wanandroid.com/wxarticle/list/409/1/json    409:chapterId, 1:页码
  static const String WAN_WXARTICLE_LIST = HOST_WAN + "wxarticle/list/";
}
