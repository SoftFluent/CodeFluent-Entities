
app.controller("ProductController", ['dataFactory', '$scope', function (dataFactory, $scope) {
    $scope.products = [];

    dataFactory.get("Product").success(function (productsList) {
        $scope.products = productsList;
    }).error(function (error) {
        //alert(error);
    });

    $scope.getNumber = function (num) {
        return new Array(num);
    }
}]);


