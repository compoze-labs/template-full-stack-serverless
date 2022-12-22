import { Configuration } from 'webpack'
import path from 'path'
import fs from 'fs'
import TsconfigPathsPlugin from 'tsconfig-paths-webpack-plugin'

const handlers = fs.readdirSync('./src/handlers')
const entries: Record<string, string> = {}
handlers.forEach((s) => {
    entries[path.parse(s).name] = `./src/handlers/${s}`
})

const config: Configuration = {
    entry: entries,
    mode: 'production',
    module: {
        rules: [
            {
                test: /\.ts$/,
                use: {
                    loader: 'ts-loader',
                    options: {
                        transpileOnly: true,
                        projectReferences: true,
                    },
                },
                exclude: [/node_modules/, /tests/],
            },
        ],
    },
    resolve: {
        extensions: ['.ts', '.js'],
        plugins: [new TsconfigPathsPlugin({})],
    },
    output: {
        filename: '[name].js',
        libraryTarget: 'commonjs2',
        path: path.resolve(__dirname, 'deploy'),
    },
    target: 'node',
}

export default config
