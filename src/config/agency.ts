import Config from 'react-native-config'
import {AgencyPoolConfig} from '../lib/type-cxs'

export const agencyConfig: AgencyPoolConfig = {
  agencyUrl: Config.AGENCY_URL,
  agencyDID: Config.AGENCY_DID,
  agencyVerificationKey: Config.AGENCY_VERIFICATION_KEY,
  poolConfig: `${Config.POOL_CONFIG_NODE_1}\n${Config.POOL_CONFIG_NODE_2}\n${Config.POOL_CONFIG_NODE_3}\n${Config.POOL_CONFIG_NODE_4}`,
}
