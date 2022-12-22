import { ThingDTO } from '@/dto/ThingDTO'
import axios from 'axios'
import { config } from '../config'
import { Thing } from '../domain/Thing'

export interface BackendApiClient {
    fetchThing: () => Promise<Thing>
}

export class BackendApiClientImpl implements BackendApiClient {
    async get<T>(url: string): Promise<T> {
        const response = await axios.get(`${config.BACKEND_API}${url}`)
        return response.data as T
    }

    async fetchThing(): Promise<Thing> {
        return await this.get<ThingDTO>('/thing')
    }
}
