//noinspection JSUnusedGlobalSymbols
function TicTacToeCntl($scope) {

    $scope.reset = function() {
        $scope.board = [
            ['', '', ''],
            ['', '', ''],
            ['', '', '']
        ];
        $scope.nextMove = 'X';
        $scope.winner = '';
        $scope.grade();
    };

    $scope.dropPiece = function(row, col) {
        if (!$scope.winner && !$scope.board[row][col]) {
            $scope.board[row][col] = $scope.nextMove;
            $scope.nextMove = $scope.nextMove == 'X' ? 'O' : 'X';
            $scope.grade();
        }
    };

    $scope.grade = function() {
        var b = $scope.board;
        function same(a, b, c) { return (a==b && b==c) ? a : '';}
        function row(r) { return same(b[r][0], b[r][1], b[r][2]);}
        function col(c) { return same(b[0][c], b[1][c], b[2][c]);}
        function diagonal(i) { return same(b[0][1-i], b[1][1], b[2][1+i]);}

        $scope.winner =
            row(0) || row(1) || row(2) ||
                // col(0) || col(1) || col(2) ||
                diagonal(-1) || diagonal(1);
    };

    $scope.reset();
}

// workaround for uglify
TicTacToeCntl.$inject = ['$scope'];