import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import 'error/exception.dart';

class APIResponse {
  final dynamic data;
  final int statusCode;
  final String? error;
  final http.Response? rawData;
  final bool? isSuccessful;

  APIResponse({
    this.data,
    this.statusCode =
        -1, // -1 will be returned if the response couldn't be processed somehow
    this.error,
    this.rawData,
    this.isSuccessful,
  });
}

enum APIMethod { get, post, put, patch, delete }

class APIManager {
  final http.Client client;

  APIManager({required this.client});

  Future<APIResponse> request(
    String endPoint, {
    APIMethod method = APIMethod.get,
    Map? data,
  }) async {
    bool result = await SimpleConnectionChecker.isConnectedToInternet();
    if (!result) {
      String error = 'No Internet Connection';
      throw APIException(error, data: null, statusCode: 0);
    }

    /// Set url
    final url = Uri.parse("https://jsonplaceholder.typicode.com/$endPoint");

    /// Create non-auth header
    final headers = {'Content-Type': 'application/json'};

    /// Add bearer token, if the API call is to be authenticated
    String? token = '';

    headers.addAll({'Authorization': 'Bearer $token'});

    late http.Response response;

    Duration timeout = const Duration(seconds: 60);

    debugPrint(
        "API request url: $url XXXXXX header: $headers XXXXXX param: $data \n");

    /// switch on the basis of method provided and make relevant API call
    try {
      switch (method) {
        case APIMethod.get:
          response = await client.get(url, headers: headers).timeout(timeout);
          break;
        case APIMethod.post:
          response = await client
              .post(url, headers: headers, body: json.encode(data))
              .timeout(timeout);
          break;
        case APIMethod.put:
          response = await client
              .put(url, headers: headers, body: json.encode(data))
              .timeout(timeout);
          break;
        case APIMethod.patch:
          response = await client
              .patch(url, headers: headers, body: json.encode(data))
              .timeout(timeout);
          break;
        case APIMethod.delete:
          response =
              await client.delete(url, headers: headers).timeout(timeout);
          break;
      }
    } on TimeoutException catch (_) {
      String error = "Request timeout!";
      throw APIException(error, data: null, statusCode: -1);
    } catch (e) {
      String error = "Something went wrong, please try again later!";
      throw APIException(error, data: null, statusCode: -1);
    }

    return _handleResponse(response);
  }

  /// This method handles the response of the API
  _handleResponse(http.Response response) {
    /// parse the response
    List responseBody = json.decode(response.body);
    debugPrint("API response XXXXXX: $responseBody\n");

    /// status code of the response
    int statusCode = response.statusCode;

    bool isSuccessful = statusCode >= 200 && statusCode < 300;

    String error = '';
    // String error =
    //     responseBody.containsKey("message") ? responseBody["message"] : '';
    if (!isSuccessful) {
      switch (statusCode) {
        case HttpStatus.movedPermanently:
        case HttpStatus.movedTemporarily:
          error =
              "The endpoint to this API has been changed, please consider to update it.";
          break;

        case HttpStatus.badRequest:
          if (error.isEmpty) {
            error =
                "Please check your request and make sure you are posting a valid data body.";
          }
          break;

        case HttpStatus.unauthorized:
          if (error.isEmpty) {
            error = "This API needs to be authenticated with a Bearer token.";
          }
          break;
        case HttpStatus.forbidden:
          if (error.isEmpty) {
            error = "You are not allowed to call this API.";
          }
          break;

        case HttpStatus.unprocessableEntity:
          if (error.isEmpty) {
            error = "Provided credentials are not valid.";
          }
          break;

        case HttpStatus.tooManyRequests:
          if (error.isEmpty) {
            error =
                "You are requesting the APIs too often, please don't call the API(s) unnecessarily";
          }
          break;

        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
        case HttpStatus.serviceUnavailable:
          if (error.isEmpty) {
            error = "Server is not responding, please try again later!";
          }
          break;

        default:
          error = (error.isEmpty)
              ? "Something went wrong, please try again later!"
              : error;
        // error = "Something went wrong, please try again later!";
      }
      debugPrint(
          "API exception error: $error XXXXXX responseBody: $responseBody XXXXXX statusCode: $statusCode \n");
      throw APIException(error, data: responseBody, statusCode: statusCode);
    }

    return APIResponse(
        data: responseBody,
        rawData: response,
        statusCode: statusCode,
        isSuccessful: isSuccessful,
        error: error);
  }
}
