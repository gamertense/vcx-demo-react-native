import React from 'react'
import {SafeAreaView, StyleSheet, StatusBar, Button, Alert} from 'react-native'

import {Colors} from 'react-native/Libraries/NewAppScreen'

import * as VcxService from './src/services/vcx-service'

const App = () => {
  const onProvisonWallet = async () => {
    try {
      await VcxService.provisionAgentAndWallet()
    } catch ({message}) {
      Alert.alert(message)
    }
  }

  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView style={styles.safeAreaView}>
        <Button onPress={onProvisonWallet} title="Provision agent and wallet" />
        {/*<Button
              onPress={onMakeConnection}
              title="Make Connection"
              accessibilityLabel="To make connection with an issuer"
          />*/}
      </SafeAreaView>
    </>
  )
}

const styles = StyleSheet.create({
  safeAreaView: {
    backgroundColor: Colors.lighter,
  },
})

export default App
