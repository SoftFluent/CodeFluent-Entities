app.controller("OrderController", ['dataFactory', '$scope', 'toastr', function (dataFactory, $scope, toastr) {
    dataFactory.get("Order")
        .success(function (data) {
            $scope.orders = data;
        });

    this.save = function (user, products) {
        $scope.orders = { Id: "", Date: "", Customer: user, Products: products };

        dataFactory.insert("Order", JSON.stringify($scope.orders)).success(function() {
            toastr.success('Saved', 'Success!');
            $('#SaveButton').addClass('disabled');
        }).error(function() {
            toastr.error('Error in process', 'Error');
        });
    };
    this.getTotalPrice = function (products) {
        var amount = 0;
        products.forEach(function (item) {
            amount += item.price;
        });
        return amount;
    };
}]);