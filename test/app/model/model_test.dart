


import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/app/model/collection_data_model.dart';
import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/app/model/response_list_model.dart';
import 'package:flutter_cresenity/app/model/response_model.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_test/flutter_test.dart';

class PostModel extends AbstractDataModel{
  int postId;
  String title;
  String content;

  PostModel.fromJson(Map map) {
    postId = map['postId'];
    title = map['title'];
    content = map['content'];
  }


  Map<String,dynamic> toJson() {
    return {
      'postId':postId,
      'title':title,
      'content':content,

    };
  }
}

void main() async {
  await CF.init();
  CF.model.registerBuilder(PostModel, (map) {
    return PostModel.fromJson(map);
  });

  test('BrokenModel', (){
    Map<String,dynamic> json = {
      'errCode':0,
      'errMessage':'def',
    };

    ResponseModel<CollectionDataModel> responseModel = ResponseModel.fromJson(json);

    expect(responseModel.errCode,0);
    expect(responseModel.errMessage,'def');


  });

  test('CollectionDataModel', (){
      Map<String,dynamic> json = {
        'errCode':0,
        'errMessage':'',
        'data': {
            'sessionId':'ABCDEF'
        }
      };

      ResponseModel<CollectionDataModel> responseModel = ResponseModel.fromJson(json);

      expect(responseModel.errCode,0);
      expect(responseModel.data['sessionId'],'ABCDEF');


  });


  test('CollectionDataModel', (){
    Map<String,dynamic> json = {
      'errCode':0,
      'errMessage':'',
      'data': {
        'postId': 1,
        'title':'Judul',
        'content':'Body',
      }
    };

    ResponseModel<PostModel> responseModel = ResponseModel.fromJson(json);

    expect(responseModel.errCode,0);
    expect(responseModel.data.postId,1);


  });


  test('ResponseListModel', (){

    Map<String,dynamic> json = {
      'errCode':0,
      'errMessage':'',
      'data': [
        {
          'postId': 1,
          'title':'Judul 1',
          'content':'Body 1',
        },
        {
          'postId': 2,
          'title':'Judul 2',
          'content':'Body 2',
        },
        {
          'postId': 3,
          'title':'Judul 3',
          'content':'Body 3',
        },

      ]

    };

    ResponseListModel<PostModel> responseModel = ResponseListModel<PostModel>.fromJson(json);


    expect(responseModel.errCode,0);
    expect(responseModel.data[2].content,'Body 3');



  });

  test('PaginationDataModel', (){

    Map<String,dynamic> json = {
      'errCode':0,
      'errMessage':'',
      'data': {
        'total':3,
        'lastPage':1,
        'perPage':10,
        'currentPage':1,
        'items': [
          {
            'postId': 1,
            'title':'Judul 1',
            'content':'Body 1',
          },
          {
            'postId': 2,
            'title':'Judul 2',
            'content':'Body 2',
          },
          {
            'postId': 3,
            'title':'Judul 3',
            'content':'Body 3',
          },

        ]

      }
    };

    ResponseModel<PaginationDataModel<PostModel>> responseModel = ResponseModel<PaginationDataModel<PostModel>>.fromJson(json, (map) {
      return PaginationDataModel<PostModel>.fromJson(map);
    });

    expect(responseModel.errCode,0);
    expect(responseModel.data.perPage,10);
    expect(responseModel.data.items[1].content,'Body 2');



  });



}