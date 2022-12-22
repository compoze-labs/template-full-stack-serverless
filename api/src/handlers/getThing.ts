/* eslint-disable @typescript-eslint/no-unused-vars */

import { APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda'
import { ThingDTO } from '../dtos/ThingDTO'
import { onePlusOne } from '@templatenametoreplace/example/exampleShared'

/* eslint-disable unused-imports/no-unused-vars */
export const handler = async (
    event: APIGatewayEvent
): Promise<APIGatewayProxyResult> => {
    const thing: ThingDTO = {
        thingProperty: `A thing that was fetched by our real api! (and a shared component: ${onePlusOne()})`,
    }

    return {
        statusCode: 200,
        body: JSON.stringify(thing),
        headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET',
        },
    }
}
