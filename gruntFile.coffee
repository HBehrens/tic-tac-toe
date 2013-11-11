module.exports = (grunt) ->

  grunt.loadNpmTasks lib for lib in require("matchdep").filterDev("grunt-*")

  # Default tasks
  grunt.registerTask 'default', ['build']
  grunt.registerTask 'build', ['clean', 'coffee', 'concat', 'uglify', 'recess', 'jade']
  grunt.registerTask 'continuous', ['coffeelint', 'build', 'karma:unit']
  grunt.registerTask 'release', ['gh-pages']

  grunt.registerTask 'timestamp', ->
    grunt.log.subhead Date()

  karmaConfig = (configFile, customOptions) ->
    options = { configFile: configFile, keepalive: true }
    travisOptions = process.env.TRAVIS && { browsers: ['Firefox'], reporters: 'dots' }
    grunt.util._.extend options, customOptions, travisOptions

  grunt.initConfig
    distdir: 'dist'
    tempdir: 'temp'
    pkg: grunt.file.readJSON('package.json')

    src:
      coffee: ['src/**/*.coffee']

    clean: ['<%= distdir %>/*', '<%= tempdir %>/*']

    coffeelint:
      app: ['<%= src.coffee %>']

    coffee:
      dist:
        options: sourceMap: true
        files:
          '<%= tempdir %>/<%= pkg.name %>.js': ['<%= src.coffee %>']
          
    concat:
      dist:
        src: ['vendor/**/*.js']
        dest: '<%= distdir %>/vendor.js'

    uglify:
      dist:
        files:
          '<%= distdir %>/<%= pkg.name %>.js': ['<%= tempdir %>/<%= pkg.name %>.js']
        options:
          sourceMap: '<%= distdir %>/<%= pkg.name %>.js.map'
          sourceMapRoot: '..'
          sourceMappingURL: (u) -> u.replace(/^dist\//, '')+'.map'

    recess:
      dist:
        files:
          '<%= distdir %>/<%= pkg.name %>.css': ['src/styles/stylesheet.less']
        options:
          compile: true
          compress: true

    jade:
      dist:
        files:
          '<%= distdir %>/index.html' : ['src/index.jade']

    'gh-pages':
      options:
        base: '<%= distdir %>'
        repo: "https://#{process.env.GH_TOKEN}@github.com/HBehrens/tic-tac-toe.git" if process.env.TRAVIS
        silent: true  # so GH_TOKEN won't be printed into shell
      dist: ['**']

    watch:
      all:
        files: ['src/**/*']
        tasks: ['default', 'timestamp']

    karma:
      unit:
        options: karmaConfig('test/config/unit.coffee')
      watch:
        options: karmaConfig('test/config/unit.coffee', { singleRun:false, autoWatch: true})
