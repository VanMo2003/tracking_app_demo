import 'package:get/get.dart';
import '../views/custom_snackbar.dart';
import '../data/models/body/posts/comment.dart';
import '../data/models/body/posts/like.dart';
import '../data/models/body/posts/post.dart';
import '../data/models/body/search.dart';
import '../data/repository/post_repo.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';

import '../data/models/body/posts/content.dart';
import '../data/api/api_exception.dart';

class PostController extends GetxController implements GetxService {
  final PostRepo postRepo;
  PostController({required this.postRepo});

  Posts? _posts;
  Posts? _postsByUser;
  Search? _search = Search(
    keyWord: "",
    pageIndex: 1,
    size: Dimensions.SIZE_OF_PAGE_POSTS,
    status: 0,
  );
  Search? _searchByUser = Search(
    keyWord: "",
    pageIndex: 1,
    size: Dimensions.SIZE_OF_PAGE_POSTS,
    status: 0,
  );
  int _currentPage = 1;
  int _currentPageByUser = 1;
  bool _last = false;
  bool _lastByUser = false;
  List<Content>? _contents;
  List<Content>? _contentsByUser;

  Posts? get posts => _posts;
  Posts? get postsByUser => _postsByUser;
  Search? get search => _search;
  Search? get searchByUser => _searchByUser;
  int get currentPage => _currentPage;
  int get currentPageByUser => _currentPageByUser;
  bool get last => _last;
  bool get lastByUser => _lastByUser;
  List<Content>? get contents => _contents;
  List<Content>? get contentsByUser => _contentsByUser;

  void getPosts() async {
    if (_currentPage != 1) {
      updateSearchKey(_currentPage);
    }
    _currentPage++;
    Response response = await postRepo.getPosts(_search!);
    if (response.statusCode == 200) {
      _contents ??= [];
      _posts = Posts.fromJson(response.body);
      if (_posts!.last!) {
        _last = true;
      }
      for (var content in _posts!.content!)  {
        _contents!.add(content);
      }
    } else {
      ApiException.checkException(response.statusCode);
    }

    update();
  }

  void getPostsByUser() async {
    if (_currentPageByUser != 1) {
      updateSearchKey(_currentPageByUser, isAll: false);
    }
    _currentPageByUser++;
    Response response = await postRepo.getPostsByUser(_searchByUser!);
    if (response.statusCode == 200) {
      _contentsByUser ??= [];
      _postsByUser = Posts.fromJson(response.body);
      if (_postsByUser!.last!) {
        _lastByUser = true;
      }
      for (var element in _postsByUser!.content!) {
        _contentsByUser!.add(element);
      }
    } else {
      ApiException.checkException(response.statusCode);
    }

    update();
  }

  void addContent(Content content) async {
    Response response = await postRepo.addContent(content);
    if (response.statusCode == 200) {
      var content = Content.fromJson(response.body["data"]);
      if(_contentsByUser != null) {
        _contentsByUser!.add(content);
      }
      if(_contents != null) {
        _contents!.add(content);
      }
      showCustomSnackBar(KeyLanguage.addSuccess.tr, isError: false);
    } else {
      ApiException.checkException(response.statusCode);
    }

    update();
  }

  void likePost(int id) async {
    Response response = await postRepo.likePost(id);
    if (response.statusCode == 200) {
      if (_contents != [] && _contents != null) {
        var content =
            _contents!.where((element) => element.id == id).firstOrNull;
        if (content != null) {
          content.likes ??= [];
          content.likes!.add(Likes.fromJson(response.body));
        }
      }
      if (_contentsByUser != [] && _contentsByUser != null) {
        var contentByUser =
            _contentsByUser!.where((element) => element.id == id).firstOrNull;
        if (contentByUser != null) {
          contentByUser.likes ??= [];
          contentByUser.likes!.add(Likes.fromJson(response.body));
        }
      }
    } else {
      ApiException.checkException(response.statusCode);
    }

    update();
  }

  void commentPost(int id, Comments body) async {
    Response response = await postRepo.commentPost(id, body);
    if (response.statusCode == 200) {
      if (_contents != []) {
        var content =
            _contents!.where((element) => element.id == id).firstOrNull;
        if (content != null) {
          content.comments ??= [];
          content.comments!.add(Comments.fromJson(response.body));
        }
      }

      if (_contentsByUser != []) {
        var contentByUser =
            _contentsByUser!.where((element) => element.id == id).firstOrNull;
        if (contentByUser != null) {
          contentByUser.comments ??= [];
          contentByUser.comments!.add(Comments.fromJson(response.body));
        }
      }
    } else {
      ApiException.checkException(response.statusCode);
    }

    update();
  }

  void updateSearchKey(int pageIndex, {bool isAll = true}) {
    isAll ?
    _search = Search(
      keyWord: "",
      pageIndex: pageIndex,
      size: Dimensions.SIZE_OF_PAGE_POSTS,
      status: 0,
    ) : _searchByUser = Search(
      keyWord: "",
      pageIndex: pageIndex,
      size: Dimensions.SIZE_OF_PAGE_POSTS,
      status: 0,
    );
  }


  void clearData() {
    _posts = null;
    _postsByUser = null;
    _search = Search(
      keyWord: "",
      pageIndex: 1,
      size: Dimensions.SIZE_OF_PAGE_POSTS,
      status: 0,
    );
    _searchByUser = Search(
      keyWord: "",
      pageIndex: 1,
      size: Dimensions.SIZE_OF_PAGE_POSTS,
      status: 0,
    );
    _currentPage = 1;
    _currentPageByUser = 1;
    _last = false;
    _lastByUser = false;
    _contents = null;
    _contentsByUser = null;
  }
}
