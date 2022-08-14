import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/app/model/response_pagination_model.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/config/config.dart';
import 'package:flutter_cresenity/http/response.dart';
import 'package:flutter_test/flutter_test.dart';

class OutletTypeModel extends AbstractDataModel {
  String icon;
  String name;
  String outletTypeId;
  String parent;

  OutletTypeModel({
    required this.icon,
    required this.name,
    required this.outletTypeId,
    required this.parent,
  });

  factory OutletTypeModel.fromJson(Map<String, dynamic> json) {
    return OutletTypeModel(
      icon: json['icon'] ?? '',
      name: json['name'],
      outletTypeId: json['outletTypeId'],
      parent: json['parent'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'name': name,
      'outletTypeId': outletTypeId,
      'parent': parent,
    };
  }
}

void main() async {
  await CF.init((Config config) {
    config.disableForConsole();
  });
  CF.model.registerBuilderMany(
      {OutletTypeModel: (json) => OutletTypeModel.fromJson(json)});

  test('PaginationModel', () {
    String jsonString =
        '{"errCode":0,"errMessage":"","data":{"total":11,"lastPage":1,"perPage":"11","currentPage":1,"items":[{"outletTypeId":"3","parent":"","name":"Toko Kayu","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/419\/20220808fd9e2ae32b53addc06c63208be3aaa43.png"},{"outletTypeId":"2","parent":"","name":"Toko Keramik","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/420\/2022080829d74915e1b323676bfc28f91b3c4802.png"},{"outletTypeId":"7","parent":"","name":"Toko Besi","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/431\/20220808852c296dfa59522f563aef29d8d0adf6.png"},{"outletTypeId":"6","parent":"","name":"Toko Cat","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/430\/202208080e189c35adab992d274c294586143ec9.png"},{"outletTypeId":"10","parent":"","name":"Toko Kaca","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/440\/20220808e2c420d928d4bf8ce0ff2ec19b371514.png"},{"outletTypeId":"4","parent":"","name":"Toko Alumunium","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/438\/2022080808048a9c5630ccb67789a198f35d30ec.png"},{"outletTypeId":"5","parent":"","name":"Toko Bangunan","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/439\/2022080842d6c7d61481d1c21bd1635f59edae05.png"},{"outletTypeId":"8","parent":"","name":"Toko Furniture","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/441\/202208084dc3ed26a29c9c3df3ec373524377a5b.png"},{"outletTypeId":"11","parent":"","name":"Toko Genteng","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/435\/2022080871e09b16e21f7b6919bbfc43f6a5b2f0.png"},{"outletTypeId":"12","parent":"","name":"Toserba","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/437\/202208080eac690d7059a8de4b48e90f14510391.png"},{"outletTypeId":"9","parent":"","name":"Toko Listrik","icon":"https:\/\/semut.dev.ittron.co.id\/resources\/20220808\/SEModel_OutletType\/442\/20220808ba0a4d6ecea3e9e126dd3b6d77291c97.png"}]}}';
    //print("jsonDecode ${jsonDecode(jsonString)}");
    Response response = new Response(body: jsonString, statusCode: 200);

    ResponsePaginationModel<OutletTypeModel> pagination =
        response.toPaginationModel<OutletTypeModel>();

    print("data ${pagination.data}");
    // response.toPaginationModel();
    // ResponseModel<PaginationDataModel>? model =
    //     ResponseModel<PaginationDataModel>.fromJson(jsonDecode(response.body));
    //PaginationDataModel? model = response.toDataModel<PaginationDataModel>();

    expect(pagination.data != null, true);
  });
}
