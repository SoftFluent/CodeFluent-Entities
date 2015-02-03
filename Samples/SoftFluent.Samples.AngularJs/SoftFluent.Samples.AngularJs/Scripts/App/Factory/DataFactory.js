app.factory('dataFactory', ['$http', function ($http) {

    var urlBase = '/api/';
    var dataFactory = {};

    dataFactory.get = function (controller) {
        return $http.get(urlBase + controller);
    };

    dataFactory.getWithIds = function (controller, id) {
        return $http.get(urlBase + controller + '/' + id);
    };

    dataFactory.insert = function (controller, data) {
        return $http.post(urlBase + controller, data);
    };

    return dataFactory;
}]);