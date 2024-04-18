// // ApiService.dart
// import 'package:dio/dio.dart';

// class ApiService {
//   final Dio _dio;

//   ApiService(this._dio);

//   Future<String> login(String email, String password) async {
//     try {
//       // Make API request to login
//       Response response = await _dio.post('https://api.all-attend.com/dev-api/auth/admin-login', data: {
//         'email': email,
//         'password': password,
//       });
//       // Return response data
//       return response.data.toString();
//     } catch (error) {
//       // Handle error
//       print('Error occurred: $error');
//       return 'Failed to login';
//     }
//   }
// }
