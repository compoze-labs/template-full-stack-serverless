import { BackendApiClientTestDouble } from '../__fixtures__/BackendApiClientTestDouble'
import { describeCovalentTest } from '../__fixtures__/CovalentTestPattern'
import { BackendApiClient, BackendApiClientImpl } from './BackendApiClient'

describeCovalentTest<BackendApiClient>(
    'BackendApiClient',
    () => Promise.resolve(new BackendApiClientImpl()),
    () => Promise.resolve(new BackendApiClientTestDouble()),
    (constructUnderTest) => {
        let underTest: BackendApiClient
        beforeAll(async () => {
            underTest = await constructUnderTest()
        })

        it('fetches the thing from the api', async () => {
            const result = await underTest.fetchThing()
            expect(result.thingProperty).toContain('thing that was fetched')
        })
    }
)
