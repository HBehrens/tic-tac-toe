describe "Controller", ->
  scope = null
  controller = null
  beforeEach ->
    scope = {}
    controller = new TicTacToeCntl scope


  it "initializes", ->
    expect(scope.board).to.deep.equal [['','',''],['','',''], ['','','']]
    expect(scope.nextMove).to.equal 'X'

  it "prevents dropping piece on occupied field", ->
    scope.dropPiece 0, 0
    expect(scope.board).to.deep.equal [['X','',''],['','',''], ['','','']]
    expect(scope.nextMove).to.equal 'O'

    expect(scope.board).to.deep.equal [['X','',''],['','',''], ['','','']]
    scope.dropPiece 0, 0
    expect(scope.nextMove).to.equal 'O'

  it "detects row", ->
    scope.board =  [['X','X',''],['O','O',''], ['','','']]

    scope.dropPiece 0, 2
    expect(scope.board).to.deep.equal [['X','X','X'],['O','O',''], ['','','']]
    expect(scope.winner).to.equal 'X'

  it "detects col", ->
    scope.board = [['X','O',''],['X','O',''], ['','','']]

    scope.dropPiece 2, 0
    expect(scope.board).to.deep.equal [['X','O',''],['X','O',''], ['X','','']]
    expect(scope.winner).to.equal 'X'

  it "detects diagonal 1", ->
    scope.board = [['X','O','O'],['','X',''], ['','','']]

    scope.dropPiece 2, 2
    expect(scope.board).to.deep.equal [['X','O','O'],['','X',''], ['','','X']]
    expect(scope.winner).to.equal 'X'

  it "detects diagonal 2", ->
    scope.board = [['','O','O'],['','X',''], ['','','X']]

    scope.dropPiece 0, 0
    expect(scope.board).to.deep.equal [['X','O','O'],['','X',''], ['','','X']]
    expect(scope.winner).to.equal 'X'
