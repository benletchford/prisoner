((root, factory) ->
  if typeof define == 'function' and define.amd
    define [], factory
  else if typeof module == 'object' and module.exports
    module.exports = factory()
  else
    root.prisoner = factory()
  return
) this, ->
  # Class that represents individual pieces.
  Piece =
    class
      constructor: (@begin, @end) ->
        @horizontal = @begin.y is @end.y

        if (@begin.x > @end.x or @begin.y > @end.y) or \
            (@begin.x is @end.x and @begin.y is @end.y)
          throw new Error("Piece coordinates aren't valid.")

  # Class that represents an entire state of a game.
  Game =
    class
      constructor: ({@width, @height, prisoner}) ->
        @matrix = []
        for y in [0...@width]
          row = []
          for x in [0...@height]
            row.push 0
          @matrix.push row

        @pieces = []
        @addPiece prisoner

      addPiece: (piece) ->
        @pieces.push piece

        designatedNum = @pieces.length

        for x in [piece.begin.x...piece.end.x + 1]
          for y in [piece.begin.y...piece.end.y + 1]
            @matrix[y][x] = designatedNum

      move: (pieceIndex, direction, steps=1) ->
        piece = @pieces[pieceIndex]
        designatedNum = pieceIndex + 1

        cellsThatNeedToBeEmpty = []

        if piece.horizontal
          if direction
            if (piece.end.x + steps) < @width
              for i in [piece.end.x + 1..piece.end.x + steps]
                cellsThatNeedToBeEmpty.push {x: i, y: piece.begin.y}
            else return false

          else
            if (piece.begin.x - steps) >= 0
              for i in [piece.begin.x - 1..piece.begin.x - steps]
                cellsThatNeedToBeEmpty.push {x: i, y: piece.begin.y}
            else return false
        else
          if direction
            if (piece.end.y + steps) < @height
              for i in [piece.end.y + 1..piece.end.y + steps]
                cellsThatNeedToBeEmpty.push {x: piece.begin.x, y: i}
            else return false

          else
            if (piece.begin.y - steps) >= 0
              for i in [piece.begin.y - 1..piece.begin.y - steps]
                cellsThatNeedToBeEmpty.push {x: piece.begin.x, y: i}
            else return false

        for cell in cellsThatNeedToBeEmpty
          if @matrix[cell.y][cell.x] != 0 then return false

        # Zero out
        for x in [piece.begin.x...piece.end.x + 1]
          for y in [piece.begin.y...piece.end.y + 1]
            @matrix[y][x] = 0

        newBegin = {x: piece.begin.x, y: piece.begin.y}
        newEnd   = {x: piece.end.x, y: piece.end.y}
        if piece.horizontal
          if direction
            newBegin.x += steps
            newEnd.x += steps
          else
            newBegin.x -= steps
            newEnd.x -= steps

        else
          if direction
            newBegin.y += steps
            newEnd.y += steps
          else
            newBegin.y -= steps
            newEnd.y -= steps

        piece.begin = newBegin
        piece.end = newEnd

        for x in [piece.begin.x...piece.end.x + 1]
          for y in [piece.begin.y...piece.end.y + 1]
            @matrix[y][x] = designatedNum

        return true

      canExit: ->
        prisoner = @pieces[0]

        if prisoner.horizontal
          for x in [(prisoner.end.x + 1)...@width]
            if @matrix[prisoner.end.y][x] != 0
              return false

        else
          for y in [(prisoner.end.y + 1)...@height]
            if @matrix[y][prisoner.end.x] != 0
              return false

        true

      clone: ->
        clonedGame = new Game
          width: @width
          height: @height
          prisoner: new Piece({
            x: @pieces[0].begin.x, y: @pieces[0].begin.y
          }, {
            x: @pieces[0].end.x, y: @pieces[0].end.y
          })

        for i in [1...@pieces.length]
          clonedGame.addPiece new Piece({
            x: @pieces[i].begin.x, y: @pieces[i].begin.y
          }, {
            x: @pieces[i].end.x, y: @pieces[i].end.y
          })

        clonedGame

  arrayToGame = (array) ->
    height = array.length
    width  = array[0].length

    arrayOfPoints = []

    for y in [0...height]
      for x in [0...width]
        if not arrayOfPoints[array[y][x]]
          arrayOfPoints[array[y][x]] = []

        arrayOfPoints[array[y][x]].push {x, y}

    pieces = []

    # We don't care about the 0s
    for i in [1...arrayOfPoints.length]
      begin = arrayOfPoints[i][0]
      end   = arrayOfPoints[i][arrayOfPoints[i].length - 1]

      pieces.push new Piece(begin, end)

    game = new Game
      width: width
      height: height
      prisoner: pieces[0]

    for i in [1...pieces.length]
      game.addPiece pieces[i]

    game

  solve = (initialGame) ->
    _findSolution = (initialGame) ->
      checked = []
      queue   = [initialGame]

      while queue.length
        game = queue.shift()

        return game if game.canExit()

        jsonGame = JSON.stringify(game.matrix)
        if checked.indexOf(jsonGame) is -1
          checked.push jsonGame

          for i in [0...game.pieces.length]
            for j in [1..4]
              posGame = game.clone()

              if posGame.move(i, true, j)
                posGame.parent = game
                posGame.diff = piece: i, direction: true, steps: j

                queue.push posGame

            for j in [1..4]
              negGame = game.clone()

              if negGame.move(i, false, j)
                negGame.parent = game
                negGame.diff = piece: i, direction: false, steps: j

                queue.push negGame

      return false

    solvedGame = _findSolution(initialGame)
    if solvedGame
      steps = []

      steps.push solvedGame
      parent = solvedGame.parent
      while parent
        steps.push parent
        parent = parent.parent

      # Remove the initial game
      steps.pop()
      steps = steps.reverse()

      diffs = []
      for step in steps
        diffs.push step.diff

        delete step.diff
        delete step.parent

      return {
        diffs: diffs
        steps: steps
        solution: solvedGame
      }

    else
      return false

  {Piece, Game, arrayToGame, solve}
