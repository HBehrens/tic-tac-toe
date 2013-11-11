angular.module 'App', []

@TicTacToeCntl = ($scope) ->
  init = ->
    @reset = =>
      @board = (['','',''] for [1..3])
      @nextMove = 'X'
      @winner = ''
      @grade()

    @dropPiece = (row, col) =>
      if not @winner and not @board[row][col]
        @board[row][col] = @nextMove
        @nextMove = if @nextMove == 'X' then 'O' else 'X'
        @grade()

    @grade = =>
      same = (a,b,c) -> if a==b and b==c then a else ''
      b = @board
      row = (r) -> same b[r][0], b[r][1], b[r][2]
      col = (c) -> same b[0][c], b[1][c], b[2][c]
      diagonal = (d) -> same b[0][1-d], b[1][1], b[2][1+d]

      @winner = row(0) or row(1) or row(2) or
      col(0) or col(1) or col(2) or
      diagonal(-1) or diagonal(1)

    @reset()

  init.apply $scope

@TicTacToeCntl.$inject = ['$scope']