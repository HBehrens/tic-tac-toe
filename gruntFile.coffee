module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-htmlrefs'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-recess'

  # Default tasks
  grunt.registerTask 'default', ['jshint', 'build']
  grunt.registerTask 'build', ['clean', 'concat', 'uglify', 'recess', 'htmlrefs']

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