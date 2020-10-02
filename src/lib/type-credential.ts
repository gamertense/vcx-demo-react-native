export type VcxCredentialOffers = Array<Array<VcxCredentialOffer>>

// Offer object from vcx
export type VcxCredentialOffer = {
  claim_id: string
  claim_name: string
  cred_def_id: string
  credential_attrs: {
    content: string
    first_name: string
    last_name: string
  }
  from_did: string
  libindy_offer: string
  msg_ref_id: null
  msg_type: string
  schema_seq_no: number
  thread_id: string
  to_did: string
  version: string
}

export type SerializedCredential = {
  version: string
  data: {
    holder_sm: {
      state: {
        Finished: {
          cred_id: string
          credential: {
            '@id': string
            comment: string
            'credentials~attach': [
              {
                'mime-type': string
                '@id': string
                data: {
                  base64: string
                }
              },
            ]
            '~thread': {
              thid: string
              sender_order: number
              received_orders: {}
            }
          }
          status: string
        }
      }
      source_id: string
      thread_id: string
    }
  }
}

export type GetClaimVcxResult = {
  claimUuid: string
  claim: string // Claim
}

export type Claim = {
  claim_offer_id: string
  cred_def_id: string
  from_did: string
  libindy_cred: string // IndyCredential
  msg_type: string
  rev_reg_def_json: any
  version: number
}

export type IndyCredential = {
  cred_def_id: string
  rev_reg: any
  rev_reg_id: string
  schema_id: string
  signature: any
  signature_correctness_proof: any
  values: {
    content: IndyCredentialObj
    first_name: IndyCredentialObj
    last_name: IndyCredentialObj
  }
  witness: any
}
type IndyCredentialObj = {
  encoded: string
  raw: string
}
