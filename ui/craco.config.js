/* eslint-disable */
const { CracoAliasPlugin } = require('react-app-alias')

module.exports = {
    plugins: [
        {
            plugin: CracoAliasPlugin,
            options: {},
        },
    ],
    webpack: {
        configure: (webpackConfig) => {
            // ts-loader is required to reference external typescript projects/files (non-transpiled)
            // See: https://stackoverflow.com/questions/61034953/how-to-import-shared-typescript-code-using-create-react-app-no-eject
            webpackConfig.module.rules.push({
                test: /\.tsx?$/,
                loader: 'ts-loader',
                exclude: /node_modules/,
                options: {
                    transpileOnly: true,
                    configFile: 'tsconfig.json',
                },
            })

            return webpackConfig
        },
    },
}
