class Apis {
  const Apis._();

  static const _basic = 'https://todo.iraqsapp.com/';
  static const registerUser = '${_basic}auth/register';
  static const loginUser = '${_basic}auth/login';
  static const logOutUser = '${_basic}auth/logout';
  static const profile = '${_basic}auth/profile';
  static const addTodo = '${_basic}todos';
  static const editTodo = '${_basic}todos/';
  static const deleteTodo = '${_basic}todos/';
  static const uploadImage = '${_basic}upload/image';
  // Check why we need it
  static const fetchTodos = '${_basic}todos?page=';
  static const refreshToken = '${_basic}auth/refresh-token?token=';
  static const getOneTodo = '${_basic}todos/';
}
