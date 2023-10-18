import 'package:calcula_ai/src/models/paper_model.dart';
import 'package:calcula_ai/src/models/paper_without_id_modal.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://papers-api.onrender.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("papers")
  Future<List<PaperModel>> getPapers();

  @POST("papers")
  Future<PaperModel> createPaper(@Body() PaperWithoutIdModel paper);

  @PUT("papers/{id}")
  Future<PaperModel> updatePaper(@Path() String id, @Body() PaperModel task);

  @DELETE("papers/{id}")
  Future<void> deletePaper(@Path() String id);
}
