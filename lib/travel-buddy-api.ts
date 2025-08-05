// Travel Buddy API Integration
// Based on https://travel-buddy.ai/api/

export interface TravelBuddyVisaRequirement {
  passport: string
  destination: string
  visa_required: boolean
  visa_type?: string
  max_stay?: string
  notes?: string
}

export interface TravelBuddyMapColor {
  countryCode: string
  color: 'red' | 'blue' | 'green' | 'yellow'
}

export interface TravelBuddyApiResponse {
  success: boolean
  data?: any
  error?: string
}

class TravelBuddyAPI {
  private apiKey: string
  private apiHost: string
  private baseUrl: string

  constructor() {
    this.apiKey = process.env.TRAVEL_BUDDY_API_KEY || process.env.NEXT_PUBLIC_TRAVEL_BUDDY_API_KEY || ''
    this.apiHost = process.env.TRAVEL_BUDDY_API_HOST || 'visa-requirement.p.rapidapi.com'
    this.baseUrl = `https://${this.apiHost}`
    
    console.log('🔑 Travel Buddy API initialized:', {
      hasKey: !!this.apiKey,
      keyLength: this.apiKey.length,
      host: this.apiHost
    })
  }

  private async makeRequest(endpoint: string, params: Record<string, string>): Promise<TravelBuddyApiResponse> {
    if (!this.apiKey) {
      return {
        success: false,
        error: 'Travel Buddy API key not configured'
      }
    }

    try {
      const url = `${this.baseUrl}${endpoint}`
      
      // Convert params to form data for POST request
      const formData = new URLSearchParams()
      Object.entries(params).forEach(([key, value]) => {
        formData.append(key, value)
      })

      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'X-RapidAPI-Key': this.apiKey,
          'X-RapidAPI-Host': this.apiHost,
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: formData
      })

      if (!response.ok) {
        return {
          success: false,
          error: `API request failed: ${response.status} ${response.statusText}`
        }
      }

      const data = await response.json()
      return {
        success: true,
        data
      }
    } catch (error) {
      return {
        success: false,
        error: `API request error: ${error instanceof Error ? error.message : 'Unknown error'}`
      }
    }
  }

  // Note: Individual visa requirement endpoint doesn't exist
  // Use getMapColors instead for all countries at once

  // Get map colors for a passport (all countries)
  async getMapColors(passport: string): Promise<TravelBuddyApiResponse> {
    return this.makeRequest('/map', {
      passport
    })
  }

  // Convert Travel Buddy color to our TravelStatus
  convertColorToStatus(color: string): string {
    switch (color) {
      case 'green':
        return 'visa_free'
      case 'blue':
        return 'visa_on_arrival'  // Fixed: blue = visa on arrival (per Travel Buddy website)
      case 'yellow':
        return 'eta_required'     // Fixed: yellow = eTA (per Travel Buddy website)
      case 'red':
        return 'consulate_visa'
      default:
        return 'consulate_visa'
    }
  }

  // Convert our TravelStatus to Travel Buddy color
  convertStatusToColor(status: string): string {
    switch (status) {
      case 'visa_free':
        return 'green'
      case 'eta_required':
        return 'yellow'  // Fixed: eTA maps to yellow
      case 'visa_on_arrival':
        return 'blue'    // Fixed: visa on arrival maps to blue
      case 'evisa':
        return 'red'     // eVisa maps to red
      case 'consulate_visa':
        return 'red'
      default:
        return 'red'
    }
  }
}

// Export singleton instance
export const travelBuddyAPI = new TravelBuddyAPI() 