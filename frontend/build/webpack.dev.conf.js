'use strict'
const webpack = require('webpack')
const merge = require('webpack-merge')
const path = require('path')
/* global module, __dirname */

module.exports = {
    entry: "./src/entry.js",
    output: {
        path: __dirname,
        filename: "bundle.js"
    },
    mode: 'development',
    module: {
        rules: [
            { test: /\.css$/, loader: "style!css" }
        ]
    },
    devServer: {
        contentBase: 'dist',
        disableHostCheck: true
    },
};
