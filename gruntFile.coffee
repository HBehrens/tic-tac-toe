module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-contrib-jshint')

  # Default tasks
  grunt.registerTask('default', ['jshint']);

  grunt.initConfig
    src:
      js: ['src/**/*.js']

    jshint: ['<%= src.js %>']
