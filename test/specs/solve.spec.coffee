define (require) ->

  prisoner = require '../../src/prisoner'

  solve = prisoner.solve
  Game  = prisoner.Game
  Piece = prisoner.Piece

  describe 'solve', ->

    it 'should solve game correctly', ->
      @timeout 4000

      game = new Game
        width: 6
        height: 6
        prisoner: new Piece {x: 2, y: 2}, {x: 3, y: 2}

      game.addPiece(new Piece {x: 0, y: 0}, {x: 0, y: 2})
      game.addPiece(new Piece {x: 1, y: 1}, {x: 2, y: 1})
      game.addPiece(new Piece {x: 3, y: 0}, {x: 3, y: 1})
      game.addPiece(new Piece {x: 5, y: 0}, {x: 5, y: 1})
      game.addPiece(new Piece {x: 0, y: 3}, {x: 2, y: 3})
      game.addPiece(new Piece {x: 0, y: 5}, {x: 1, y: 5})
      game.addPiece(new Piece {x: 2, y: 4}, {x: 2, y: 5})
      game.addPiece(new Piece {x: 3, y: 5}, {x: 4, y: 5})
      game.addPiece(new Piece {x: 4, y: 2}, {x: 4, y: 4})
      game.addPiece(new Piece {x: 5, y: 3}, {x: 5, y: 4})

      expect(game.matrix).to.deep.equal(
        [
          [2, 0, 0, 4, 0,  5]
          [2, 3, 3, 4, 0,  5]
          [2, 0, 1, 1, 10, 0]
          [6, 6, 6, 0, 10, 11]
          [0, 0, 8, 0, 10, 11]
          [7, 7, 8, 9, 9,  0]
        ]
      )

      solvedGame = solve(game)

      expect(solvedGame.matrix).to.deep.equal(
        [
          [0, 0, 8, 4, 0,  5]
          [3, 3, 8, 4, 0,  5]
          [2, 1, 1, 0, 0,  0]
          [2, 6, 6, 6, 10, 0]
          [2, 0, 0, 0, 10, 11]
          [7, 7, 9, 9, 10, 11]
        ]
      )

    it 'should solve tricky game', ->
      @timeout 10000

      game = new Game
        width: 6
        height: 6
        prisoner: new Piece {x: 3, y: 2}, {x: 4, y: 2}

      game.addPiece new Piece({x: 0, y: 0}, {x: 0, y: 1})
      game.addPiece new Piece({x: 1, y: 0}, {x: 2, y: 0})
      game.addPiece new Piece({x: 2, y: 1}, {x: 2, y: 2})
      game.addPiece new Piece({x: 4, y: 0}, {x: 4, y: 1})
      game.addPiece new Piece({x: 5, y: 0}, {x: 5, y: 1})
      game.addPiece new Piece({x: 5, y: 2}, {x: 5, y: 3})
      game.addPiece new Piece({x: 4, y: 4}, {x: 5, y: 4})
      game.addPiece new Piece({x: 3, y: 3}, {x: 3, y: 5})
      game.addPiece new Piece({x: 2, y: 3}, {x: 2, y: 4})
      game.addPiece new Piece({x: 0, y: 3}, {x: 1, y: 3})
      game.addPiece new Piece({x: 0, y: 5}, {x: 2, y: 5})

      expect(game.matrix).to.deep.equal(
        [
          [2,  3,  3,  0, 5, 6]
          [2,  0,  4,  0, 5, 6]
          [0,  0,  4,  1, 1, 7]
          [11, 11, 10, 9, 0, 7]
          [0,  0,  10, 9, 8, 8]
          [12, 12, 12, 9, 0, 0]
        ]
      )

      solvedGame = solve(game)

      expect(solvedGame.matrix).to.deep.equal(
        [
          [2,  0,  4,  3, 3, 6]
          [2,  0,  4,  0, 0, 6]
          [1,  1,  0,  0, 0, 0]
          [11, 11, 10, 9, 5, 7]
          [8,  8,  10, 9, 5, 7]
          [12, 12, 12, 9, 0, 0]
        ]
      )
