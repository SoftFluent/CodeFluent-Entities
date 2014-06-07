function TodoCtrl($scope) {

    $scope.todos = [];

    context.indexedDB.open(function () {
        context.indexedDB.Task.loadAll(function (results) {
            $scope.todos = results;
            $scope.$apply();
        });
    });

    $scope.addTodo = function () {
        var id = 0;

        for (var i = 0; i < $scope.todos.length; i++) {
            if (id < $scope.todos[i].id)
                id = $scope.todos[i].id;
        }

        context.indexedDB.Task.add((id + 1), $scope.todoText);
        $scope.todos.push({ id: (id + 1), text: $scope.todoText, done: false });
        $scope.$apply();
        $scope.todoText = '';
    };

    $scope.remaining = function () {
        var count = 0;
        angular.forEach($scope.todos, function (todo) {
            count += todo.done ? 0 : 1;
        });
        return count;
    };

    $scope.archive = function () {
        var oldTodos = $scope.todos;
        $scope.todos = [];
        angular.forEach(oldTodos, function (todo) {
            if (todo.done) {
                context.indexedDB.Task.delete(todo.id);
            } else {
                $scope.todos.push(todo);
            }
        });
    };
}