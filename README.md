# prisoner
Represent, solve and generate Unblock Me / Rush Hour style games.

Using
======
You can install with either `npm` or `bower`

    $ npm install prisoner

or

    $ bower install prisoner

The `prisoner.js` defines a module that works in Node, AMD or it will create a browser global (`prisoner`).

Representing a game
======
Let's represent the following game (taken from Unblock Me):

![Image of Yaktocat](https://raw.githubusercontent.com/benletchford/prisoner/master/unblock.png)

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
])

// `prisoner.solve` will return the solved state of the game - the state at which the prisoner can exit.
solvedGame = prisoner.solve(game); 
```

Because the `prisoner.solve` returns another game we have all the familiar functions, so the solved game looks like:

```
>>> solvedGame.matrix
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
