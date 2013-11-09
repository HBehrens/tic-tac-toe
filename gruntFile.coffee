module.exports = (grunt) ->

  grunt.loadNpmTasks lib for lib in require("matchdep").filterDev("grunt-*")

  # Default tasks
  grunt.registerTask 'default', ['jshint', 'build']
  grunt.registerTask 'build', ['clean', 'concat', 'uglify', 'recess', 'htmlrefs']
  grunt.registerTask 'release', ['gh-pages']

  grunt.registerTask 'timestamp', ->
    grunt.log.subhead Date()

  grunt.initConfig
    distdir: 'dist'
    pkg: grunt.file.readJSON('package.json')

    src:
      js: ['src/**/*.js']

    clean: ['<%= distdir %>/*']

    jshint: ['<%= src.js %>']

    concat:
      dist:
        src: ['vendor/**/*.js']
        dest: '<%= distdir %>/vendor.js'

    uglify:
      dist:
        files:
          '<%= distdir %>/<%= pkg.name %>.js': ['<%= src.js %>']
        options:
          sourceMap: '<%= distdir %>/<%= pkg.name %>.js.map'
          sourceMapRoot: '..'
          sourceMappingURL: (u) -> u.replace(/^dist\//, '')+'.map'

    recess:
      dist:
        files:
          '<%= distdir %>/<%= pkg.name %>.css': ['src/styles/stylesheet.css']
        options:
          compile: true
          compress: true

    htmlrefs:
      dist:
        src: ['src/index.html']
        dest: '<%= distdir %>'

    'gh-pages':
      options:
        base: '<%= distdir %>'
      src: ['**']

    watch:
      all:
        files: ['src/**/*']
        tasks: ['default', 'timestamp']