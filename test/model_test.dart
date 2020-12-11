
import 'package:flutter_cresenity/app/model/response_model.dart';
import 'package:flutter_cresenity/app/model/response_pagination_model.dart';
import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/helper/arr.dart';
import 'package:flutter_test/flutter_test.dart';




class PostModel extends AbstractDataModel {

  int postId;
  @override
  Map<String, dynamic > toJson() {
    return {'postId':postId};
  }

  PostModel.fromJson(Map map) {
    postId = map['postId'];
  }

}


void main() {
  Map<String,dynamic> data = {
    'errCode':0,
    'errMessage':'',
    'data': {
      'total':3,
      'lastPage':1,
      'perPage':10,
      'currentPage':1,
      'items': [{
        'postId':1
      },
        {
          'postId':2
        },
        {
          'postId':3
        }]
    }
  }; //from api

  test("Response Model", () {
    ResponseModel<PaginationDataModel<PostModel>> response =ResponseModel<PaginationDataModel<PostModel>>.fromJson(data, (item) {
      return PaginationDataModel<PostModel>.fromJson(item, (postItem) {
        return PostModel.fromJson(postItem);
      });

    });
    expect(response.data.items[1].postId,2);
  });

  test("Response Pagination Model", () {
    ResponsePaginationModel<PostModel> response =ResponsePaginationModel<PostModel>.fromJson(data, (item) {
      return PostModel.fromJson(item);

    });

    expect(response.data.items[1].postId,2);
    expect(response.data.items[5]?.postId,null);

  });
  /*

  */


}