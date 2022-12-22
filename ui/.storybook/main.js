module.exports = {
    stories: [
        '../src/**/*.stories.mdx',
        '../src/**/*.stories.@(js|jsx|ts|tsx)',
    ],
    addons: [
        '@storybook/addon-links',
        '@storybook/addon-essentials',
        '@storybook/addon-interactions',
        {
            name: '@storybook/preset-create-react-app',
            options: {
                scriptsPackageName: 'react-scripts',
            },
        },
        '@chakra-ui/storybook-addon',
    ],
    features: {
        emotionAlias: false,
    },
    framework: '@storybook/react',
    core: {
        builder: '@storybook/builder-webpack5',
    },
    env: (config) => ({
        ...config,
    }),
}
