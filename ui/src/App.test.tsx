import React from 'react'
import { render, screen } from '@testing-library/react'
import App from './App'
import { BackendApiClientTestDouble } from './__fixtures__/BackendApiClientTestDouble'

describe('the App', () => {
    it('renders example', () => {
        render(<App backendApiClient={new BackendApiClientTestDouble()} />)
        const element = screen.getByText(/Hello local!/i)
        expect(element).toBeInTheDocument()
    })

    it('fetches the thing and displays the response', async () => {
        render(<App backendApiClient={new BackendApiClientTestDouble()} />)
        const element = await screen.findByText(
            /A thing that was fetched by our test double!/i
        )
        expect(element).toBeInTheDocument()
    })
})
