import 'package:get/get.dart';
import '../data/models/body/search.dart';
import '../data/api/api_exception.dart';
import '../data/repository/search_repo.dart';
import '/utils/dimensions.dart';
import '../data/models/response/user_res.dart';

class SearchByPageController extends GetxController implements GetxService {
  final SearchRepo searchRepo;

  SearchByPageController({required this.searchRepo});

  Search? _searchKey = Search(
    keyWord: "",
    pageIndex: 1,
    size: Dimensions.SIZE_OF_PAGE_USERS,
    status: 0,
  );
  List<dynamic>? _listResult;
  bool _isPageLast = false;

  Search? get searchKey => _searchKey;
  List<dynamic>? get listResult => _listResult;
  bool get isPageLast => _isPageLast;

  void getAllUser({int? pageIndex}) async {
    updateSearchKey(pageIndex ?? 1);
    Response response = await searchRepo.getAll(searchKey!);
    if (response.statusCode == 200) {
      _listResult ??= [];
      for (var element in response.body["content"]) {
        UserRes user = UserRes.fromJson(element);
        _listResult?.add(user);
      }

      _isPageLast = response.body["last"];
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
  }

  void updateSearchKey(int pageIndex) {
    _searchKey = Search(
      keyWord: "",
      pageIndex: pageIndex,
      size: Dimensions.SIZE_OF_PAGE_USERS,
      status: 0,
    );
  }

  void clearData() {
    _searchKey = Search(
      keyWord: "",
      pageIndex: 1,
      size: Dimensions.SIZE_OF_PAGE_USERS,
      status: 0,
    );
    _listResult = null;
    _isPageLast = false;
  }
}
