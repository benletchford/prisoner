define (require) ->

  prisoner = require '../../src/prisoner'

  Game  = prisoner.Game
  Piece = prisoner.Piece

  WIDTH  = 6
  HEIGHT = 6
  PRISONER = new Piece {x: 0, y: 0}, {x: 1, y: 0}

  describe 'game', ->

    it 'should initialize game properly', ->
      game = new Game
        width: WIDTH
        height: HEIGHT
        prisoner: PRISONER

      expect(game.matrix).to.deep.equal(
        [
          [1, 1, 0, 0, 0, 0]
          [0, 0, 0, 0, 0, 0]
          [0, 0, 0, 0, 0, 0]
          [0, 0, 0, 0, 0, 0]
          [0, 0, 0, 0, 0, 0]
          [0, 0, 0, 0, 0, 0]
        ]
      )

    it 'should add pieces correctly', ->
      game = new Game
        width: WIDTH
        height: HEIGHT
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

    describe 'move', ->

      it 'should move pieces correctly', ->
        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: PRISONER

        game.addPiece(new Piece {x: 5, y: 0}, {x: 5, y: 1})

        expect(game.move 0, true).to.be.true

        expect(game.matrix).to.deep.equal(
          [
            [0, 1, 1, 0, 0, 2]
            [0, 0, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.move 0, false).to.be.true

        expect(game.matrix).to.deep.equal(
          [
            [1, 1, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.move 1, true).to.be.true

        expect(game.matrix).to.deep.equal(
          [
            [1, 1, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.move 1, false).to.be.true

        expect(game.matrix).to.deep.equal(
          [
            [1, 1, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

      it 'should not move horizontal piece on collision', ->
        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 1, y: 0}, {x: 2, y: 0}

        game.addPiece(new Piece {x: 0, y: 0}, {x: 0, y: 1})
        game.addPiece(new Piece {x: 3, y: 0}, {x: 3, y: 1})

        expect(game.move 0, true).to.be.false
        expect(game.move 0, false).to.be.false

        expect(game.matrix).to.deep.equal(
          [
            [2, 1, 1, 3, 0, 0]
            [2, 0, 0, 3, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

      it 'should not move vertical piece on collision', ->
        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 0, y: 1}, {x: 0, y: 2}

        game.addPiece(new Piece {x: 0, y: 0}, {x: 1, y: 0})
        game.addPiece(new Piece {x: 0, y: 3}, {x: 1, y: 3})

        expect(game.move 0, true).to.be.false
        expect(game.move 0, false).to.be.false

        expect(game.matrix).to.deep.equal(
          [
            [2, 2, 0, 0, 0, 0]
            [1, 0, 0, 0, 0, 0]
            [1, 0, 0, 0, 0, 0]
            [3, 3, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

      it 'should not move horizontal piece out of bounds', ->
        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 0, y: 0}, {x: 1, y: 0}

        expect(game.move 0, false).to.be.false

        expect(game.matrix).to.deep.equal(
          [
            [1, 1, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.move 0, true).to.be.true
        expect(game.move 0, true).to.be.true
        expect(game.move 0, true).to.be.true
        expect(game.move 0, true).to.be.true
        expect(game.move 0, true).to.be.false

        expect(game.matrix).to.deep.equal(
          [
            [0, 0, 0, 0, 1, 1]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

      it 'should not move vertical piece out of bounds', ->
        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 0, y: 0}, {x: 0, y: 1}

        expect(game.move 0, false).to.be.false

        expect(game.matrix).to.deep.equal(
          [
            [1, 0, 0, 0, 0, 0]
            [1, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.move 0, true).to.be.true
        expect(game.move 0, true).to.be.true
        expect(game.move 0, true).to.be.true
        expect(game.move 0, true).to.be.true
        expect(game.move 0, true).to.be.false

        expect(game.matrix).to.deep.equal(
          [
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [1, 0, 0, 0, 0, 0]
            [1, 0, 0, 0, 0, 0]
          ]
        )

    describe 'exit', ->

      it 'should exit right', ->
        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 1, y: 0}, {x: 2, y: 0}

        expect(game.matrix).to.deep.equal(
          [
            [0, 1, 1, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.canExit()).to.be.true

        game.addPiece(new Piece {x: 5, y: 0}, {x: 5, y: 1})

        expect(game.matrix).to.deep.equal(
          [
            [0, 1, 1, 0, 0, 2]
            [0, 0, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.canExit()).to.be.false

      it 'should exit right', ->
        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 4, y: 0}, {x: 5, y: 0}

        expect(game.matrix).to.deep.equal(
          [
            [0, 0, 0, 0, 1, 1]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.canExit()).to.be.true

        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 3, y: 0}, {x: 4, y: 0}

        expect(game.matrix).to.deep.equal(
          [
            [0, 0, 0, 1, 1, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.canExit()).to.be.true

        game.addPiece(new Piece {x: 5, y: 0}, {x: 5, y: 1})

        expect(game.matrix).to.deep.equal(
          [
            [0, 0, 0, 1, 1, 2]
            [0, 0, 0, 0, 0, 2]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.canExit()).to.be.false

      it 'should exit down', ->
        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 3, y: 4}, {x: 3, y: 5}

        expect(game.matrix).to.deep.equal(
          [
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 1, 0, 0]
            [0, 0, 0, 1, 0, 0]
          ]
        )

        expect(game.canExit()).to.be.true

        game = new Game
          width: WIDTH
          height: HEIGHT
          prisoner: new Piece {x: 3, y: 3}, {x: 3, y: 4}

        expect(game.matrix).to.deep.equal(
          [
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 1, 0, 0]
            [0, 0, 0, 1, 0, 0]
            [0, 0, 0, 0, 0, 0]
          ]
        )

        expect(game.canExit()).to.be.true

        game.addPiece(new Piece {x: 2, y: 5}, {x: 3, y: 5})

        expect(game.matrix).to.deep.equal(
          [
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 0, 0, 0]
            [0, 0, 0, 1, 0, 0]
            [0, 0, 0, 1, 0, 0]
            [0, 0, 2, 2, 0, 0]
          ]
        )

        expect(game.canExit()).to.be.false
