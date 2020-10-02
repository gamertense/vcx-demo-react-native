//
//  VcxWrapper.swift
//  ReactNativeVcx
//
//  Created by Vatcharat Rattananun on 1/10/2563 BE.
//

import Foundation
import vcx

@objc(VcxWrapper)
class VcxWrapper: NSObject {
  // Need this to suppress the warning "overrides `constantsToExport` but doesn't implement `requiresMainQueueSetup`
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc(agentProvisionAsync: resolver: rejecter:)
  func agentProvisionAsync(config: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().agentProvisionAsync(config) { error, config in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[agentProvisionAsync]: \(error.domain) :: \(code)", error)
      } else {
        resolve(config ?? "")
      }
    }
  }

  @objc(getGenesisPathWithConfig: fileName: resolver: rejecter:)
  func getGenesisPathWithConfig(config: String, fileName: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let fileURL = dir.appendingPathComponent("\(fileName).txn")

      do {
        try config.write(to: fileURL, atomically: true, encoding: .utf8)
        resolve(fileURL.path)
      } catch {
        resolve("error while creating genesis file")
      }
    }
  }

  @objc(initWithConfig: resolver: rejecter:)
  func initWithConfig(config: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().initWithConfig(config) { error in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[initWithConfig]: \(error.domain) :: \(code)", error)
      } else {
        resolve(true)
      }
    }
  }

  @objc(connectionCreateWithInvite: inviteDetails: resolver: rejecter:)
  func connectionCreateWithInvite(invitationId: String, inviteDetails: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().connectionCreate(withInvite: invitationId, inviteDetails: inviteDetails) { error, connectionHandle in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[connectionCreateWithInvite]: \(error.domain) :: \(code)", error)
      } else {
        resolve(connectionHandle)
      }
    }
  }

  @objc(connectionConnect: connectionType: resolver: rejecter:)
  func connectionConnect(connectionHandle: Int, connectionType: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().connectionConnect(VcxHandle(truncatingIfNeeded: connectionHandle), connectionType: connectionType) { error, inviteDetails in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[connectionConnect]: \(error.domain) :: \(code)", error)
      } else {
        resolve(inviteDetails)
      }
    }
  }

  @objc(connectionUpdateState: resolver: rejecter:)
  func connectionUpdateState(connectionHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().connectionUpdateState(connectionHandle) { error, state in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[connectionUpdateState]: \(error.domain) :: \(code)", error)
      } else {
        resolve(state)
      }
    }
  }

  @objc(connectionGetState: resolver: rejecter:)
  func connectionGetState(connectionHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().connectionGetState(connectionHandle) { error, state in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[connectionGetState]: \(error.domain) :: \(code)", error)
      } else {
        resolve(state)
      }
    }
  }

  @objc(connectionSerialize: resolver: rejecter:)
  func connectionSerialize(connectionHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().connectionSerialize(connectionHandle) { error, serializedConnection in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[connectionSerialize]: \(error.domain) :: \(code)", error)
      } else {
        resolve(serializedConnection)
      }
    }
  }

  @objc(connectionDeserialize: resolver: rejecter:)
  func connectionDeserialize(serializedConnection: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().connectionDeserialize(serializedConnection) { error, connectionHandle in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[connectionDeserialize]: \(error.domain) :: \(code)", error)
      } else {
        resolve(connectionHandle)
      }
    }
  }

  @objc(connectionRelease:)
  func connectionRelease(connectionHandle: Int) -> Int {
    return Int(ConnectMeVcx().connectionRelease(connectionHandle))
  }

  @objc(credentialGetOffers: resolver: rejecter:)
  func credentialGetOffers(connectionHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().credentialGetOffers(VcxHandle(truncatingIfNeeded: connectionHandle)) { error, offers in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[credentialGetOffers]: \(error.domain) :: \(code)", error)
      } else {
        resolve(offers)
      }
    }
  }

  @objc(credentialCreateWithOffer: credentialOffer: resolver: rejecter:)
  func credentialCreateWithOffer(sourceId: String, credentialOffer: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().credentialCreate(withOffer: sourceId, offer: credentialOffer) { error, credentialHandle in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[credentialCreateWithOffer]: \(error.domain) :: \(code)", error)
      } else {
        resolve(credentialHandle)
      }
    }
  }

  @objc(credentialSendRequest: connectionHandle: paymentHandle: resolver: rejecter:)
  func credentialSendRequest(credentialHandle: Int, connectionHandle: Int, paymentHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().credentialSendRequest(credentialHandle, connectionHandle: VcxHandle(truncatingIfNeeded: connectionHandle), paymentHandle: vcx_payment_handle_t(paymentHandle)) { error in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[credentialSendRequest]: \(error.domain) :: \(code)", error)
      } else {
        resolve("")
      }
    }
  }

  @objc(credentialUpdateState: resolver: rejecter:)
  func credentialUpdateState(credentialHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().credentialUpdateState(credentialHandle) { error, state in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[credentialUpdateState]: \(error.domain) :: \(code)", error)
      } else {
        resolve(state)
      }
    }
  }

  @objc(credentialGetState: resolver: rejecter:)
  func credentialGetState(credentialHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().credentialGetState(credentialHandle) { error, state in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[credentialGetState]: \(error.domain) :: \(code)", error)
      } else {
        resolve(state)
      }
    }
  }

  @objc(credentialSerialize: resolver: rejecter:)
  func credentialSerialize(credentialHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().credentialSerialize(credentialHandle) { error, serializedCredential in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[credentialSerialize]: \(error.domain) :: \(code)", error)
      } else {
        resolve(serializedCredential)
      }
    }
  }

  @objc(credentialDeserialize: resolver: rejecter:)
  func credentialDeserialize(serializedCredential: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().credentialDeserialize(serializedCredential) { error, credentialHandle in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[credentialDeserialize]: \(error.domain) :: \(code)", error)
      } else {
        resolve(credentialHandle)
      }
    }
  }

  @objc(credentialRelease:)
  func credentialRelease(credentialHandle: Int) -> Int {
    return Int(ConnectMeVcx().connectionRelease(credentialHandle))
  }

  @objc(getCredential: resolver: rejecter:)
  func getCredential(credentialHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().getCredential(credentialHandle) { error, credential in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[getCredential]: \(error.domain) :: \(code)", error)
      } else {
        resolve(credential)
      }
    }
  }

// TODO: Upgrade libvcx to have this method
//  @objc(deleteCredential: resolver: rejecter:)
//  func deleteCredential(credentialHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
//    ConnectMeVcx().deleteCredential(credentialHandle) { error in
//      if let error = error as NSError?, error.code != 0 {
//        let code = error.code
//        reject("\(code)", "[deleteCredential]: \(error.domain) :: \(code)", error)
//      } else {
//        resolve("")
//      }
//    }
//  }

  @objc(proofGetRequests: resolver: rejecter:)
  func proofGetRequests(connectionHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().proofGetRequests(connectionHandle) { error, requests in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[proofGetRequests]: \(error.domain) :: \(code)", error)
      } else {
        resolve(requests)
      }
    }
  }

  @objc(proofCreateWithRequest: proofRequest: resolver: rejecter:)
  func proofCreateWithRequest(sourceId: String, proofRequest: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().proofCreate(withRequest: sourceId, withProofRequest: proofRequest) { error, proofHandle in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[proofCreateWithRequest]: \(error.domain) :: \(code)", error)
      } else {
        resolve(proofHandle)
      }
    }
  }

  @objc(proofRetrieveCredentials: resolver: rejecter:)
  func proofRetrieveCredentials(proofHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().proofRetrieveCredentials(vcx_proof_handle_t(proofHandle)) { error, matchingCredentials in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[proofRetrieveCredentials]: \(error.domain) :: \(code)", error)
      } else {
        resolve(matchingCredentials)
      }
    }
  }

  @objc(proofGenerate: selectedCredentials: selfAttestedAttrs: resolver: rejecter:)
  func proofGenerate(proofHandle: Int, selectedCredentials: String, selfAttestedAttrs: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().proofGenerate(vcx_proof_handle_t(proofHandle), withSelectedCredentials: selectedCredentials, withSelfAttestedAttrs: selfAttestedAttrs) { error in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[proofGenerate]: \(error.domain) :: \(code)", error)
      } else {
        resolve("")
      }
    }
  }

  @objc(proofSend: connectionHandle: resolver: rejecter:)
  func proofSend(proofHandle: Int, connectionHandle: Int, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    ConnectMeVcx().proofSend(vcx_proof_handle_t(proofHandle), withConnectionHandle: vcx_connection_handle_t(connectionHandle)) { error in
      if let error = error as NSError?, error.code != 0 {
        let code = error.code
        reject("\(code)", "[proofSend]: \(error.domain) :: \(code)", error)
      } else {
        resolve("")
      }
    }
  }
}
