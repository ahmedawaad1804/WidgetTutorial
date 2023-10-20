import {NativeModules, Platform} from 'react-native';
import SharedGroupPreferences from 'react-native-shared-group-preferences';
const {WidgetRefresh} = NativeModules;

const DEFAULT_WIDGET_KEY = 'myWidgetKey'; // you can change it
const DEFAULT_WIDGET_GROUP_ID = 'group.cars.shared'; // you can change it

const setSharedData = async (
  payload: any,
  key = DEFAULT_WIDGET_KEY,
  groupId = DEFAULT_WIDGET_GROUP_ID,
) => {
  if (Platform.OS !== 'ios') {
    return;
  }
  try {
    await SharedGroupPreferences.setItem(key, payload, groupId);
    refreshWidgetHandler();
  } catch (error) {
    throw Error(error as any);
  }
};

const getSharedData = async (
  key = DEFAULT_WIDGET_KEY,
  groupId = DEFAULT_WIDGET_GROUP_ID,
) => {
  if (Platform.OS !== 'ios') {
    return;
  }
  try {
    return SharedGroupPreferences.getItem(key, groupId);
  } catch (error) {
    throw new Error(error as any);
  }
};

const refreshWidgetHandler = () => {
  if (Platform.OS !== 'ios') {
    return;
  }
  WidgetRefresh.refreshWidget();
};

export {setSharedData, getSharedData, refreshWidgetHandler};
