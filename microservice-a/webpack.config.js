'use strict'
const slsw = require('serverless-webpack')
const webpack = require('webpack')
const nodeExternals = require('webpack-node-externals')

module.exports = baseConfig(slsw, webpack, nodeExternals, __dirname)