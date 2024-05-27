class Apis{
  Apis._();
  static const basic = 'https://todo.iraqsapp.com/';

  static const register = '${basic}auth/register';
  static const login = '${basic}auth/login';
  static const logOut = '${basic}auth/logout';
  static const refreshToken = '${basic}auth/refresh-token?token=token';
  static const profile = '${basic}auth/profile';
  static const uploadImage = '${basic}upload/image';
  static const getList = '${basic}todos?page=1';
  static const getOne = '${basic}todos/6640dc5e1971e94d3c98d84d';
  static const create = '${basic}todos';
  static const edit = '${basic}todos/6640da101971e94d3c98d832';
  static const delete = '${basic}todos/6640da101971e94d3c98d832';



}