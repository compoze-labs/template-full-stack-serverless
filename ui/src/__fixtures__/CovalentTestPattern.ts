export function describeCovalentTest<TInterface>(
    name: string,
    constructImpl: () => Promise<TInterface>,
    constructTestDouble: () => Promise<TInterface>,
    fn: (constructUnderTest: () => Promise<TInterface>) => void
): void {
    describe(`${name} (test double)`, () => fn(constructTestDouble))

    if (process.env.INCLUDE_INTEGRATION === 'true') {
        describe(`${name} (impl)`, () => fn(constructImpl))
    } else {
        xdescribe(`${name} (impl)`, () => fn(constructImpl))
    }
}
