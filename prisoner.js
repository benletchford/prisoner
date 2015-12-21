(function() {
  (function(root, factory) {
    if (typeof define === 'function' && define.amd) {
      define([], factory);
    } else if (typeof module === 'object' && module.exports) {
      module.exports = factory();
    } else {
      root.prisoner = factory();
    }
  })(this, function() {
    var Game, Piece, arrayToGame, solve;
    Piece = (function() {
      function _Class(begin1, end1) {
        this.begin = begin1;
        this.end = end1;
        this.horizontal = this.begin.y === this.end.y;
        if ((this.begin.x > this.end.x || this.begin.y > this.end.y) || (this.begin.x === this.end.x && this.begin.y === this.end.y)) {
          throw new Error("Piece coordinates aren't valid.");
        }
      }

      return _Class;

    })();
    Game = (function() {
      function _Class(arg) {
        var j, k, prisoner, ref, ref1, row, x, y;
        this.width = arg.width, this.height = arg.height, prisoner = arg.prisoner;
        this.matrix = [];
        for (y = j = 0, ref = this.width; 0 <= ref ? j < ref : j > ref; y = 0 <= ref ? ++j : --j) {
          row = [];
          for (x = k = 0, ref1 = this.height; 0 <= ref1 ? k < ref1 : k > ref1; x = 0 <= ref1 ? ++k : --k) {
            row.push(0);
          }
          this.matrix.push(row);
        }
        this.pieces = [];
        this.addPiece(prisoner);
      }

      _Class.prototype.addPiece = function(piece) {
        var j, num, ref, ref1, results, x, y;
        this.pieces.push(piece);
        num = this.pieces.length;
        results = [];
        for (x = j = ref = piece.begin.x, ref1 = piece.end.x + 1; ref <= ref1 ? j < ref1 : j > ref1; x = ref <= ref1 ? ++j : --j) {
          results.push((function() {
            var k, ref2, ref3, results1;
            results1 = [];
            for (y = k = ref2 = piece.begin.y, ref3 = piece.end.y + 1; ref2 <= ref3 ? k < ref3 : k > ref3; y = ref2 <= ref3 ? ++k : --k) {
              results1.push(this.matrix[y][x] = num);
            }
            return results1;
          }).call(this));
        }
        return results;
      };

      _Class.prototype.move = function(i, direction) {
        var piece;
        piece = this.pieces[i];
        if (piece.horizontal) {
          if (direction) {
            if ((piece.end.x + 1) < this.matrix[0].length && this.matrix[piece.begin.y][piece.end.x + 1] === 0) {
              this.matrix[piece.begin.y][piece.begin.x] = 0;
              this.matrix[piece.begin.y][piece.end.x + 1] = i + 1;
              piece.begin.x += 1;
              piece.end.x += 1;
              return true;
            }
          } else {
            if ((piece.begin.x - 1) >= 0 && this.matrix[piece.begin.y][piece.begin.x - 1] === 0) {
              this.matrix[piece.begin.y][piece.end.x] = 0;
              this.matrix[piece.begin.y][piece.begin.x - 1] = i + 1;
              piece.begin.x -= 1;
              piece.end.x -= 1;
              return true;
            }
          }
        } else {
          if (direction) {
            if ((piece.end.y + 1) < this.matrix.length && this.matrix[piece.end.y + 1][piece.begin.x] === 0) {
              this.matrix[piece.begin.y][piece.begin.x] = 0;
              this.matrix[piece.end.y + 1][piece.begin.x] = i + 1;
              piece.begin.y += 1;
              piece.end.y += 1;
              return true;
            }
          } else {
            if ((piece.begin.y - 1) >= 0 && this.matrix[piece.begin.y - 1][piece.begin.x] === 0) {
              this.matrix[piece.end.y][piece.begin.x] = 0;
              this.matrix[piece.begin.y - 1][piece.begin.x] = i + 1;
              piece.begin.y -= 1;
              piece.end.y -= 1;
              return true;
            }
          }
        }
        return false;
      };

      _Class.prototype.canExit = function() {
        var j, k, prisoner, ref, ref1, ref2, ref3, x, y;
        prisoner = this.pieces[0];
        if (prisoner.horizontal) {
          for (x = j = ref = prisoner.end.x + 1, ref1 = this.width; ref <= ref1 ? j < ref1 : j > ref1; x = ref <= ref1 ? ++j : --j) {
            if (this.matrix[prisoner.end.y][x] !== 0) {
              return false;
            }
          }
        } else {
          for (y = k = ref2 = prisoner.end.y + 1, ref3 = this.height; ref2 <= ref3 ? k < ref3 : k > ref3; y = ref2 <= ref3 ? ++k : --k) {
            if (this.matrix[y][prisoner.end.x] !== 0) {
              return false;
            }
          }
        }
        return true;
      };

      _Class.prototype.clone = function() {
        var cloned_game, i, j, ref;
        cloned_game = new Game({
          width: this.width,
          height: this.height,
          prisoner: new Piece({
            x: this.pieces[0].begin.x,
            y: this.pieces[0].begin.y
          }, {
            x: this.pieces[0].end.x,
            y: this.pieces[0].end.y
          })
        });
        for (i = j = 1, ref = this.pieces.length; 1 <= ref ? j < ref : j > ref; i = 1 <= ref ? ++j : --j) {
          cloned_game.addPiece(new Piece({
            x: this.pieces[i].begin.x,
            y: this.pieces[i].begin.y
          }, {
            x: this.pieces[i].end.x,
            y: this.pieces[i].end.y
          }));
        }
        return cloned_game;
      };

      return _Class;

    })();
    arrayToGame = function(array) {
      var arrayOfPoints, begin, end, game, height, i, j, k, l, m, pieces, ref, ref1, ref2, ref3, width, x, y;
      height = array.length;
      width = array[0].length;
      arrayOfPoints = [];
      for (y = j = 0, ref = height; 0 <= ref ? j < ref : j > ref; y = 0 <= ref ? ++j : --j) {
        for (x = k = 0, ref1 = width; 0 <= ref1 ? k < ref1 : k > ref1; x = 0 <= ref1 ? ++k : --k) {
          if (!arrayOfPoints[array[y][x]]) {
            arrayOfPoints[array[y][x]] = [];
          }
          arrayOfPoints[array[y][x]].push({
            x: x,
            y: y
          });
        }
      }
      pieces = [];
      for (i = l = 1, ref2 = arrayOfPoints.length; 1 <= ref2 ? l < ref2 : l > ref2; i = 1 <= ref2 ? ++l : --l) {
        begin = arrayOfPoints[i][0];
        end = arrayOfPoints[i][arrayOfPoints[i].length - 1];
        pieces.push(new Piece(begin, end));
      }
      game = new Game({
        width: width,
        height: height,
        prisoner: pieces[0]
      });
      for (i = m = 1, ref3 = pieces.length; 1 <= ref3 ? m < ref3 : m > ref3; i = 1 <= ref3 ? ++m : --m) {
        game.addPiece(pieces[i]);
      }
      return game;
    };
    solve = function(initial_game) {
      var checked, game, i, j, json_game, neg_game, pos_game, queue, ref;
      checked = [];
      queue = [initial_game];
      while (queue.length) {
        game = queue.pop();
        if (game.canExit()) {
          return game;
        } else if (checked.indexOf(JSON.stringify(game)) === -1) {
          json_game = JSON.stringify(game);
          checked.push(json_game);
          for (i = j = 0, ref = game.pieces.length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
            pos_game = game.clone();
            neg_game = game.clone();
            if (pos_game.move(i, true)) {
              queue.push(pos_game);
            }
            if (neg_game.move(i, false)) {
              queue.push(neg_game);
            }
          }
        }
      }
      return false;
    };
    return {
      Piece: Piece,
      Game: Game,
      arrayToGame: arrayToGame,
      solve: solve
    };
  });

}).call(this);
