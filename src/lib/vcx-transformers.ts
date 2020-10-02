import type {VcxProvisionResult, InitWithGenesisPathConfig, VcxInitConfig} from './type-cxs'
import {UserOneTimeInfo} from './type-user-store'

export function convertVcxProvisionResultToUserOneTimeInfo(provision: VcxProvisionResult): UserOneTimeInfo {
  return {
    oneTimeAgencyDid: provision.institution_did,
    oneTimeAgencyVerificationKey: provision.institution_verkey,
    myOneTimeDid: provision.sdk_to_remote_did,
    myOneTimeVerificationKey: provision.sdk_to_remote_verkey,
    myOneTimeAgentDid: provision.remote_to_sdk_did,
    myOneTimeAgentVerificationKey: provision.remote_to_sdk_verkey,
  }
}

export async function convertCxsInitToVcxInit(
  init: InitWithGenesisPathConfig,
  walletName: string,
): Promise<VcxInitConfig> {
  return {
    agency_endpoint: init.agencyUrl,
    agency_did: init.agencyDID,
    agency_verkey: init.agencyVerificationKey,
    wallet_name: walletName,
    wallet_key: '123',
    protocol_version: '3.0',
    communication_method: 'aries',
    genesis_path: init.genesis_path,
    remote_to_sdk_did: init.myOneTimeAgentDid,
    remote_to_sdk_verkey: init.myOneTimeAgentVerificationKey,
    sdk_to_remote_did: init.myOneTimeDid,
    sdk_to_remote_verkey: init.myOneTimeVerificationKey,
    institution_name: 'some-random-name',
    institution_logo_url: 'https://robothash.com/logo.png',
    institution_did: init.oneTimeAgencyDid,
    institution_verkey: init.oneTimeAgencyVerificationKey,
  }
}
