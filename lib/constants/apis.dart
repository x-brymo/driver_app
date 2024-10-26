// ignore_for_file: constant_identifier_names
const ROOT_URL = 'http://127.0.0.1:8000';
// const ROOT_URL = 'http://10.0.2.2:8000';

const API_URL = '$ROOT_URL/api';
const LOGIN_URL = '$API_URL/auth/login';
const REGISTER_URL = '$API_URL/auth/drivers/register';
const LOGOUT_DRIVER_URL = '$API_URL/auth/drivers/logout';

//! DRIVER API 
const DRIVER_UPDATE = '$API_URL/drivers'; // Insert ID
const UPDATE_PROFILE = '$API_URL/drivers'; //http://192.168.1.5:8000/api/drivers/1
const ORDER_UPDATE = '$API_URL/drivers/orders'; // Insert ID
const GET_DRIVER_NOTIFICATIONS = '$API_URL/notifications?guard=';
const DRIVER_SEND_MESSAGE_URL = '$API_URL/drivers/chats'; // POST http://192.168.1.5:8000/api/drivers/chats

//! ORDER API
const GET_ORDERS_LIST = '$API_URL/drivers/orders'; // GET
const GET_INCOME_STATISTIC = '$API_URL/drivers/orders/income-statistic?type='; // GET
const UPDATE_DRIVER_LOCATION = '$API_URL/drivers/orders/update-driver-location'; // POST

//! CHATS API
const GET_MESSAGES_URL = '$API_URL/chats'; // GET (INSER ORDER ID)