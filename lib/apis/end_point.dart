class Apis{
  Apis._();
  static const basic = 'https://todo.iraqsapp.com/';

  static const registerUser = '${basic}auth/register';
  static const loginUser = '${basic}auth/login';
  static const logOutUser = '${basic}auth/logout';
  static const refreshToken = '${basic}auth/refresh-token?token=token';
  static const profile = '${basic}auth/profile';
  static const addTodo = '${basic}todos';
  static const fetchTodos = '${basic}todos?page=';
  static const editTodo = '${basic}todos/';
  static const deleteTodo = '${basic}todos/';
  static const getOneTodo = '${basic}todos/6640dc5e1971e94d3c98d84d';
  static const getListTodo = '${basic}todos?page=1';
  static const uploadImage = '${basic}upload/image';



}