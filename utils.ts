import {Platform} from 'react-native';
import SharedGroupPreferences from 'react-native-shared-group-preferences';

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

export {setSharedData, getSharedData};
