define (require) ->

  prisoner = require '../../src/prisoner'

  arrayToGame  = prisoner.arrayToGame
  Game         = prisoner.Game
  Piece        = prisoner.Piece

  describe 'arrayToGame', ->

    it 'should convert array to game', ->
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

      convertedGame = arrayToGame(
        [
          [2, 0, 0, 4, 0,  5]
          [2, 3, 3, 4, 0,  5]
          [2, 0, 1, 1, 10, 0]
          [6, 6, 6, 0, 10, 11]
          [0, 0, 8, 0, 10, 11]
          [7, 7, 8, 9, 9,  0]
        ]
      )

      expect(convertedGame).to.deep.equal(game)
