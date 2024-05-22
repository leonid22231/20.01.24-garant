import 'dart:io';

import 'package:app/api/entity/MessageEntity.dart';
import 'package:app/api/entity/MessageEntityCreditList.dart';
import 'package:app/api/entity/MessageEntityGuarantorList.dart';
import 'package:app/api/entity/MessageEntityRegister.dart';
import 'package:app/api/entity/MessageEntityRequisites.dart';
import 'package:app/api/entity/MessageEntityUser.dart';
import 'package:app/api/entity/MessageEntityUserHistory.dart';
import 'package:app/api/entity/ParametersEntity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'RestClient.g.dart';
//192.168.0.11:89.23.117.164
@RestApi(baseUrl: 'http://89.23.117.164:8080/api/v1/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  @POST("service/register")
  Future<MessageEntityRegister> register(@Query("phone") String phone, @Query("name") String name,@Query("surname") String surname,@Query("patronymic") String patronymic,@Query("identity_number") String identity_number,@Query("email") String email,@Query("password") String password,@Query("userDate")DateTime userDate,@Query("identityDate")DateTime identityDate);
  @POST("service/login")
  Future<MessageEntity> login(@Query("phone")String phone, @Query("password")String password);
  @POST("service/register")
  @MultiPart()
  Future<MessageEntityRegister> registerandimage(@Query("phone") String phone, @Query("name") String name,@Query("surname") String surname,@Query("patronymic") String patronymic,@Query("identity_number") String identity_number,@Query("email") String email,@Query("password") String password,@Query("userDate")DateTime userDate,@Query("identityDate")DateTime identityDate, @Part(name: "file")File file);
  @POST("service/token")
  Future<MessageEntity> sendNewToken(@Header('Authorization') String token);
  @POST("user/register/confirm")
  Future<MessageEntity> registerConfirm(@Header('Authorization') String token, @Query("code")String code);
  @POST("user/register/sendNewCode")
  Future<MessageEntity> resendCode(@Header('Authorization') String token);
  @POST("user/credit/create")
  Future<MessageEntity> createCredit(@Header('Authorization') String token, @Query("day")int day,@Query("percent")double percent ,@Query("money") double money, @Query("code")String code,@Query("number")String? number, @Body()ParametersEntity parameters);
  @POST("user/credit/confirm")
  Future<MessageEntity> creditConfirm(@Header('Authorization') String token);
  @POST("user/avatar/change")
  @MultiPart()
  Future<MessageEntity> changeAvatar(@Header('Authorization') String token, @Part(name: "file")File file);
  @POST("user/credit/select")
  Future<MessageEntity> creditSelect(@Header('Authorization') String token, @Query("credit")String id, @Query("code")String code);
  @GET("user/credit/list")
  Future<MessageEntityCreditList> findAllCredit(@Header('Authorization') String token);
  @GET("user/guarantors")
  Future<MessageEntityGuarantorList> findAllGuarantor(@Header('Authorization') String token);
  @GET("user/credits")
  Future<MessageEntityUserHistory> findAllActive(@Header('Authorization') String token);
  @GET("user/info")
  Future<MessageEntityUser> getInfo(@Header('Authorization') String token);
  @GET("user/bank")
  Future<MessageEntityRequisites> getBanks(@Header('Authorization') String token);
  @POST("user/deal/create")
  @MultiPart()
  Future<String> createDealFile(@Header('Authorization') String token, @Query("name")String name,@Query("description")String description,@Query("duration")int duration,@Query("price")double price,@Query("seller")String? seller,@Query("buyer")String? buyer,@Part(name: "file")File file);
  @POST("user/deal/create")
  Future<String> createDeal(@Header('Authorization') String token, @Query("name")String name, @Query("type")String type,@Query("description")String description,@Query("duration")int duration,@Query("price")double price,@Query("seller")String? seller,@Query("buyer")String? buyer);
  @POST("user/deal/join")
  Future<String> joinDeal(@Header('Authorization') String token, @Query("code")String code);
  @POST("user/deal/end")
  Future<String> endDeal(@Header('Authorization') String token,@Query("id")String id);
}