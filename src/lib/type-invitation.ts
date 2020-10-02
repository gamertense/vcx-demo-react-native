export type invitationPayload = {
  '@id': string
  '@type': string
  label: string
  recipientKeys: [string]
  routingKeys: [string, string]
  serviceEndpoint: string
}
