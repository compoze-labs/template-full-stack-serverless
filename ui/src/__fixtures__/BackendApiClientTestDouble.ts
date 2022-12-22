import { BackendApiClient } from '../data/BackendApiClient'
import { Thing } from '../domain/Thing'

export class BackendApiClientTestDouble implements BackendApiClient {
    async fetchThing(): Promise<Thing> {
        return {
            thingProperty: 'A thing that was fetched by our test double!',
        }
    }
}
