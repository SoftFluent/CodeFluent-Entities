app.controller("CartController", ['dataFactory', '$scope', function (dataFactory, $scope) {
    $scope.ProductsInCart = [];
    $scope.TotalCart = 0;


    this.insertProduct = function (product) {
        if ($scope.ProductsInCart === null)
            $scope.ProductsInCart = new Array();
        
        $scope.ProductsInCart.push(product);
            
        this.getTotal();
    };

    this.deleteProduct = function(product) {
        //$scope.ProductsInCart.pop();
        //TODO change with slice
    };

    this.count = function() {
        return $scope.ProductsInCart.length;
    };
        

    this.getTotal = function () {
        $scope.TotalCart = 0;
        $scope.ProductsInCart.forEach(function(product) {
            $scope.TotalCart += product.price;
        });
    };

    this.insertOrder = function() {
        
    };
}]);