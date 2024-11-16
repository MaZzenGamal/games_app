
const String baseUrl = 'https://cardsim.net/api';

const String registerUrl = '$baseUrl/register';

const String loginUrl = '$baseUrl/access';
const String createCouponUrl = '$baseUrl/dist/vouchers/new';
const String getAgentUrl = '$baseUrl/distributors';
const String getAllTransactionsUrl = '$baseUrl/user-logs';

const String getUserInfoUrl = '$baseUrl/me';
// // order API url
String getUserOrdersUrl(String search, String status) => '$baseUrl/orders?search=$search&status=$status';
String getCouponsUrl(String search) => '$baseUrl/dist/vouchers?search=$search&page';









