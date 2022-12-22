export const Url =
    process.env.URL ??
    (() => {
        throw new Error('URL not configured!')
    })()

export const ExpectedMessage =
    process.env.EXPECTED_MESSAGE ??
    (() => {
        throw new Error('EXPECTED_MESSAGE not configured!')
    })()
