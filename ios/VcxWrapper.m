//
//  VcxWrapper.m
//  ReactNativeVcx
//
//  Created by Vatcharat Rattananun on 1/10/2563 BE.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(VcxWrapper, NSObject)

RCT_EXTERN_METHOD(agentProvisionAsync: (NSString *)config
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(getGenesisPathWithConfig: (NSString *)config
                  fileName: (NSString *)fileName
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(initWithConfig: (NSString *)config
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(connectionCreateWithInvite: (NSString *)invitationId
                  inviteDetails: (NSString *)inviteDetails
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(connectionConnect: (int)connectionHandle
                  connectionType: (NSString *)connectionType
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(connectionUpdateState: (int)connectionHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(connectionGetState: (int)connectionHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(connectionSerialize: (int)connectionHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(connectionDeserialize: (NSString *)serializedConnection
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(connectionRelease: (int)connectionHandle)

RCT_EXTERN_METHOD(credentialGetOffers: (int)connectionHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(credentialCreateWithOffer: (NSString *)sourceId
                  credentialOffer: (NSString *)credentialOffer
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(credentialSendRequest: (int)credentialHandle
                  connectionHandle: (int)connectionHandle
                  paymentHandle: (int)paymentHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(credentialUpdateState: (int)credentialHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(credentialGetState: (int)credentialHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(credentialSerialize: (int)credentialHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(credentialDeserialize: (NSString *)serializedCredential
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(credentialRelease: (int)credentialHandle)

RCT_EXTERN_METHOD(getCredential: (int)credentialHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(deleteCredential: (int)credentialHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(proofGetRequests: (int)connectionHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(proofCreateWithRequest: (NSString *)sourceId
                  proofRequest: (NSString *)proofRequest
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(proofRetrieveCredentials: (int)proofHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(proofGenerate: (int)proofHandle
                  selectedCredentials: (NSString *)selectedCredentials
                  selfAttestedAttrs: (NSString *)selfAttestedAttrs
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

RCT_EXTERN_METHOD(proofSend: (int)proofHandle
                  connectionHandle: (int)connectionHandle
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                )

@end
