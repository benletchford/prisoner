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
        var k, l, prisoner, ref, ref1, row, x, y;
        this.width = arg.width, this.height = arg.height, prisoner = arg.prisoner;
        this.matrix = [];
        for (y = k = 0, ref = this.width; 0 <= ref ? k < ref : k > ref; y = 0 <= ref ? ++k : --k) {
          row = [];
          for (x = l = 0, ref1 = this.height; 0 <= ref1 ? l < ref1 : l > ref1; x = 0 <= ref1 ? ++l : --l) {
            row.push(0);
          }
          this.matrix.push(row);
        }
        this.pieces = [];
        this.addPiece(prisoner);
      }

      _Class.prototype.addPiece = function(piece) {
        var designatedNum, k, ref, ref1, results, x, y;
        this.pieces.push(piece);
        designatedNum = this.pieces.length;
        results = [];
        for (x = k = ref = piece.begin.x, ref1 = piece.end.x + 1; ref <= ref1 ? k < ref1 : k > ref1; x = ref <= ref1 ? ++k : --k) {
          results.push((function() {
            var l, ref2, ref3, results1;
            results1 = [];
            for (y = l = ref2 = piece.begin.y, ref3 = piece.end.y + 1; ref2 <= ref3 ? l < ref3 : l > ref3; y = ref2 <= ref3 ? ++l : --l) {
              results1.push(this.matrix[y][x] = designatedNum);
            }
            return results1;
          }).call(this));
        }
        return results;
      };

      _Class.prototype.move = function(pieceIndex, direction, steps) {
        var cell, cellsThatNeedToBeEmpty, designatedNum, i, k, l, len, m, n, newBegin, newEnd, o, p, piece, q, r, ref, ref1, ref10, ref11, ref12, ref13, ref14, ref15, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9, s, x, y;
        if (steps == null) {
          steps = 1;
        }
        piece = this.pieces[pieceIndex];
        designatedNum = pieceIndex + 1;
        cellsThatNeedToBeEmpty = [];
        if (piece.horizontal) {
          if (direction) {
            if ((piece.end.x + steps) < this.width) {
              for (i = k = ref = piece.end.x + 1, ref1 = piece.end.x + steps; ref <= ref1 ? k <= ref1 : k >= ref1; i = ref <= ref1 ? ++k : --k) {
                cellsThatNeedToBeEmpty.push({
                  x: i,
                  y: piece.begin.y
                });
              }
            } else {
              return false;
            }
          } else {
            if ((piece.begin.x - steps) >= 0) {
              for (i = l = ref2 = piece.begin.x - 1, ref3 = piece.begin.x - steps; ref2 <= ref3 ? l <= ref3 : l >= ref3; i = ref2 <= ref3 ? ++l : --l) {
                cellsThatNeedToBeEmpty.push({
                  x: i,
                  y: piece.begin.y
                });
              }
            } else {
              return false;
            }
          }
        } else {
          if (direction) {
            if ((piece.end.y + steps) < this.height) {
              for (i = m = ref4 = piece.end.y + 1, ref5 = piece.end.y + steps; ref4 <= ref5 ? m <= ref5 : m >= ref5; i = ref4 <= ref5 ? ++m : --m) {
                cellsThatNeedToBeEmpty.push({
                  x: piece.begin.x,
                  y: i
                });
              }
            } else {
              return false;
            }
          } else {
            if ((piece.begin.y - steps) >= 0) {
              for (i = n = ref6 = piece.begin.y - 1, ref7 = piece.begin.y - steps; ref6 <= ref7 ? n <= ref7 : n >= ref7; i = ref6 <= ref7 ? ++n : --n) {
                cellsThatNeedToBeEmpty.push({
                  x: piece.begin.x,
                  y: i
                });
              }
            } else {
              return false;
            }
          }
        }
        for (o = 0, len = cellsThatNeedToBeEmpty.length; o < len; o++) {
          cell = cellsThatNeedToBeEmpty[o];
          if (this.matrix[cell.y][cell.x] !== 0) {
            return false;
          }
        }
        for (x = p = ref8 = piece.begin.x, ref9 = piece.end.x + 1; ref8 <= ref9 ? p < ref9 : p > ref9; x = ref8 <= ref9 ? ++p : --p) {
          for (y = q = ref10 = piece.begin.y, ref11 = piece.end.y + 1; ref10 <= ref11 ? q < ref11 : q > ref11; y = ref10 <= ref11 ? ++q : --q) {
            this.matrix[y][x] = 0;
          }
        }
        newBegin = {
          x: piece.begin.x,
          y: piece.begin.y
        };
        newEnd = {
          x: piece.end.x,
          y: piece.end.y
        };
        if (piece.horizontal) {
          if (direction) {
            newBegin.x += steps;
            newEnd.x += steps;
          } else {
            newBegin.x -= steps;
            newEnd.x -= steps;
          }
        } else {
          if (direction) {
            newBegin.y += steps;
            newEnd.y += steps;
          } else {
            newBegin.y -= steps;
            newEnd.y -= steps;
          }
        }
        piece.begin = newBegin;
        piece.end = newEnd;
        for (x = r = ref12 = piece.begin.x, ref13 = piece.end.x + 1; ref12 <= ref13 ? r < ref13 : r > ref13; x = ref12 <= ref13 ? ++r : --r) {
          for (y = s = ref14 = piece.begin.y, ref15 = piece.end.y + 1; ref14 <= ref15 ? s < ref15 : s > ref15; y = ref14 <= ref15 ? ++s : --s) {
            this.matrix[y][x] = designatedNum;
          }
        }
        return true;
      };

      _Class.prototype.canExit = function() {
        var k, l, prisoner, ref, ref1, ref2, ref3, x, y;
        prisoner = this.pieces[0];
        if (prisoner.horizontal) {
          for (x = k = ref = prisoner.end.x + 1, ref1 = this.width; ref <= ref1 ? k < ref1 : k > ref1; x = ref <= ref1 ? ++k : --k) {
            if (this.matrix[prisoner.end.y][x] !== 0) {
              return false;
            }
          }
        } else {
          for (y = l = ref2 = prisoner.end.y + 1, ref3 = this.height; ref2 <= ref3 ? l < ref3 : l > ref3; y = ref2 <= ref3 ? ++l : --l) {
            if (this.matrix[y][prisoner.end.x] !== 0) {
              return false;
            }
          }
        }
        return true;
      };

      _Class.prototype.clone = function() {
        var clonedGame, i, k, ref;
        clonedGame = new Game({
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
        for (i = k = 1, ref = this.pieces.length; 1 <= ref ? k < ref : k > ref; i = 1 <= ref ? ++k : --k) {
          clonedGame.addPiece(new Piece({
            x: this.pieces[i].begin.x,
            y: this.pieces[i].begin.y
          }, {
            x: this.pieces[i].end.x,
            y: this.pieces[i].end.y
          }));
        }
        return clonedGame;
      };

      return _Class;

    })();
    arrayToGame = function(array) {
      var arrayOfPoints, begin, end, game, height, i, k, l, m, n, pieces, ref, ref1, ref2, ref3, width, x, y;
      height = array.length;
      width = array[0].length;
      arrayOfPoints = [];
      for (y = k = 0, ref = height; 0 <= ref ? k < ref : k > ref; y = 0 <= ref ? ++k : --k) {
        for (x = l = 0, ref1 = width; 0 <= ref1 ? l < ref1 : l > ref1; x = 0 <= ref1 ? ++l : --l) {
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
      for (i = m = 1, ref2 = arrayOfPoints.length; 1 <= ref2 ? m < ref2 : m > ref2; i = 1 <= ref2 ? ++m : --m) {
        begin = arrayOfPoints[i][0];
        end = arrayOfPoints[i][arrayOfPoints[i].length - 1];
        pieces.push(new Piece(begin, end));
      }
      game = new Game({
        width: width,
        height: height,
        prisoner: pieces[0]
      });
      for (i = n = 1, ref3 = pieces.length; 1 <= ref3 ? n < ref3 : n > ref3; i = 1 <= ref3 ? ++n : --n) {
        game.addPiece(pieces[i]);
      }
      return game;
    };
    solve = function(initialGame) {
      var _findSolution, diffs, k, len, parent, solvedGame, step, steps;
      _findSolution = function(initialGame) {
        var checked, game, i, j, jsonGame, k, l, m, negGame, posGame, queue, ref;
        checked = [];
        queue = [initialGame];
        while (queue.length) {
          game = queue.shift();
          if (game.canExit()) {
            return game;
          }
          jsonGame = JSON.stringify(game.matrix);
          if (checked.indexOf(jsonGame) === -1) {
            checked.push(jsonGame);
            for (i = k = 0, ref = game.pieces.length; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
              for (j = l = 1; l <= 4; j = ++l) {
                posGame = game.clone();
                if (posGame.move(i, true, j)) {
                  posGame.parent = game;
                  posGame.diff = {
                    piece: i,
                    direction: true,
                    steps: j
                  };
                  queue.push(posGame);
                }
              }
              for (j = m = 1; m <= 4; j = ++m) {
                negGame = game.clone();
                if (negGame.move(i, false, j)) {
                  negGame.parent = game;
                  negGame.diff = {
                    piece: i,
                    direction: false,
                    steps: j
                  };
                  queue.push(negGame);
                }
              }
            }
          }
        }
        return false;
      };
      solvedGame = _findSolution(initialGame);
      if (solvedGame) {
        steps = [];
        steps.push(solvedGame);
        parent = solvedGame.parent;
        while (parent) {
          steps.push(parent);
          parent = parent.parent;
        }
        steps.pop();
        steps = steps.reverse();
        diffs = [];
        for (k = 0, len = steps.length; k < len; k++) {
          step = steps[k];
          diffs.push(step.diff);
          delete step.diff;
          delete step.parent;
        }
        return {
          diffs: diffs,
          steps: steps,
          solution: solvedGame
        };
      } else {
        return false;
      }
    };
    return {
      Piece: Piece,
      Game: Game,
      arrayToGame: arrayToGame,
      solve: solve
    };
  });

}).call(this);
