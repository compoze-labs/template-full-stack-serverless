import { test } from '@playwright/test'
import { ExpectedMessage, Url } from './config'

test.describe('our users journey', () => {
    test('should load the page correctly', async ({ page }) => {
        await page.goto(Url)
        await page
            .locator(`text="${ExpectedMessage}"`)
            .waitFor({ state: 'visible' })
    })
})
