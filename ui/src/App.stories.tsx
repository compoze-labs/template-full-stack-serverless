import React from 'react'
import { ComponentStory, ComponentMeta } from '@storybook/react'
import App from './App'
import { BackendApiClientTestDouble } from './__fixtures__/BackendApiClientTestDouble'

export default {
    title: 'App',
    component: App,
    parameters: {
        // More on Story layout: https://storybook.js.org/docs/react/configure/story-layout
        layout: 'fullscreen',
    },
} as ComponentMeta<typeof App>

const Template: ComponentStory<typeof App> = () => (
    <App backendApiClient={new BackendApiClientTestDouble()} />
)

export const Default = Template.bind({})
