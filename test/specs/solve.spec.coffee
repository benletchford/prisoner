define (require) ->

  prisoner = require '../../src/prisoner'

  solve = prisoner.solve
  Game  = prisoner.Game
  Piece = prisoner.Piece

  describe 'solve', ->

    it 'should solve easy game correctly', ->
      game = prisoner.arrayToGame(
        [
          [0, 0, 0, 0, 0, 0]
          [0, 0, 0, 0, 2, 0]
          [0, 0, 1, 1, 2, 3]
          [0, 0, 0, 0, 2, 3]
          [0, 0, 0, 0, 0, 3]
          [0, 0, 0, 0, 0, 0]
        ]
      )

      solvedData = solve(game)

      expect(solvedData.solution.matrix).to.deep.equal(
        [
          [0, 0, 0, 0, 0, 0]
          [0, 0, 0, 0, 0, 0]
          [0, 0, 1, 1, 0, 0]
          [0, 0, 0, 0, 2, 3]
          [0, 0, 0, 0, 2, 3]
          [0, 0, 0, 0, 2, 3]
        ]
      )

      expect(solvedData.steps).to.have.length.of 2

    xit 'should solve game correctly', ->
      @timeout 10000

      game = prisoner.arrayToGame(
        [
          [2, 0, 0, 4, 0,  5]
          [2, 3, 3, 4, 0,  5]
          [2, 0, 1, 1, 10, 0]
          [6, 6, 6, 0, 10, 11]
          [0, 0, 8, 0, 10, 11]
          [7, 7, 8, 9, 9,  0]
        ]
      )

      solvedData = solve(game)

      expect(solvedData.solution.matrix).to.deep.equal(
        [
          [0, 0, 8, 4, 0,  5]
          [3, 3, 8, 4, 0,  5]
          [2, 1, 1, 0, 0,  0]
          [2, 6, 6, 6, 10, 0]
          [2, 0, 0, 0, 10, 11]
          [7, 7, 9, 9, 10, 11]
        ]
      )

      expect(solvedData.steps).to.have.length.of 15

    xit 'should solve tricky game', ->
      @timeout 40000

      game = prisoner.arrayToGame(
        [
          [2,  3,  3,  0, 5, 6]
          [2,  0,  4,  0, 5, 6]
          [0,  0,  4,  1, 1, 7]
          [11, 11, 10, 9, 0, 7]
          [0,  0,  10, 9, 8, 8]
          [12, 12, 12, 9, 0, 0]
        ]
      )

      solvedData = solve(game)

      expect(solvedData.solution.matrix).to.deep.equal(
        [
          [2,  0,  4,  3, 3, 6]
          [2,  0,  4,  0, 0, 6]
          [1,  1,  0,  0, 0, 0]
          [11, 11, 10, 9, 5, 7]
          [8,  8,  10, 9, 5, 7]
          [12, 12, 12, 9, 0, 0]
        ]
      )

      expect(solvedData.steps).to.have.length.of 25
