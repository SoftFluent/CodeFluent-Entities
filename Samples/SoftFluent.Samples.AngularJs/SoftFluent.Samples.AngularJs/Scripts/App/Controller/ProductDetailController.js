
app.controller("ProductDetailController", ['dataFactory', '$scope', '$routeParams', function (dataFactory, $scope, $routeParams) {
    var productId = $routeParams.ProductId;
    $scope.currentProduct = null;

    dataFactory.getWithIds("Product", productId).success(function (productReceive) {
        $scope.currentProduct = productReceive;
    }).error(function (error) {
       alert(error);
    });
}]);


