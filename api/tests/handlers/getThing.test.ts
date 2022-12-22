import { APIGatewayEvent } from 'aws-lambda'
import { handler } from '../../src/handlers/getThing'

describe('thingHandler', () => {
    it('returns 200 with the thing response', async () => {
        const event: Partial<APIGatewayEvent> = {}
        const response = await handler(event as APIGatewayEvent)
        expect(response.statusCode).toEqual(200)
        expect(JSON.parse(response.body)).toStrictEqual({
            thingProperty:
                'A thing that was fetched by our real api! (and a shared component: 2)',
        })
    })
})

export default {}
