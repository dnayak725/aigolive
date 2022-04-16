class AppConfig {
  final String webLink = "https://agl.bluecube.com.sg/";
  final String apiLink = "https://agl.bluecube.com.sg/api/";
  final String apiKey = "cDa98K42-79eb-4B31-9I32-4b060Ff11557";

  //api links

}

class ApiLinks {
  final String getAllCategoriesApi =
      AppConfig().apiLink + "Customer/GetAllCategories";
  final String updateEmailApi = AppConfig().apiLink + "Customer/PostBuyerEmail";
  final String addNewAddressApi =
      AppConfig().apiLink + "Customer/PostBuyerAddress";
  final String marketplaceSliderImagesApi =
      AppConfig().apiLink + "Customer/MarketPlaceSliderImages";
  final String homescreenSliderImagesApi =
      AppConfig().apiLink + "Customer/SliderImages";
  final String bannerTagsApi = AppConfig().apiLink + "Customer/Bannerlist";
  final String comingUpNextApi =
      AppConfig().apiLink + "Customer/GetUpcomingNextSessionList";
  final String mostWatchedApi =
      AppConfig().apiLink + "Customer/MostWatchSession";
  final String mostShopedApi =
      AppConfig().apiLink + "Customer/MostShoppedSession";
  final String recommendedApi =
      AppConfig().apiLink + "Customer/RecommendedSessionList/";
  final String recommendedProductListApi =
      AppConfig().apiLink + "Customer/Recommendedproductlist/";
  final String categorySubcategoryApi =
      AppConfig().apiLink + "Customer/CategorySubcategory";
  final String marketPlaceSliderImagesApi =
      AppConfig().apiLink + "Customer/MarketPlaceSliderImages";
  final String followUnfollowApi =
      AppConfig().apiLink + "Customer/FollowUnfollow";
  final String facebookRegistrationApi =
      AppConfig().apiLink + "Customer/FBRegistration";
  final String googleRegistrationApi =
      AppConfig().apiLink + "Customer/GoogleRegistration";
  final String weeklyDealsProductListApi =
      AppConfig().apiLink + "Customer/WeeklyMarketPlaceProductList";
  final String nothingAboveApi =
      AppConfig().apiLink + "Customer/NothingabovePlaceProductList";
  final String getProductDetailsApi = AppConfig().apiLink +
      "Customer/ProductDetailsById/"; //needs to pass product ID parameter
  final String getConversationListApi = AppConfig().apiLink +
      "Customer/GetAllConversationByUser/"; //needs to pass customer/buyer ID parameter
  final String sendmessageToSellerApi = AppConfig().apiLink +
      "Customer/SendMessagePrivateChat"; //needs to pass customer/buyer ID parameter
  final String getPrivateMessageHistoryApi = AppConfig().apiLink +
      "Customer/GetAllPrivateChatHistory/"; //need to add buyer id and seller id
  final String cartDetailsApi = AppConfig().apiLink + "Customer/Cartlist";
  final String cartProductQuantityChangeApi =
      AppConfig().apiLink + "Customer/CartQyantityIncreaseDecrease";
  final String makeAddressDefaultApi =
      AppConfig().apiLink + "Customer/UpdateSetDefaultAddress";
  final String deleteAddressApi =
      AppConfig().apiLink + "Customer/AddressDelete";
  final String updateProfileEmailApi =
      AppConfig().apiLink + "Customer/UpdateEmailForCustomer";
  final String cancelOrderApi =
      AppConfig().apiLink + "Customer/CancelOrderByCustomerId";
  final String confirmReceiptApi =
      AppConfig().apiLink + "Customer/ConfirmReceiptByCustomerID";
  final String searchSessionListByCategoryNameApi =
      AppConfig().apiLink + "Customer/SearchSessionListByCategoryName";
  final String searchSessionListByCategoryIdApi =
      AppConfig().apiLink + "Customer/SearchSessionListByCategoryId";
  final String searchProductDetailsBySearchkeyApi =
      AppConfig().apiLink + "Customer/SearchProductDetailsBySearchkey";
  final String searchProductDetailsByCategoryIdApi =
      AppConfig().apiLink + "Customer/ProductListByCategoryId";
  final String getProductProceByVariantApi =
      AppConfig().apiLink + "Customer/FetchPriceByoption/";
  final String addToCartApi = AppConfig().apiLink + "Customer/AddtoCart/";
  final String getPublicChatListApi =
      AppConfig().apiLink + "Customer/GetPublicChatList";
  final String sendMessagePublicChatApi =
      AppConfig().apiLink + "Customer/SendMessagePublicChat";
  final String getSessionDetailsWithProductsApi =
      AppConfig().apiLink + "Customer/GetSessionDetailsWithProducts";
  final String getNotificationsApi =
      AppConfig().apiLink + "Customer/GetNotifications";
  final String fetchFrontStoreSessionApi =
      AppConfig().apiLink + "Customer/FetchFrontStoreSession";
  final String placeOrderApi = AppConfig().apiLink + "Customer/PlaceOrder";
  final String removeFromCartApi = AppConfig().apiLink + "Customer/RemoveCart";
  final String paymentUrlApi =
      "https://api.sandbox.hit-pay.com/v1/payment-requests";
}
