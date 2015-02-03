var app = angular.module("MainApp", ['ngRoute', 'ngAnimate', 'ngMessages','toastr']);

app.config([
    '$routeProvider', '$locationProvider',
    function ($routeProvider, $locationProvider) {
        $routeProvider
            .when('/Product/:ProductId', {
                templateUrl: 'Content/Views/ProductDetail.html',
                controller: 'ProductDetailController',
                controllerAs: 'product'
            })
            .when('/Product', {
                templateUrl: 'Content/Views/Product.html',
                controller: 'ProductController',
                controllerAs: 'product'
            })
             .when('/Order', {
                 templateUrl: 'Content/Views/Order.html',
                 controller: 'OrderController',
                 controllerAs: 'order'
             })
            .when('/Cart', {
                templateUrl: 'Content/Views/Cart.html'                
            })
        .otherwise({
            templateUrl: 'Content/Views/Product.html',
            controller: 'ProductController',
            controllerAs: 'product'
        });


        $locationProvider.html5Mode(false);
    }
]);
