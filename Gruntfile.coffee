webpackBase =
  module:
    loaders: [
      test: /\.coffee$/, loader: 'coffee-loader'
    ]
  resolve:
    root: [
      '.'
    ]
    extensions: [
      '.js'
      '.coffee'
      ''
    ]

module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-webpack'
  grunt.loadNpmTasks 'grunt-mocha-phantomjs'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      prisoner:
        ['prisoner.js', 'prisoner.min.js']

    uglify:
      prisoner:
        files:
          'prisoner.min.js': 'prisoner.js'

    webpack:
      test:
        module:
          loaders: [
            test: /\.coffee$/, loader: 'coffee-loader'
          ]
        resolve:
          root: [
            '.'
          ]
          extensions: [
            '.js'
            '.coffee'
            ''
          ]
        entry: './test/specRunner.js'
        output:
          path: __dirname + '/test'
          filename: 'testBundle.js'

    mocha_phantomjs:
      options:
        reporter: 'dot'
      all: ['test/index.html']

    coffee:
      prisoner:
        files:
          'prisoner.js': 'src/prisoner.coffee'

  grunt.registerTask 'test', [
    'webpack:test'
    'mocha_phantomjs'
  ]

  grunt.registerTask 'build', [
    'clean:prisoner'
    'coffee'
    'uglify'
  ]
