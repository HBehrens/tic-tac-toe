module.exports = (config) ->
    config.set
        basePath: '../..'
        frameworks: ["mocha", "chai"]
        files: [
            'dist/vendor.js',
            'dist/tic-tac-toe.js',
            'test/**/*.spec.coffee'
        ]
        reporters: 'progress'
        urlRoot: '/__test/'
        colors: true
        autoWatch: false
        autoWatchInterval: 0
        browsers: ['PhantomJS']
        singleRun: true
