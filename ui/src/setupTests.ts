// jest-dom adds custom jest matchers for asserting on DOM nodes.
// allows you to do things like:
// expect(element).toHaveTextContent(/react/i)
// learn more: https://github.com/testing-library/jest-dom
import '@testing-library/jest-dom'

const original = { ...global.console }
global.console = {
    ...original,
    error: (...data: any[]) => {
        const firstLine = data[0] as string

        const ignoreIf = 'inside a test was not wrapped in act(...)'
        if (firstLine.indexOf(ignoreIf) === -1) {
            original.error(...data)
        }
    },
} as Console
