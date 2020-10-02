import {NativeModules} from 'react-native'

import type {
  AgencyPoolConfig,
  VcxProvision,
  VcxProvisionResult,
  CxsInitConfig,
  VcxInitConfig,
  InitWithGenesisPathConfig,
} from './type-cxs'
import type {UserOneTimeInfo} from './type-user-store'
import type {invitationPayload} from './type-invitation'
import {convertVcxProvisionResultToUserOneTimeInfo, convertCxsInitToVcxInit} from './vcx-transformers'
import {GetClaimVcxResult} from './type-credential'

const {VcxWrapper} = NativeModules
const walletName = 'alice_wallet'

export async function createOneTimeInfo(agencyConfig: AgencyPoolConfig): Promise<UserOneTimeInfo> {
  const vcxProvisionConfig: VcxProvision = {
    agency_url: agencyConfig.agencyUrl,
    agency_did: agencyConfig.agencyDID,
    agency_verkey: agencyConfig.agencyVerificationKey,
    wallet_name: walletName,
    // FIXME: Remove hard-coded wallet key
    wallet_key: '123',
    protocol_type: '3.0',
    enterprise_seed: 'dowkKJsldfjo23irk4k3l523irk4k3l5',
    payment_method: 'null',
  }
  const provisionVcxResult: string = await VcxWrapper.agentProvisionAsync(JSON.stringify(vcxProvisionConfig))

  const provisionResult: VcxProvisionResult = JSON.parse(provisionVcxResult)
  return convertVcxProvisionResultToUserOneTimeInfo(provisionResult)
}

export async function initWithConfig(config: CxsInitConfig, fileName: string): Promise<boolean> {
  const genesis_path: string = await VcxWrapper.getGenesisPathWithConfig(config.poolConfig, fileName)
  const initConfig: InitWithGenesisPathConfig = {
    ...config,
    genesis_path,
  }
  const vcxInitConfig: VcxInitConfig = await convertCxsInitToVcxInit(initConfig, walletName)
  return VcxWrapper.initWithConfig(JSON.stringify(vcxInitConfig))
}

export async function createConnectionWithInvite(id: string, inviteDetails: invitationPayload): Promise<number> {
  const connectionHandle: number = await VcxWrapper.connectionCreateWithInvite(id, JSON.stringify(inviteDetails))
  console.debug(`connectionHandle: ${connectionHandle}`)
  return connectionHandle
}

export async function acceptInvitationVcx(connectionHandle: number) {
  // hard coding connection options to QR type for now, because vcx needs connection options
  // API for vcx assumes that it is running on enterprise side and not from consumer side
  // hence it tries to create connection with connection type.
  // However, our need is not to create a connection but to create a connection instance
  // with existing invitation. So, for now for any invitation type QR or SMS
  // we are hard coding connection option to QR
  const connectionOptions = {connection_type: 'QR', phone: ''}
  const result: string = await VcxWrapper.connectionConnect(connectionHandle, JSON.stringify(connectionOptions))
  console.debug('acceptInvitationVcx result: ', result)
}

export async function getConnectionState(connectionHandle: number): Promise<number> {
  const state: number = await VcxWrapper.connectionGetState(connectionHandle)
  console.debug('getConnectionState() result (4 = accepted):', state)
  return state
}

export async function updateConnectionState(connectionHandle: number) {
  return VcxWrapper.connectionUpdateState(connectionHandle)
}

export async function serializeConnection(connectionHandle: number): Promise<string> {
  return VcxWrapper.connectionSerialize(connectionHandle)
}

export async function getHandleBySerializedConnection(serializedConnection: string): Promise<number> {
  const connectionHandle: number = await VcxWrapper.connectionDeserialize(serializedConnection)
  console.debug('connectionHandle:', connectionHandle, ' serializedConnection:', serializedConnection)
  return connectionHandle
}

export function connectionRelease(connectionHandle: number): number {
  return VcxWrapper.connectionRelease(connectionHandle)
}

export async function getCredentialOffers(connectionHandle: number): Promise<string> {
  return VcxWrapper.credentialGetOffers(connectionHandle)
}

export async function createCredentialWithOffer(sourceId: string, offer: string): Promise<number> {
  return await VcxWrapper.credentialCreateWithOffer(sourceId, offer)
}

export async function sendCredentialRequest(
  credentialHandle: number,
  connectionHandle: number,
  paymentHandle: number,
): Promise<void> {
  await VcxWrapper.credentialSendRequest(credentialHandle, connectionHandle, paymentHandle)
}

export async function getCredentialState(credentialHandle: number): Promise<number> {
  const state: number = await VcxWrapper.credentialGetState(credentialHandle)
  console.debug(`credentialState: ${state}`)
  return state
}

export async function updateCredentialState(credentialHandle: number) {
  const updatedState: number = await VcxWrapper.credentialUpdateState(credentialHandle)

  return updatedState
}

export async function serializeCredential(credentialHandle: number) {
  const serialized: string = await VcxWrapper.credentialSerialize(credentialHandle)

  return serialized
}

export async function getCredentialHandleBySerializedCredential(serializedCredential: string) {
  const credentialHandle: number = await VcxWrapper.credentialDeserialize(serializedCredential)

  return credentialHandle
}

export function credentialRelease(credentialHandle: number): number {
  return VcxWrapper.credentialRelease(credentialHandle)
}

export async function getClaimVcx(credentialHandle: number): Promise<GetClaimVcxResult> {
  const vcxClaimResult: string = await VcxWrapper.getCredential(credentialHandle)
  const vcxClaim = JSON.parse(vcxClaimResult)
  const {credential, credential_id} = vcxClaim

  if (!credential || !credential_id) {
    throw new Error('credential not found in vcx')
  }

  return {
    claimUuid: credential_id,
    claim: credential,
  }
}

export async function deleteCredential(credentialHandle: number) {
  return VcxWrapper.deleteCredential(credentialHandle)
}

export async function getProofRequests(connectionHandle: number): Promise<string> {
  return await VcxWrapper.proofGetRequests(connectionHandle)
}

export async function createProofWithRequest(sourceId: string, proofRequest: string): Promise<number> {
  return await VcxWrapper.proofCreateWithRequest(sourceId, proofRequest)
}

export async function retrieveProofCredentials(proofHandle: number): Promise<string> {
  return await VcxWrapper.proofRetrieveCredentials(proofHandle)
}

export async function generateProof(
  proofHandle: number,
  selectedCredentials: string,
  selfAttestedAttributes: string,
): Promise<void> {
  return await VcxWrapper.proofGenerate(proofHandle, selectedCredentials, selfAttestedAttributes)
}

export async function sendProof(proofHandle: number, connectionHandle: number): Promise<void> {
  return await VcxWrapper.proofSend(proofHandle, connectionHandle)
}
