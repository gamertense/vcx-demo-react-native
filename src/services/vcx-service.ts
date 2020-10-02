import {agencyConfig} from '../config/agency'
import * as VcxWrapper from '../lib/RNCX'

export const provisionAgentAndWallet = async () => {
  console.log('on press provisionAgentAndWallet()')
  try {
    const oneTimeRes = await VcxWrapper.createOneTimeInfo(agencyConfig)

    const initConfig = {
      ...agencyConfig,
      ...oneTimeRes,
    }
    const initResult = await VcxWrapper.initWithConfig(initConfig, 'genesis.txn')
    if (initResult) {
      console.debug(`libvcx initilization successful`)
    } else {
      console.error('Error! initResult should be true, please see the log.')
    }
  } catch (err) {
    console.error('provisionAgentAndWallet', err.message)
    throw err
  }
}
