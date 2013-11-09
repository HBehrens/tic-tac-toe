module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-htmlrefs'

  # Default tasks
  grunt.registerTask 'default', ['jshint', 'build']
  grunt.registerTask 'build', ['clean', 'concat', 'copy', 'htmlrefs']

  grunt.initConfig
    distdir: 'dist'
    pkg: grunt.file.readJSON('package.json')

    src:
      js: ['src/**/*.js']

    clean: ['<%= distdir %>/*']

    jshint: ['<%= src.js %>']

    concat:
      dist:
        src: ['vendor/**/*.js', '<%= src.js %>']
        dest: '<%= distdir %>/<%= pkg.name %>.js'

    copy:
      css:
        src: 'src/styles/stylesheet.css'
        dest: '<%= distdir %>/<%= pkg.name %>.css'

    htmlrefs:
      dist:
        src: ['src/index.html']
        dest: '<%= distdir %>'