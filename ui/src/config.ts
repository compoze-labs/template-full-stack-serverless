export const config = {
    USE_DEFAULT_EXAMPLE:
        getOrDefault('REACT_APP_USE_DEFAULT_EXAMPLE', 'false') === 'true',
    BACKEND_API: getOrDefault('REACT_APP_BACKEND_API', 'undefined'),
    DISPLAY_MESSAGE: getOrDefault(
        'REACT_APP_DISPLAY_MESSAGE',
        'Hello <not set>'
    ),
}

function getOrDefault(name: string, defaultVal: string): string {
    const envVar = process.env[name]
    if (!envVar) {
        return defaultVal
    } else {
        return envVar
    }
}
