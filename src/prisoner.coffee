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

        num = @pieces.length

        for x in [piece.begin.x...piece.end.x + 1]
          for y in [piece.begin.y...piece.end.y + 1]
            @matrix[y][x] = num

      move: (i, direction) ->
        piece = @pieces[i]

        if piece.horizontal
          if direction
            if (piece.end.x + 1) < @matrix[0].length \
              and @matrix[piece.begin.y][piece.end.x + 1] == 0
                @matrix[piece.begin.y][piece.begin.x] = 0
                @matrix[piece.begin.y][piece.end.x + 1] = i + 1

                piece.begin.x += 1
                piece.end.x += 1

                return true

          else
            if (piece.begin.x - 1) >= 0 \
              and @matrix[piece.begin.y][piece.begin.x - 1] == 0
                @matrix[piece.begin.y][piece.end.x] = 0
                @matrix[piece.begin.y][piece.begin.x - 1] = i + 1

                piece.begin.x -= 1
                piece.end.x -= 1

                return true

        else
          if direction
            if (piece.end.y + 1) < @matrix.length \
              and @matrix[piece.end.y + 1][piece.begin.x] == 0
                @matrix[piece.begin.y][piece.begin.x] = 0
                @matrix[piece.end.y + 1][piece.begin.x] = i + 1

                piece.begin.y += 1
                piece.end.y += 1

                return true

          else
            if (piece.begin.y - 1) >= 0 \
              and @matrix[piece.begin.y - 1][piece.begin.x] == 0
                @matrix[piece.end.y][piece.begin.x] = 0
                @matrix[piece.begin.y - 1][piece.begin.x] = i + 1

                piece.begin.y -= 1
                piece.end.y -= 1

                return true

        false

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
        cloned_game = new Game
          width: @width
          height: @height
          prisoner: new Piece({
            x: @pieces[0].begin.x, y: @pieces[0].begin.y
          }, {
            x: @pieces[0].end.x, y: @pieces[0].end.y
          })

        for i in [1...@pieces.length]
          cloned_game.addPiece new Piece({
            x: @pieces[i].begin.x, y: @pieces[i].begin.y
          }, {
            x: @pieces[i].end.x, y: @pieces[i].end.y
          })

        cloned_game

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

  solve = (initial_game) ->
    checked = []
    queue   = [initial_game]

    while queue.length
      game = queue.pop()

      if game.canExit()
        return game

      else if checked.indexOf(JSON.stringify(game)) is -1
        json_game = JSON.stringify(game)
        checked.push json_game

        for i in [0...game.pieces.length]
          pos_game = game.clone()
          neg_game = game.clone()

          if pos_game.move(i, true)
            queue.push pos_game
          if neg_game.move(i, false)
            queue.push neg_game

    return false

  {Piece, Game, arrayToGame, solve}
