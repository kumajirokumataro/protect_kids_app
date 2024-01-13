const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
// scssを利用するためのloaderを追加
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
    })
)

module.exports = environment
