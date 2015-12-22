# prisoner
Represent, solve and generate Unblock Me / Rush Hour style puzzle games in JavaScript.

Using
======
You can install with either `npm` or `bower`

    $ npm install prisoner

or

    $ bower install prisoner

The `prisoner.js` defines a module that works in Node, AMD or it will create a browser global (`prisoner`).

The module contains the following:

* Game({width, height, prisoner}) - a class that represents a state of the game and holds pieces. The constructor takes a width, height and prisoner (Piece) object. For example:

    ```
    game = new prisoner.Game({
      width: 4, height: 4, new prisoner.Piece({x: 2, y: 2}, {x: 3, y: 2})
    });
    ```

    * Game.addPiece(piece) - add a piece to the game.
    * Game.move(pieceNumber, direction, steps) - move a specific piece in a specific direction a specific number of steps. Returns `false` if the movement is invalid.
      `pieceNumber` is the zero based order the pieces were added. So the prisoner will always be `0`.

      `direction` is a boolean the represents whether or not the movement will be positive or negative. For example if the piece is horizontal, `false` will move it `right` and `true` will move it `left`. If the piece is vertical `false` will move it `up` and `true` will move it `down`.

      `steps` is the amount of moves it should take in that direction. Default is 1.

    * Game.canExit() - returns a boolean that represents if the prisoner can exit or not.

* arrayToGame(array) - converts a multidimensional array to a `Game`. For example:

    ```
    game = prisoner.arrayToGame([
      [2, 0, 0, 4, 0,  5],
      [2, 3, 3, 4, 0,  5],
      [2, 0, 1, 1, 10, 0],
      [6, 6, 6, 0, 10, 11],
      [0, 0, 8, 0, 10, 11],
      [7, 7, 8, 9, 9,  0]
    ]);
    ```

* solve(game) - solves the game and returns an object that contains a game representing the solution, an array of games that represent the steps needed to win and the diffs corresponding to each step ({solution, steps, diffs}). Returns false if it was unable to solve.

Representing a game
======
Let's represent the following game (taken from Unblock Me):

![Image of Unblock Me](https://raw.githubusercontent.com/benletchford/prisoner/master/unblock.png)

You can either create a new `Game` object yourself and add the pieces manually like this:

```
var game = new prisoner.Game({
  width: 6,
  height: 6,
  prisoner: new prisoner.Piece({x: 2, y: 2}, {x: 3, y: 2})
});

game.addPiece(new prisoner.Piece({x: 0, y: 0}, {x: 0, y: 2}));
game.addPiece(new prisoner.Piece({x: 1, y: 1}, {x: 2, y: 1}));
game.addPiece(new prisoner.Piece({x: 3, y: 0}, {x: 3, y: 1}));
game.addPiece(new prisoner.Piece({x: 5, y: 0}, {x: 5, y: 1}));
game.addPiece(new prisoner.Piece({x: 0, y: 3}, {x: 2, y: 3}));
game.addPiece(new prisoner.Piece({x: 0, y: 5}, {x: 1, y: 5}));
game.addPiece(new prisoner.Piece({x: 2, y: 4}, {x: 2, y: 5}));
game.addPiece(new prisoner.Piece({x: 3, y: 5}, {x: 4, y: 5}));
game.addPiece(new prisoner.Piece({x: 4, y: 2}, {x: 4, y: 4}));
game.addPiece(new prisoner.Piece({x: 5, y: 3}, {x: 5, y: 4}));
```

You can then check that the game is represented correctly:

```
>>> game.matrix
[
  [2, 0, 0, 4, 0,  5],
  [2, 3, 3, 4, 0,  5],
  [2, 0, 1, 1, 10, 0],
  [6, 6, 6, 0, 10, 11],
  [0, 0, 8, 0, 10, 11],
  [7, 7, 8, 9, 9,  0]
]
```

An alternative way to initialize a game is to use the `arrayToGame` function.

```
game = prisoner.arrayToGame([
  [2, 0, 0, 4, 0,  5],
  [2, 3, 3, 4, 0,  5],
  [2, 0, 1, 1, 10, 0],
  [6, 6, 6, 0, 10, 11],
  [0, 0, 8, 0, 10, 11],
  [7, 7, 8, 9, 9,  0]
]);
```

Solving a game
======
Let's solve the following game:

```
game = prisoner.arrayToGame([
  [2, 0, 0, 4, 0,  5],
  [2, 3, 3, 4, 0,  5],
  [2, 0, 1, 1, 10, 0],
  [6, 6, 6, 0, 10, 11],
  [0, 0, 8, 0, 10, 11],
  [7, 7, 8, 9, 9,  0]
]);

// `prisoner.solve` will return an object that has a `solution` game object.
solvedData = prisoner.solve(game);

>>> solvedData.solution.matrix
[
  [0, 0, 8, 4, 0,  5],
  [3, 3, 8, 4, 0,  5],
  [2, 1, 1, 0, 0,  0],
  [2, 6, 6, 6, 10, 0],
  [2, 0, 0, 0, 10, 11],
  [7, 7, 9, 9, 10, 11]
]
```

Generating a game
======
Coming soon...
