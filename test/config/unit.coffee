module.exports = (config) ->
    config.set
        basePath: '../..'
        frameworks: ["mocha", "chai"]
        files: [
            'vendor/**/*.js',
            'src/**/*.js',
            'test/**/*.spec.coffee'
        ]
        reporters: 'progress'
        urlRoot: '/__test/'
        colors: true
        autoWatch: false
        autoWatchInterval: 0
        browsers: ['PhantomJS']
        singleRun: true
